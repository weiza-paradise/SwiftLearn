//
//  RxOperatorViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/5.
//

import UIKit
import RxCocoa
import RxSwift

enum MyError: Error {
    case A
    case B
}

class RxOperatorViewController: BaseViewController {
    
    //定义好每个事件里的值以及发送的时间
    private let times = [
        [ "value": 1.0, "time": 0.1 ],
        [ "value": 2.0, "time": 1.1 ],
        [ "value": 3.0, "time": 1.2 ],
        [ "value": 4.0, "time": 1.2 ],
        [ "value": 5.0, "time": 1.4 ],
        [ "value": 6.0, "time": 2.1 ]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        //变换操作符
        
        //buffer()
        //window()
        //map()
        //flatMap()
        //flatMapLatest()
        //flatMapFirst()
        //concatMap()
        //scan()
        //groupBy()
        
        
        //过滤操作符
        
        //filter()
        //distinctUntilChanged()
        //single()
        //elementAt()
        //ignoreElements()
        //take()
        //takeLast()
        //skip()
        //sample()
        //debounce()
        
        
        //条件和布尔操作符
        //amb()
        //takeWhile()
        //takeUntil()
        //skipWhile()
        //skipUntil()
        
        
        //结合操作符
        //startWith()
        //merge()
        //zip()
        //combineLatest()
        //withLatestFrom()
        //switchLatest()
        
        
        //算数,聚合操作
        //toArray()
        //reduce()
        //concat()
        
        //连续操作符
        //publish()
        //replay()
        //multicase()
        //refCount()
        //share()
        
        // 其他操作符
        //delay()
        //delaySubscription()
        //materialize()
        //dematerialize()
        //timeount()
        
        //错误操作符号
        //catchErrorJustReturn()
        //catchError()
        retry()
    }
    
}



extension RxOperatorViewController {
    
    func retry()  {
        
        //        使用该方法当遇到错误的时候，会重新订阅该序列。比如遇到网络请求失败时，可以进行重新连接。
        //        retry() 方法可以传入数字表示重试次数。不传的话只会重试一次。
        
        var count = 1
        let sequenceThatErrors = Observable<String>.create { (observer) in
            
            observer.onNext("a")
            observer.onNext("b")
            
            //让第一个订阅时发生错误
            if count == 1 {
                observer.onError(MyError.A)
                print("Error encountered")
                count += 1
            }
            
            observer.onNext("c")
            observer.onNext("d")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(2)  //重试2次（参数为空则只重试一次）
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         a
         b
         Error encountered
         a
         b
         c
         d
         */
    }
    
    fileprivate func catchError() {
        //        该方法可以捕获 error，并对其进行处理。
        //        同时还能返回另一个 Observable 序列进行订阅（切换到新的序列）。
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = Observable.of("1", "2", "3")
        
        sequenceThatFails
            .catchError({ (error) in
                print("Error:\(error)")
                return recoverySequence
            })
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
        /**
         a
         b
         c
         Error:A
         1
         2
         3
         */
        
    }
    
    fileprivate func catchErrorJustReturn() {
        //当遇到 error 事件的时候，就返回指定的值，然后结束。
        
        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("错误")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("a")
        sequenceThatFails.onNext("b")
        sequenceThatFails.onNext("c")
        sequenceThatFails.onError(MyError.A)
        sequenceThatFails.onNext("d")
        
        /**
         a
         b
         c
         错误
         */
    }
    
}

class AnyDisposable: Disposable {
    let _dispose: () -> Void
    
    init(_ disposable: Disposable) {
        _dispose = disposable.dispose
    }
    
    func dispose() {
        _dispose()
    }
}

extension RxOperatorViewController {
    
    //
    //    fileprivate func using() {
    //        //使用 using 操作符创建 Observable 时，同时会创建一个可被清除的资源，一旦 Observable 终止了，那么这个资源就会被清除掉了。
    //
    //        Observable<Int>.interval(RxTimeInterval.milliseconds(1000), scheduler: MainScheduler.instance)
    //            .do(
    //                onNext: { print("infinite$: \($0)") },
    //                onSubscribe: { print("开始订阅 infinite$")},
    //                onDispose: { print("销毁 infinite$")}
    //            )
    //
    //        Observable<Int>.interval(RxTimeInterval.milliseconds(5000), scheduler: MainScheduler.instance)
    //            .take(2)
    //            .do(
    //                onNext: { print("infinite$: \($0)") },
    //                onSubscribe: { print("开始订阅 infinite$")},
    //                onDispose: { print("销毁 infinite$")}
    //            )
    //
    //        let o: Observable<Int> = Observable.using({ () -> AnyDisposable in
    //                   return AnyDisposable(infiniteInterval$.subscribe())
    //               }, observableFactory: { _ in return limited$ }
    //               )
    //               o.subscribe()
    //
    //    }
    
