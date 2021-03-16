//
//  SinguoProtocols.swift
//  swiftLearn
//
//  Created by wei on 2021/3/16.
//

import RxSwift
import RxCocoa

//验证结果的定义
enum GithubValidationResult {
    case ok(message: String)
    case empty
    case validating
    case failed(mesage: String)
}

//登录的状态
enum SignupState {
    case signedUp(signedUp: Bool)
}

//github 登录请求
protocol  GitHubApi {
    func usernameAvailable(_ username: String) -> Observable<Bool>
    func signup(_ username: String, password: String) -> Observable<Bool>
}

//登录页面的验证服务（输出）
protocol GitHubValidationService {
    func validateUsername(_ username: String) -> Observable<GithubValidationResult>
    func validatePassword(_ password: String) -> GithubValidationResult
    func validateRepeatedPassword(_ password: String , repeatedPassword: String) -> GithubValidationResult
}

extension GithubValidationResult {
    //是否有效
    var isValid: Bool {
        switch self {
        case .ok:
            return true
        default:
            return false
        }
    }
    
}
