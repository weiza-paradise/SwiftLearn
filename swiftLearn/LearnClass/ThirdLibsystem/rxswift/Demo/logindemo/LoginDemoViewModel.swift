//
//  LoginDemoViewModel.swift
//  swiftLearn
//
//  Created by wei on 2021/3/11.
//

import Foundation
import RxSwift
import RxCocoa

//验证错误的响应
enum ValidateFailReason {
    case emptyInput    //空输入
    case other(String) //其他一些输入类型为 string
}

//验证结果响应
enum ValidateResult {
    case validating   //验证中...
    case ok           //验证成功
    case failed(ValidateFailReason) //验证错误
    var isOk: Bool {
        guard case ValidateResult.ok = self else {
            return false
        }
        return true
    }
}

struct LoginDemoViewModel {
    
    //输入流
    struct Input {
        var userName: Observable<String>      //用户名
        var psd: Observable<String>           //密码
        var cofirmPsd: Observable<String>     //确认密码
        var signUpBtnTaps: Observable<Void> //注册按钮点击事假
    }
    
    //输出流
    struct OutPut {
        //用户名验证结果
        var userNameValidateResult: Observable<ValidateResult>!
        //密码验证结果
        var psdValidateResult: Observable<ValidateResult>!
        //确认密码验证结果
        var confirmPsdValidateResult: Observable<ValidateResult>!
        //注册按钮enable 设置
        var signUpEnable: Observable<Bool>!
        //登录结果
        var signInResult: Observable<Bool>!
    }
    
    //定义一个输出变量
    var output: OutPut
    
    //初始化 参数为 输入流
    init(input: Input) {
        
        output = OutPut()
        //输出,用户验证结果
        output.userNameValidateResult = input.userName.flatMapLatest({ (username) -> Observable<ValidateResult> in
            return LoginDemoService.validateUsername(userName: username)
        }).share(replay: 1)
        
        //输出,密码验证结果
        output.psdValidateResult = input.psd.flatMapLatest({ (psd) -> Observable<ValidateResult> in
            return LoginDemoService.validatePsd(psd: psd)
        }).share(replay: 1)
        //输出,确认密码
        output.confirmPsdValidateResult = Observable<ValidateResult>.combineLatest(input.psd, input.cofirmPsd, resultSelector: { (psd: String, confirmPsd: String) -> ValidateResult in
            //combineLatest 操作符将多个 Observables 中最新的元素通过一个函数组合起来，然后将这个组合的结果发出来。这些源 Observables 中任何一个发出一个元素，他都会发出一个元素（前提是，这些 Observables 曾经发出过元素）。
            if psd.isEmpty || confirmPsd.isEmpty  {
                return .failed(.emptyInput)
            }else if psd != confirmPsd {
                return .failed(.other("两次密码不一样"))
            }else {
                return .ok
            }
        }).share(replay: 1)
        
        //登录按钮是否可点击
        output.signUpEnable = Observable<Bool>
            .combineLatest(output.userNameValidateResult,
                           output.psdValidateResult,
                           output.confirmPsdValidateResult,
                           resultSelector: { (userNameResult: ValidateResult,
                                              psdResult: ValidateResult,
                                              confirmResult: ValidateResult) -> Bool in
                            return userNameResult.isOk && psdResult.isOk && confirmResult.isOk
        })
    
        
        struct UsernameAndPsd {
            let username: String
            let psd: String
        }
        
        //定义一个用户名和密码的观察者
        let userNameAndPsdSeq: Observable<UsernameAndPsd>  = Observable.combineLatest(input.userName, input.psd) { (username, psd) -> UsernameAndPsd in
            print("username = \(username) password = \(psd)")
            return UsernameAndPsd(username: username, psd: psd)
        }
                
        //点击注册的输入流
        output.signInResult = input.signUpBtnTaps.withLatestFrom(userNameAndPsdSeq).flatMapLatest({ (userpsd) -> Observable<(Bool,UsernameAndPsd) > in
            return LoginDemoService.signUp(username: userpsd.username, psd: userpsd.psd).map { (isSignUpService) -> (Bool,UsernameAndPsd) in
                print("注册成功")
                //这里获取到注册成功与否标示,和用户名密码,传到下一个flatMapLatest继续去登录
                return (isSignUpService,UsernameAndPsd(username: userpsd.username, psd: userpsd.psd))
            }
        }).flatMapLatest({ (e: (isSignUpSuccess: Bool, usernameAndPsd: UsernameAndPsd)) -> Observable<Bool> in
            print("登录成功")
            if e.isSignUpSuccess {
                //注册成功之后去登录
                return LoginDemoService.signIn(username: e.usernameAndPsd.username, psd: e.usernameAndPsd.psd)
            }else{
                //注册失败
                return Observable<Bool>.of(false)
            }
        })
    }
    
}
