//
//  GithubSignupViewModel1.swift
//  swiftLearn
//
//  Created by wei on 2021/3/16.
//

import Foundation
import RxSwift
import RxCocoa

class GithubSignupViewModel1 {
    
    //输出
    let validatedUsername: Observable<GithubValidationResult>
    let validatedPassword: Observable<GithubValidationResult>
    let validatedPasswordRepeated: Observable<GithubValidationResult>
    // Is signup button enabled
    let signupEnabled: Observable<Bool>
    // Has user signed in
    let signedIn: Observable<Bool>
    // Is signing process in progress
    let signingIn: Observable<Bool>
    
    //初始化方法
    init(input: (
        username: Observable<String>,
        password: Observable<String>,
        repeatedPassword: Observable<String>,
        loginTaps: Observable<Void> //登录按钮点击
    ),
    dependency: ( //增加一些依赖
        API: GitHubApi, //API
        validationService: GitHubValidationService, //验证协议
        wireframe: Wireframe
    )
    ) {
        
        let API = dependency.API
        let validationService = dependency.validationService
        let wireframe = dependency.wireframe
        
        //验证用户名
        validatedUsername = input.username
            .flatMapLatest { username -> Observable<GithubValidationResult> in
                return validationService.validateUsername(username)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn( .failed(mesage: "联系服务器错误"))
            }
            .share(replay: 1)

        //密码验证
        validatedPassword = input.password
            .map { password in
                return validationService.validatePassword(password)
            }
            .share(replay: 1)

        //确认密码验证
        validatedPasswordRepeated = Observable.combineLatest(input.password, input.repeatedPassword, resultSelector: validationService.validateRepeatedPassword)
            .share(replay: 1)

        //菊花指示
        let singingIn = ActivityIndicator()
        self.signingIn = singingIn.asObservable()
        
        //合并
        let usernameAndPassword = Observable.combineLatest(input.username, input.password) { (username: $0, password: $1) }
        
        //
        signedIn = input.loginTaps.withLatestFrom(usernameAndPassword)
            .flatMapLatest { pair in
                //去登录
                return API.signup(pair.username,password: pair.password)
                    .observeOn(MainScheduler.instance)
                    .catchErrorJustReturn(false)
                    .trackActivity(singingIn)
            }.flatMapLatest { loggedIn -> Observable<Bool> in
                let message = loggedIn ? "登录成功" : "登录失败"
                return wireframe.promptFor(message, cancelAction: "确定", actions: [])
                    .map { _ in
                        loggedIn
                    }
            }
            .share(replay: 1)
        
        
        signupEnabled = Observable.combineLatest(
            validatedUsername,
            validatedPassword,
            validatedPasswordRepeated,
            signingIn.asObservable()
        )  { username, password, repeatPassword, signingIn in
            
            username.isValid &&
                password.isValid &&
                repeatPassword.isValid &&
            !signingIn
        }
        .distinctUntilChanged()
        .share(replay: 1)
        
    }
    
    
}

