//
//  RxSubjectViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/4.
//

import UIKit
import RxSwift
import RxCocoa

class RxSubjectViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        //publishSubject()
        //behaviorSubject()
        //replaySubject()
        behaviorRelay()
    }
    
}

extension RxSubjectViewController {
    
    fileprivate func publishSubject() {
        //PublishSubject 是最普通的 Subject，它不需要初始值就能创建。
        //PublishSubject 的订阅者从他们开始订阅的时间点起，可以收到订阅后 Subject 发出的新 Event，而不会收到他们在订阅前已发出的 Event。
        
        //创建publist
        let subject = PublishSubject<String>()
        ///由于当前没有任何订阅者,所以这条信息不会输出到控制台
        subject.onNext("111")
        
        //第一次订阅
        subject.subscribe { event in
            print("第一次订阅:\(event)")
        } onCompleted: {
            print("第一次订阅完成")
        }.disposed(by: disposeBag)
        
        //当前有一个订阅,则该信息会输出到控制台
        subject.onNext("222")
        
        //第二次订阅subject
        subject.subscribe { (event) in
            print("第二次订阅:\(event)")
        } onCompleted: {
            print("第二次订阅完成")
        }.disposed(by: disposeBag)

        
        //当前有两个订阅.则该信息会输出到控制台
        subject.onNext("333")
        
        //让subject 结束
        subject.onCompleted()
        
        
        //subject完成后会发生.next事件
        subject.onNext("444")
        
        //subject完成后它的所有订阅(包括结束后的订阅),都能收到subject的.completed事件
        subject.subscribe { (event) in
            print("第三次订阅:\(event)")
        }  onCompleted: {
            print("第三次订阅完成")
        }.disposed(by: disposeBag)
        
        /**
         第一次订阅:222
         第一次订阅:333
         第二次订阅:333
         第一次订阅完成
         第二次订阅完成
         第三次订阅完成
         */
    }
    
    fileprivate func behaviorSubject() {
        
        //当一个订阅者来订阅它的时候，这个订阅者会立即收到 BehaviorSubjects 上一个发出的 event。之后就跟正常的情况一样，它也会接收到 BehaviorSubject 之后发出的新的 event。
        
        //创建一个BehaviorSubject
        let subject = BehaviorSubject(value: "111")
        
        //第一次订阅subject
        subject.subscribe { (event) in
            print("第一次订阅\(event)")
        }.disposed(by: disposeBag)
        
        
        //发出next事件
        subject.onNext("222")
        
        //发出error事件
        subject.onError(NSError(domain: "local", code: 0, userInfo: nil))
        
        //第二次订阅
        subject.subscribe { (event) in
            print("第二次订阅\(event)")
        }.disposed(by: disposeBag)
        
        /**
         第一次订阅next(111)
         第一次订阅next(222)
         第一次订阅error(Error Domain=local Code=0 "(null)")
         第二次订阅error(Error Domain=local Code=0 "(null)")
         */
    }
    
    
    fileprivate func replaySubject() {
        
        //ReplaySubject 在创建时候需要设置一个 bufferSize，表示它对于它发送过的 event 的缓存个数。
        //比如一个 ReplaySubject 的 bufferSize 设置为 2，它发出了 3 个 .next 的 event，那么它会将后两个（最近的两个）event 给缓存起来。此时如果有一个 subscriber 订阅了这个 ReplaySubject，那么这个 subscriber 就会立即收到前面缓存的两个 .next 的 event。
        //如果一个 subscriber 订阅已经结束的 ReplaySubject，除了会收到缓存的 .next 的 event 外，还会收到那个终结的 .error 或者 .complete 的 event。
        
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        //连续发送三个next事件
        subject.onNext("111")
        subject.onNext("222")
        subject.onNext("333")

        //第1次订阅subject
        subject.subscribe { event in
            print("第1次订阅：", event)
        }.disposed(by: disposeBag)
         
        //再发送1个next事件
        subject.onNext("444")
         
        //第2次订阅subject
        subject.subscribe { event in
            print("第2次订阅：", event)
        }.disposed(by: disposeBag)
         
        //让subject结束
        subject.onCompleted()
         
        //第3次订阅subject
        subject.subscribe { event in
            print("第3次订阅：", event)
        }.disposed(by: disposeBag)
        
        /**
         第1次订阅： next(222)
         第1次订阅： next(333)
         第1次订阅： next(444)
         第2次订阅： next(333)
         第2次订阅： next(444)
         第1次订阅： completed
         第2次订阅： completed
         第3次订阅： next(333)
         第3次订阅： next(444)
         第3次订阅： completed
         */
    }
    
    
    fileprivate func behaviorRelay() {
        
        //BehaviorRelay 就是 BehaviorSubject 去掉终止事件 onError 或 onCompleted。
        //BehaviorRelay 具有 BehaviorSubject 的功能，能够向它的订阅者发出上一个 event 以及之后新创建的 event。
        //与 BehaviorSubject 不同的是，不需要也不能手动给 BehaviorReply 发送 completed 或者 error 事件来结束它（BehaviorRelay 会在销毁时也不会自动发送 .complete 的 event）。
        //BehaviorRelay 有一个 value 属性，我们通过这个属性可以获取最新值。而通过它的 accept() 方法可以对值进行修改。
        
        let subject = BehaviorRelay<String>(value: "111")
        
        //修改value值
        subject.accept("222")
        
        //第一次订阅
        subject.asObservable().subscribe { (event) in
            print("第一次订阅:\(event)")
        }.disposed(by: disposeBag)
        
        //修改value值
        subject.accept("333")
        
        //第二次订阅
        subject.asObservable().subscribe { (event) in
            print("第二次订阅:\(event)")
        }.disposed(by: disposeBag)
        
        //修改value值
        subject.accept("444")
        
        /**
         第一次订阅:next(222)
         第一次订阅:next(333)
         第二次订阅:next(333)
         第一次订阅:next(444)
         第二次订阅:next(444)
         */
    }
    
}
