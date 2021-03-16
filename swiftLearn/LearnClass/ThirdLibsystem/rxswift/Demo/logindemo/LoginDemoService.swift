//
//  LoginDemoService.swift
//  swiftLearn
//
//  Created by wei on 2021/3/11.
//

import Foundation
import RxSwift

extension String {
    func trim() -> String{
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    func contains(characters: CharacterSet) -> Bool{
        return self.rangeOfCharacter(from: characters) != nil
    }
}

struct LoginDemoService {
    
    //验证用户名是否正确
    static func validateUsername(userName: String) -> Observable<ValidateResult> {
        //返回创建的观察者
        return Observable<ValidateResult>.create { (anyObservable) -> Disposable in
            //username为空,直接返回
            guard !userName.isEmpty else {
                //如果用户名为空,发送信号, emptyInput空输入
                anyObservable.onNext(.failed(.emptyInput))
                //完成一次观察
                anyObservable.onCompleted()
                //返回一个不处理任何事物的对象
                return Disposables.create()
            }

            //发起正在验证
            anyObservable.onNext(.validating)
            //在主线程延迟0.5秒运行
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: 0.5)) {
                if userName.count < 6 && userName.count > 0 {
                    anyObservable.onNext(.failed(.other("用户名不能少于6个字符")))
                }else if (userName.trim().contains(characters: CharacterSet(charactersIn: " !@#$%^&*()"))) {
                    anyObservable.onNext(.failed(.other("用户名有特殊字符")))
                }else {
                    anyObservable.onNext(.ok)
                }
                anyObservable.onCompleted()
            }
            //返回一个不处理任何事物的对象
            return Disposables.create()
        }
    }
    
    //验证密码
    static func validatePsd(psd: String) -> Observable<ValidateResult> {
        
        return Observable<ValidateResult>.create { (anyObservable) -> Disposable in
            //返回创建的观察者
            guard !psd.isEmpty else {
                //如果密码为空,发送信号.
                anyObservable.onNext(.failed(.emptyInput))
                //完成一次观察
                anyObservable.onCompleted()
                //返回一个不处理任何事物的对象
                return Disposables.create()
            }
            //不为空（发送验证中）
            anyObservable.onNext(.validating)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: 0.5)) {
                if psd.count < 6 && psd.count > 0 {
                    anyObservable.onNext(.failed(.other("哥们,密码不能小于六位数字")))
                }else if (psd.trim().contains(characters: CharacterSet(charactersIn: " !@#$%^&*()"))) {
                    anyObservable.onNext(.failed(.other("密码不能有特殊字符")))
                }else{
                    anyObservable.onNext(.ok)
                }
                anyObservable.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    //注册请求
    static func signUp(username: String, psd: String ) -> Observable<Bool> {
    
        return Observable<Bool>.create { (anyObservable) -> Disposable in
            //这里模拟注册请求
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 2)) {
                anyObservable.onNext(true)
                anyObservable.onCompleted()
            }
            return Disposables.create()
        }
    }
    
    //登录请求
    static func signIn(username: String, psd: String) -> Observable<Bool> {
        return Observable.create { (anyObservable) -> Disposable in
            //模拟注册
            DispatchQueue.main.asyncAfter(deadline: DispatchTime(integerLiteral: 2)) {
                anyObservable.onNext(true)
                anyObservable.onCompleted()
            }
            return Disposables.create()
        }
    }
    
}