    fileprivate func timeount() {
        
        //使用该操作符可以设置一个超时时间。如果源 Observable 在规定时间内没有发任何出元素，就产生一个超时的 error 事件。
        
        let times = [
            [ "value": 1, "time": 0 ],
            [ "value": 2, "time": 0.5 ],
            [ "value": 3, "time": 1.5 ],
            [ "value": 4, "time": 4 ],
            [ "value": 5, "time": 5 ]
        ]
        
        //使用该操作符可以设置一个超时时间。如果源 Observable 在规定时间内没有发任何出元素，就产生一个超时的 error 事件。
        Observable.from(times)
            .flatMap { (item) -> Observable<Any> in
                let value = item["value"]
                let time = item["time"]
                return Observable.of(Int(value!))
                    .delaySubscription(DispatchTimeInterval.seconds(Int(Double(time!))), scheduler: MainScheduler.instance)
            }
            .timeout(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            } onError: { (error) in
                print(error)
            }.disposed(by: disposeBag)
        
        /**
         
         */
    }
    
    
    fileprivate func dematerialize() {
        
        //该操作符的作用和 materialize 正好相反，它可以将 materialize 转换后的元素还原。
        Observable.of(1,2,1)
            .materialize()
            .dematerialize()
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        /**
         1
         2
         1
         */
    }
    
    fileprivate func materialize() {
        
        //该操作符可以将序列产生的事件，转换成元素。
        //通常一个有限的 Observable 将产生零个或者多个 onNext 事件，最后产生一个 onCompleted 或者 onError 事件。而 materialize 操作符会将 Observable 产生的这些事件全部转换成元素，然后发送出来。
        
        Observable.of(1,2,1)
            .materialize()
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        /**
         next(next(1))
         next(next(2))
         next(next(1))
         next(completed)
         completed
         */
        
    }
    
