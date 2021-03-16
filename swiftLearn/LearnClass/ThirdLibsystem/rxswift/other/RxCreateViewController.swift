//
//  RxCreateViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/3.
//

import UIKit
import RxSwift
import RxCocoa

class RxCreateViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RxSwift Observable序列的创建方式"
        
        // Do any additional setup after loading the view.
        
        _ = Observable<Int>.of(1,2,3,4).subscribe { (event) in
            print(event)
        } onError: { (error) in
            print(error)
        } onCompleted: {
            print("完成回调")
        } onDisposed: {
            print("释放回调")
        }

        
        //empty()
        //just()
        //of()
        //from()
        //never()
        //error()
        //range()
        //repeatElement()
        //generate()
        //create()
        //deferred()
        //interval()
        timer()
    }
    
}

extension RxCreateViewController {
    
    
    fileprivate func timer() {
        
        observableCreate(method: "timer") {
            //这个方法有两种用法，一种是创建的 Observable 序列在经过设定的一段时间后，产生唯一的一个元素。

            //5秒后发出唯一的一个元素
            Observable<Int>.timer(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance)
                .subscribe { (event) in
                print("唯一的一个元素\(event)")
                }.disposed(by: disposeBag)
            
            //经过5秒之后  每一秒发送一次
            Observable<Int>.timer(DispatchTimeInterval.seconds(5), period: DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .subscribe { (event) in
                    print(event)
                }.disposed(by: disposeBag)
            
            /**
             *********  timer start *********
             *********  timer end *********
             唯一的一个元素next(0)
             唯一的一个元素completed
             next(0)
             next(1)
             next(2)
             next(3)
             next(4)
             next(5)
             *             ...
             *             ...
             */
        }
        
    }
    
    
    
    fileprivate func interval()  {
        
        observableCreate(method: "interval") {
            // 这个方法创建的 Observable 序列每隔一段设定的时间，会发出一个索引数的元素。而且它会一直发送下去。
            // 下面方法让其每 1 秒发送一次，并且是在主线程（MainScheduler）发送。
            Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
                .subscribe { (event) in
                    print(" \(event)")
                }.disposed(by: disposeBag)
            
            /**
             *********  interval start *********
             *********  interval end *********
              next(0)
              next(1)
              next(2)
              next(3)
              next(4)
             *...
             *...
             */
        }
        
    }
    
    
    fileprivate func deferred() {
        
        //用于标记奇数、还是偶数
        var isOdd = true
        
        observableCreate(method: "deferred") {
            //deferred: 该个方法相当于是创建一个 Observable 工厂，通过传入一个 block 来执行延迟 Observable 序列创建的行为，而这个 block 里就是真正的实例化序列对象的地方。
            let factory : Observable<Int> = Observable.deferred { () -> Observable<Int> in
                //让每次执行这个block时候都会让奇数、偶数进行交替
                isOdd = !isOdd
                //根据isodd参数,决定创建并返回的是奇数observable,还是偶数observable
                if isOdd {
                    return Observable.of(1,3,5,7)
                }else{
                    return Observable.of(2,4,6,8)
                }
            }
            
            //第一次测试
            print("第一次测试 start")
            factory.subscribe { (event) in
                print("isOdd \(isOdd) \(event)")
            }.disposed(by: disposeBag)
            print("第一次测试 end")
            
            print("第二次测试 start")
            //第二次测试
            factory.subscribe { (event) in
                print("isOdd \(isOdd) \(event)")
            }.disposed(by: disposeBag)
            print("第二次测试 end")
            
            /**
             *********  deferred start *********
             第一次测试 start
             isOdd false next(2)
             isOdd false next(4)
             isOdd false next(6)
             isOdd false next(8)
             isOdd false completed
             第一次测试 end
             第二次测试 start
             isOdd true next(1)
             isOdd true next(3)
             isOdd true next(5)
             isOdd true next(7)
             isOdd true completed
             第二次测试 end
             *********  deferred end *********

             */
        }
    }
    
    
    fileprivate func create() {
        
        observableCreate(method: "create") {
            //create: 该方法接受一个 闭包形式的参数，任务是对每一个过来的订阅进行处理。
            //        这也是序列创建的一般方式，应用非常之多
            let observable = Observable<String>.create { observer in
                //对订阅发出了.next事件,且携带了一个数据“taidu”
                observer.onNext("taidu")
                //对订阅者发出了 .completed 事件
                observer.onCompleted()
                //因为一个订阅行为会有一个Disposable类型的返回值，所以在结尾一定要returen一个Disposable
                return Disposables.create()
            }
            
            observable.subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            
            /**
             *********  create start *********
             next(taidu)
             completed
             *********  create end *********
             */
        }
        
    }
    
    
    fileprivate func generate() {
        
        observableCreate(method: "generate") {
            //generate: 该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
            //初始值给定 然后判断条件1 再判断条件2 会一直递归下去,直到条件1或者条件2不满足
            //类似 数组遍历循环
            //-参数一initialState:  初始状态。
            //-参数二 condition：终止生成的条件(返回“false”时)。
            //-参数三 iterate：迭代步骤函数。
            //-参数四 调度器：用来运行生成器循环的调度器，默认：CurrentThreadScheduler.instance。
            //-返回：生成的序列。
            
            Observable.generate(initialState: 0,  //初始值
                                condition: { $0 < 10 }, //条件1
                                iterate: { $0 + 2 })    //条件2
                .subscribe { (event) in
                    print(event)
                }.disposed(by: disposeBag)
            /**
             *********  generate start *********
             next(0)
             next(2)
             next(4)
             next(6)
             next(8)
             completed
             *********  generate end *********
             */
            
            let arr = ["t1","t2","t3","t4","t5","t6","t7","t8","t9","t10"]
            Observable.generate(initialState: 0) { (number) in
                number < arr.count
            } iterate: { (idx) in
                idx + 2
            }.subscribe(onNext: { (index) in
                print("遍历arr: \(arr[index])")
            }).disposed(by: disposeBag)
            
            /**
             遍历arr: next(0)
             遍历arr: next(2)
             遍历arr: next(4)
             遍历arr: next(6)
             遍历arr: next(8)
             遍历arr: completed
             */
            
        }
        
    }
    
    fileprivate func repeatElement() {
        
        observableCreate(method: "repeatElement") {
            //repeatElement:  该方法创建一个可以无限发出给定元素的 Event 的 Observable 序列（永不终止）
            
            Observable<Int>.repeatElement(5).subscribe { (event) in
                print("\(event))")
            }.disposed(by: disposeBag)
            
            /**
             next(5)
             next(5)
             next(5)
             next(5)
             next(5)
             next(5)
             ...
             ...
             */
            
        }
        
    }
    
    
    fileprivate func range() {
        
        observableCreate(method: "of") {
            // range: 该方法通过指定起始和结束数值，创建一个以这个范围内所有值作为初始值的 Observable 序列。
            //        下面样例中，两种方法创建的 Observable 序列都是一样的。
            
            //使用range
            Observable.range(start: 1, count: 5).subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            
            //使用of
            Observable.of(1,2,3,4,5).subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            
            /**
             *********  of start *********
             next(1)
             next(2)
             next(3)
             next(4)
             next(5)
             completed
             *********  of end *********
             */
        }
        
    }
    
    fileprivate func error() {
        
        observableCreate(method: "error") {
            //error: 发出一个错误信号
            //       这个序列平时在开发也比较常见，请求网络失败也会发送失败信号！
            Observable<Int>.error(NSError.init(domain: "error", code: 10086, userInfo: ["reason":"unknow"]))
                .subscribe { (event) in
                    print(event)
                }.disposed(by: disposeBag)
            /**
             *********  error start *********
             error(Error Domain=error Code=10086 "(null)" UserInfo={reason=unknow})
             *********  error end *********
             */
        }
        
    }
    
    fileprivate func never() {
        
        observableCreate(method: "never") {
            //never: 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
            //       这种类型的响应源 在测试或者在组合操作符中禁用确切的源非常有用
            Observable<String>.never().subscribe { (event) in
                print("hi \(event)")
            }.disposed(by: disposeBag)
            
            /**
             *********  never start *********
             *********  never end *********
             */
        }
        
    }
    
    
    fileprivate func from() {
        
        observableCreate(method: "from") {
            //from: 将可选序列转换为可观察序列。
            //      从集合中获取序列:数组,集合,set 获取序列 - 有可选项处理 - 更安全
            Observable<[String]>.from(optional: ["tai","du"]).subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            /**
             *********  from start *********
             next(["tai", "du"])
             completed
             *********  from end *********
             */
        }
        
    }
    
    fileprivate func of() {
        
        observableCreate(method: "of") {
            // of: 此方法创建一个新的可观察实例，该实例具有可变数量的元素。该方法可以接受可变数量的参数（必需要是同类型的）
            
            //多个元素 - 针对序列处理
            Observable<String>.of("tai","du").subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            
            //字段
            Observable<[String: Any]>.of(["name":"taidu","age":"18"]).subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            
            //数组
            Observable<[String]>.of(["tai1","du1"]).subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
            
            
            /**
             *********  of start *********
             next(tai)
             next(du)
             completed
             *
             next(["name": "taidu", "age": "18"])
             completed
             *
             next(["tai1", "du1"])
             completed
             *
             *********  of end *********
             */
        }
        
    }
    
    fileprivate func just()  {
        
        observableCreate(method: "just") {
            //just: 通入一个默认值来完成初始化,构建只有一个元素的observable对了.订阅完后自动complete
            
            _ = Observable<[String]>.just(["tai","du"]).subscribe { (event) in
                print(event)
            } onError: { (error) in
                print(error)
            } onCompleted: {
                print("完成回调")
            } onDisposed: {
                print("释放回调")
            }
            
            /**
             *********  just start *********
             ["tai", "du"]
             完成回调
             释放回调
             *********  just end *********
             */
        }
    }
    
    
    fileprivate func empty() {
        
        observableCreate(method: "empty") {
            //empty: 返回空的一个可观察序列,直接返回完成。
            
            let emtyOb = Observable<Int>.empty()
            _ = emtyOb.subscribe(onNext: { (number) in
                print("订阅: \(number)")
            }, onError: { (error) in
                print("error: \(error)")
            }, onCompleted: {
                print("完成回调")
            }, onDisposed: {
                print("释放回调")
            })
            
            /**
             *********  empty start *********
             完成回调
             释放回调
             *********  empty end *********
             */
        }
    }
    
    ///
    fileprivate func observableCreate(method: String, closure: () -> ()) {
        print("*********  \(method) start *********")
        closure()
        print("*********  \(method) end *********")
    }
    
}