    fileprivate func delaySubscription() {
        
        Observable.of(1,2,1)
            .delaySubscription(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        /**
         1
         2
         1
         */
    }
    
    fileprivate func delay() {
        
        //该操作符会将 Observable 的所有元素都先拖延一段设定好的时间，然后才将它们发送出来。
        
        Observable.of(1,2,1)
            .delay(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        /*
         1
         2
         1
         */
    }
    
    
    fileprivate func share() {
        
        //该操作符将使得观察者共享源 Observable，并且缓存最新的 n 个元素，将这些元素直接发送给新的观察者。
        //简单来说 shareReplay 就是 replay 和 refCount 的组合。
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .share(replay: 5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 5)) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅1: 3
         订阅1: 4
         订阅2: 0
         订阅2: 1
         订阅2: 2
         订阅2: 3
         订阅2: 4
         订阅1: 5
         订阅2: 5
         订阅1: 6
         订阅2: 6
         订阅1: 7
         订阅2: 7
         订阅1: 8
         订阅2: 8
         
         */
        
    }
    
    fileprivate func refCount() {
        
        //refCount 操作符可以将可被连接的 Observable 转换为普通 Observable
        //即该操作符可以自动连接和断开可连接的 Observable。当第一个观察者对可连接的 Observable 订阅时，那么底层的 Observable 将被自动连接。当最后一个观察者离开时，那么底层的 Observable 将被自动断开连接。
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .publish()
            .refCount()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //第二个订阅者（延迟5秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 5)) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        /**
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅1: 3
         订阅1: 4
         订阅1: 5
         订阅2: 5
         订阅1: 6
         订阅2: 6
         订阅1: 7
         订阅2: 7
         订阅1: 8
         订阅2: 8
         订阅1: 9
         订阅2: 9
         */
    }
    
    
    fileprivate func multicase() {
        
        //multicast 方法同样是将一个正常的序列转换成一个可连接的序列。
        //同时 multicast 方法还可以传入一个 Subject，每当序列发送事件时都会触发这个 Subject 的发送。
        
        let subject = PublishSubject<Int>()
        
        _ = subject.subscribe(onNext: { print("subject: \($0)") } )
        
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .multicast(subject)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 2)) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 5)) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         subject: 0
         订阅1: 0
         subject: 1
         订阅1: 1
         subject: 2
         订阅1: 2
         订阅2: 2
         subject: 3
         订阅1: 3
         订阅2: 3
         subject: 4
         订阅1: 4
         订阅2: 4
         subject: 5
         订阅1: 5
         订阅2: 5
         subject: 6
         订阅1: 6
         订阅2: 6
         subject: 7
         订阅1: 7
         */
        
        
    }
    
    fileprivate func replay()  {
        
        //replay 同的 publish 方法相同之处在于：会将将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
        //replay 与 publish 不同在于：新的订阅者还能接收到订阅之前的事件消息（数量由设置的 bufferSize 决定）。
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .replay(5)
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 2)) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 5)) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅2: 0
         订阅2: 1
         订阅2: 2
         订阅1: 3
         订阅2: 3
         订阅1: 4
         订阅2: 4
         订阅1: 5
         */
        
    }
    
    
    fileprivate func publish() {
        //publish 方法会将一个正常的序列转换成一个可连接的序列。同时该序列不会立刻发送事件，只有在调用 connect 之后才会开始。
        
        //每隔1秒钟发送1个事件
        let interval = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .publish()
        
        //第一个订阅者（立刻开始订阅）
        _ = interval
            .subscribe(onNext: { print("订阅1: \($0)") })
        
        //相当于把事件消息推迟了两秒
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 2)) {
            _ = interval.connect()
        }
        
        //第二个订阅者（延迟5秒开始订阅）
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 5)) {
            _ = interval
                .subscribe(onNext: { print("订阅2: \($0)") })
        }
        
        /**
         订阅1: 0
         订阅1: 1
         订阅1: 2
         订阅1: 3
         订阅2: 3
         订阅1: 4
         订阅2: 4
         订阅1: 5
         订阅2: 5
         */
    }
    
}


extension RxOperatorViewController {
    
    fileprivate func concat() {
        //concat 会把多个 Observable 序列合并（串联）为一个 Observable 序列。
        //并且只有当前面一个 Observable 序列发出了 completed 事件，才会开始发送下一个 Observable 序列事件。
        
        let subject1 = BehaviorSubject(value: 1)
        let subject2 = BehaviorSubject(value: 2)
        
        let variable = BehaviorRelay(value: subject1)
        variable.asObservable()
            .concat()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject2.onNext(2)
        subject1.onNext(1)
        subject1.onNext(1)
        subject1.onCompleted()
        
        variable.accept(subject2)
        subject2.onNext(2)
        
        /**
         1
         1
         1
         2
         2
         
         */
    }
    
    fileprivate func reduce() {
        
        //reduce 接受一个初始值，和一个操作符号。
        //reduce 将给定的初始值，与序列里的每个值进行累计运算。得到一个最终结果，并将其作为单个值发送出去。
        
        Observable.of(1, 2, 3, 4, 5)
            .reduce(0, accumulator: +)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        
    }
    
    
    fileprivate func toArray() {
        
        Observable.of(1, 2, 3)
            .toArray()
            .subscribe({ print($0) })
            .disposed(by: disposeBag)
        /**
         [1,2,3]
         */
        
    }
    
}

extension RxOperatorViewController {
    
    
    fileprivate func switchLatest() {
        //switchLatest 有点像其他语言的 switch 方法，可以对事件流进行转换。
        //比如本来监听的 subject1，我可以通过更改 variable 里面的 value 更换事件源。变成监听 subject2。
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let variable = BehaviorRelay(value: subject1)
        
        variable.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject1.onNext("C")
        
        //改变事件源
        variable.accept(subject2)
        subject1.onNext("D")
        subject2.onNext("2")
        
        //改变事件源
        variable.accept(subject1)
        subject2.onNext("3")
        subject1.onNext("E")
        
        /**
         A
         B
         C
         1
         2
         D
         E
         */
        
    }
    
    
    fileprivate func withLatestFrom() {
        //该方法将两个 Observable 序列合并为一个。每当 self 队列发射一个元素时，便从第二个序列中取出最新的一个值
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        
        subject1.withLatestFrom(subject2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("A")
        subject2.onNext("1")
        subject1.onNext("B")
        subject1.onNext("C")
        subject2.onNext("2")
        subject1.onNext("D")
        
        /**
         1
         1
         2
         
         */
        
    }
    
    fileprivate func combineLatest() {
        //该方法同样是将多个（两个或两个以上的）Observable 序列元素进行合并。
        //但与 zip 不同的是，每当任意一个 Observable 有新的事件发出时，它会将每个 Observable 序列的最新的一个事件元素进行合并。
        
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.combineLatest(subject1, subject2) {
            "\($0)\($1)"
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
        
        /**
         1A
         2A
         2B
         2C
         2D
         3D
         4D
         5D
         */
        
    }
    
    fileprivate func zip() {
        
        //该方法可以将多个（两个或两个以上的）Observable 序列压缩成一个 Observable 序列。
        //而且它会等到每个 Observable 事件一一对应地凑齐之后再合并。
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<String>()
        
        Observable.zip(subject1, subject2) {
            "\($0)\($1)"
        }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
        
        subject1.onNext(1)
        subject2.onNext("A")
        subject1.onNext(2)
        subject2.onNext("B")
        subject2.onNext("C")
        subject2.onNext("D")
        subject1.onNext(3)
        subject1.onNext(4)
        subject1.onNext(5)
        
        
        /**
         1A
         2B
         3C
         4D
         */
        
        
        //比如我们想同时发送两个请求，只有当两个请求都成功后，再将两者的结果整合起来继续往下处理。这个功能就可以通过 zip 来实现
        
        /**
         //第一个请求
         let userRequest: Observable<User> = API.getUser("me")
         
         //第二个请求
         let friendsRequest: Observable<Friends> = API.getFriends("me")
         
         //将两个请求合并处理
         Observable.zip(userRequest, friendsRequest) {
         user, friends in
         //将两个信号合并成一个信号，并压缩成一个元组返回（两个信号均成功）
         return (user, friends)
         }
         .observeOn(MainScheduler.instance) //加这个是应为请求在后台线程，下面的绑定在前台线程。
         .subscribe(onNext: { (user, friends) in
         //将数据绑定到界面上
         //.......
         })
         .disposed(by: disposeBag)
         */
    }
    
    fileprivate func merge() {
        //该方法可以将多个（两个或两个以上的）Observable 序列合并成一个 Observable 序列。
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext(20)
        subject1.onNext(40)
        subject1.onNext(60)
        subject2.onNext(1)
        subject1.onNext(80)
        subject1.onNext(100)
        subject2.onNext(1)
        
        /**
         20
         40
         60
         1
         80
         100
         1
         */
    }
    
    fileprivate func startWith() {
        //该方法会在 Observable 序列开始之前插入一些事件元素。即发出事件消息之前，会先发出这些预先插入的事件消息
        
        Observable.of(3,4,5,6)
            .startWith(1)
            .startWith(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         1
         2
         3
         4
         5
         6
         */
    }
    
}

extension RxOperatorViewController {
    
    fileprivate func skipUntil() {
        //同上面的 takeUntil 一样，skipUntil 除了订阅源 Observable 外，通过 skipUntil 方法我们还可以监视另外一个 Observable， 即 notifier 。
        //与 takeUntil 相反的是。源 Observable 序列事件默认会一直跳过，直到 notifier 发出值或 complete 通知。
        let source   = PublishSubject<Int>()
        let notifier = PublishSubject<Int>()
        
        source
            .skipUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        source.onNext(2)
        source.onNext(3)
        source.onNext(4)
        source.onNext(5)
        
        //开始接收消息
        notifier.onNext(0)
        
        source.onNext(6)
        source.onNext(7)
        source.onNext(8)
        
        //仍然接受消息
        notifier.onNext(0)
        source.onNext(9)
        
        /**
         6
         7
         8
         9
         */
    }
    
    fileprivate func skipWhile() {
        //该方法用于跳过前面所有满足条件的事件。
        //一旦遇到不满足条件的事件，之后就不会再跳过了。
        Observable.of(1,2,3,4,5,6)
            .skipWhile{ $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         4
         5
         6
         */
        
    }
    
    fileprivate func takeUntil() {
        //takeUntil 操作符将镜像源 Observable，它同时观测第二个 Observable。一旦第二个 Observable 发出一个元素或者产生一个终止事件，那个镜像的 Observable 将立即终止。
        //除了订阅源 Observable 外，通过 takeUntil 方法我们还可以监视另外一个 Observable， 即 notifier。
        //如果 notifier 发出值或 complete 通知，那么源 Observable 便自动完成，停止发送事件。
        
        let source   = PublishSubject<String>()
        let notifier = PublishSubject<String>()
        
        source
            .takeUntil(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext("a")
        source.onNext("b")
        source.onNext("c")
        source.onNext("d")
        
        //停止接收消息
        notifier.onNext("z")
        
        source.onNext("e")
        source.onNext("f")
        source.onNext("g")
        
        /**
         a
         b
         c
         d
         */
    }
    
    
    fileprivate func takeWhile() {
        //该方法依次判断 Observable 序列的每一个值是否满足给定的条件。 当第一个不满足条件的值出现时，它便自动完成。
        //takeWhile 操作符将镜像源 Observable 直到某个元素的判定为 false。此时，这个镜像的 Observable 将立即终止。
        Observable.of(1,2,3,4,5,6)
            .takeWhile{ $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        /**
         1
         2
         3
         */
    }
    
    fileprivate func amb() {
        
        //当传入多个 Observables 到 amb 操作符时，它将取第一个发出元素或产生事件的 Observable，然后只发出它的元素。并忽略掉其他的 Observables。
        
        let subject1 = PublishSubject<Int>()
        let subject2 = PublishSubject<Int>()
        let subject3 = PublishSubject<Int>()
        
        subject1
            .amb(subject2)
            .amb(subject3)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        subject2.onNext(1)
        subject1.onNext(20)
        subject2.onNext(2)
        subject1.onNext(40)
        subject3.onNext(0)
        subject2.onNext(3)
        subject1.onNext(60)
        subject3.onNext(0)
        subject3.onNext(0)
        
        /**
         next(1)
         next(2)
         next(3)
         */
    }
    
}


extension RxOperatorViewController {
    
    fileprivate func filter() {
        //该操作符就是用来过滤掉某些不符合要求的事件。
        
        Observable.of(2,4,30,5,123,7,89)
            .filter { (number ) in
                number > 10
            }.subscribe { (element) in
                print(element)
            }.disposed(by: disposeBag)
        /**
         next(30)
         next(123)
         next(89)
         completed
         */
    }
    
    fileprivate func distinctUntilChanged() {
        //该操作符用于过滤掉连续重复的事件。
        Observable.of(1, 2, 3, 1, 1, 4)
            .distinctUntilChanged()
            .subscribe(onNext: {
                print($0)
            }).disposed(by: disposeBag)
        
        /**
         1
         2
         3
         1
         4
         */
    }
    
    fileprivate func single() {
        //限制只发送一次事件，或者满足条件的第一个事件。
        //如果存在有多个事件或者没有事件都会发出一个 error 事件。
        //如果只有一个事件，则不会发出 error 事件。
        
        Observable.of(1,2,3,4)
            .single { $0 == 2 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        Observable.of("a","b","c","d")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        /**
         2
         a
         Unhandled error happened: Sequence contains more than one element.
         */
    }
    
    fileprivate func elementAt() {
        
        //该方法实现只处理在指定位置的事件。
        
        Observable.of(1,2,3,4)
            .elementAt(2)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        /**
         next(3)
         */
    }
    
    fileprivate func ignoreElements() {
        //该操作符可以忽略掉所有的元素，只发出 error 或 completed 事件。
        //如果我们并不关心 Observable 的任何元素，只想知道 Observable 在什么时候终止，那就可以使用 ignoreElements 操作符。
        
        Observable.of(1,2,3,4)
            .ignoreElements()
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        /**
         cmpleted
         */
    }
    
    
    fileprivate func take() {
        //该方法实现仅发送 Observable 序列中的前 n 个事件，在满足数量之后会自动 .completed。
        
        Observable.of(1,2,3,4)
            .take(2)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        /**
         next(1)
         next(2)
         completed
         */
    }
    
    
    fileprivate func takeLast() {
        //该方法实现仅发送 Observable 序列中的后 n 个事件。
        Observable.of(1,2,3,4)
            .takeLast(2)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        /**
         next(3)
         next(4)
         completed
         */
    }
    
    
    fileprivate func skip() {
        
        //该方法用于跳过源 Observable 序列发出的前 n 个事件。
        
        Observable.of(1,2,3,4)
            .skip(2)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        /**
         next(3)
         next(4)
         completed
         */
    }
    
    
    fileprivate func sample() {
        //Sample 除了订阅源 Observable 外，还可以监视另外一个 Observable， 即 notifier 。
        //sample 操作符将不定期的对源 Observable 进行取样操作。通过第二个 Observable 来控制取样时机。一旦第二个 Observable 发出一个元素，就从源 Observable 中取出最后产生的元素。
        
        let source   = PublishSubject<Int>()
        let notifier = PublishSubject<String>()
        
        source
            .sample(notifier)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        source.onNext(1)
        
        //让源序列接收接收消息
        notifier.onNext("A")
        
        source.onNext(2)
        
        //让源序列接收接收消息
        notifier.onNext("B")
        notifier.onNext("C")
        
        source.onNext(3)
        source.onNext(4)
        
        //让源序列接收接收消息
        notifier.onNext("D")
        
        source.onNext(5)
        
        //让源序列接收接收消息
        notifier.onCompleted()
        
        /**
         1
         2
         4
         5
         */
    }
    
    
    fileprivate func debounce() {
        
        //debounce 操作符可以用来过滤掉高频产生的元素，它只会发出这种元素：该元素产生后，一段时间内没有新元素产生。
        //换句话说就是，队列中的元素如果和下一个元素的间隔小于了指定的时间间隔，那么这个元素将被过滤掉。
        //debounce 常用在用户输入的时候，不需要每个字母敲进去都发送一个事件，而是稍等一下取最后一个事件。
        
        //生成对应的 Observable 序列并订阅
        Observable.from(times)
            .flatMap { (item) -> Observable<Any> in
                let value = item["value"]
                let time = item["time"]
                return Observable.of(Double(value!))
                    .delaySubscription(DispatchTimeInterval.seconds(Int(Double(time!))), scheduler: MainScheduler.instance)
            }
            .debounce(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        /**
         next(6.0)
         completed
         */
    }
    
    
}


extension RxOperatorViewController {
    
    //MARK: - 变换操作符
    
    fileprivate func buffer() {
        
        //buffer: 缓存元素，然后将缓存的元素集合，周期性的发出来
        //buffer 方法作用是缓冲组合，第一个参数是缓冲时间，第二个参数是缓冲个数，第三个参数是线程。
        
        let subject = PublishSubject<String>()
        
        subject.buffer(timeSpan: DispatchTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        /**
         next(["a", "b", "c"])
         next(["1", "2", "3"])
         next([])
         next([])
         next([])
         next([])
         next([])
         next([])
         */
    }
    
    fileprivate func window()  {
        //将 Observable 分解为多个子 Observable，周期性的将子 Observable 发出来
        //window 操作符和 buffer 十分相似。不过 buffer 是周期性的将缓存的元素集合发送出来，而 window 周期性的将元素集合以 Observable 的形态发送出来。
        //同时 buffer 要等到元素搜集完毕后，才会发出元素序列。而 window 可以实时发出元素序列。
        
        let subject = PublishSubject<String>()
        
        subject.window(timeSpan: DispatchTimeInterval.seconds(1), count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] observable in
                print("observable\(observable)")
                observable.asObservable().subscribe { (event ) in
                    print(event)
                }.disposed(by:self!.disposeBag)
            }).disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        /**
         observableRxSwift.AddRef<Swift.String>
         next(a)
         next(b)
         next(c)
         completed
         observableRxSwift.AddRef<Swift.String>
         next(1)
         next(2)
         next(3)
         completed
         observableRxSwift.AddRef<Swift.String>
         completed
         observableRxSwift.AddRef<Swift.String>
         completed
         observableRxSwift.AddRef<Swift.String>
         completed
         observableRxSwift.AddRef<Swift.String>
         completed
         */
    }
    
    
    fileprivate func map() {
        
        //该操作符通过传入一个函数闭包把原来的 Observable 序列转变为一个新的 Observable 序列。
        
        Observable.of(1,2,3)
            .map { $0 * 10 }
            .subscribe(onNext: { (number) in
                print(number)
            }).disposed(by: disposeBag)
        
        /**
         10
         20
         30
         */
    }
    
    fileprivate func flatMap() {
        
        // map 在做转换的时候容易出现“升维”的情况。即转变之后，从一个序列变成了一个序列的序列。
        //而 flatMap 操作符会对源 Observable 的每一个元素应用一个转换方法，将他们转换成 Observables。 然后将这些 Observables 的元素合并之后再发送出来。即又将其 "拍扁"（降维）成一个 Observable 序列。
        //这个操作符是非常有用的。比如当 Observable 的元素本生拥有其他的 Observable 时，我们可以将所有子 Observables 的元素发送出来。
        
        
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let subject3 = BehaviorRelay(value: subject1)
        
        
        subject3.asObservable()
            .flatMap { $0 }
            .subscribe {(event) in
                print(event)
            }.disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject3.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        /**
         next(A)
         next(B)
         next(1)
         next(2)
         next(C)
         
         */
    }
    
    fileprivate func flatMapLatest() {
        
        //flatMapLatest 与 flatMap 的唯一区别是：flatMapLatest 只会接收最新的 value 事件。
        
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let subject3 = BehaviorRelay(value: subject1)
        
        
        subject3.asObservable()
            .flatMapLatest { $0 }
            .subscribe {(event) in
                print(event)
            }.disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject3.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        
        //当有subjct2的任务时候,立刻终止1的任务,只执行2的任务，以后再加也不执行
        /**
         next(A)
         next(B)
         next(1)
         next(2)
         */
        
    }
    
    fileprivate func flatMapFirst() {
        
        //flatMapFirst 与 flatMapLatest 正好相反：flatMapFirst 只会接收最初的 value 事件。
        
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let subject3 = BehaviorRelay(value: subject1)
        
        
        subject3.asObservable()
            .flatMapFirst { $0 }
            .subscribe {(event) in
                print(event)
            }.disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject3.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        
        //只执行subjct1的任务
        /**
         next(A)
         next(B)
         next(C)
         */
        
    }
    
    
    fileprivate func concatMap() {
        
        //concatMap 与 flatMap 的唯一区别是：当前一个 Observable 元素发送完毕后，后一个Observable 才可以开始发出元素。或者说等待前一个 Observable 产生完成事件后，才对后一个 Observable 进行订阅。
        
        let subject1 = BehaviorSubject(value: "A")
        let subject2 = BehaviorSubject(value: "1")
        
        let subject3 = BehaviorRelay(value: subject1)
        
        
        subject3.asObservable()
            .concatMap { $0 }
            .subscribe {(event) in
                print(event)
            }.disposed(by: disposeBag)
        
        subject1.onNext("B")
        subject3.accept(subject2)
        subject2.onNext("2")
        subject1.onNext("C")
        //只有前一个序列结束后,才能接受下一个序列
        subject1.onCompleted()
        
        /**
         next(A)
         next(B)
         next(C)
         next(2)
         */
        
    }
    
    
    fileprivate func scan() {
        
        //scan 就是先给一个初始化的数，然后不断的拿前一个结果和最新的值进行处理操作。
        Observable.of(1,2,3,4,5,6)
            .scan(1) { (acum, elem) in
                acum + elem
            }.subscribe { print($0) }
            .disposed(by: disposeBag)
        
        /**
         next(2)
         next(4)
         next(7)
         next(11)
         next(16)
         next(22)
         completed
         */
    }
    
    
    fileprivate func groupBy() {
        
        //groupBy 操作符将源 Observable 分解为多个子 Observable，然后将这些子 Observable 发送出来。
        //也就是说该操作符会将元素通过某个键进行分组，然后将分组后的元素序列以 Observable 的形态发送出来。
        
        Observable<Int>.of(0,1,2,3,4,5)
            .groupBy { (element) -> String in
                element % 2 == 0 ? "偶数" : "奇数"
            }.subscribe { (event) in
                switch event{
                case .next(let group):
                    group.asObservable().subscribe { (event) in
                        print("key: \(group.key) event:\(event)")
                    }.disposed(by: self.disposeBag)
                default:
                    print("")
                }
            }.disposed(by: disposeBag)
        
        /**
         key: 偶数 event:next(0)
         key: 奇数 event:next(1)
         key: 偶数 event:next(2)
         key: 奇数 event:next(3)
         key: 偶数 event:next(4)
         key: 奇数 event:next(5)
         key: 偶数 event:completed
         key: 奇数 event:completed
         */
        
    }
    
}
