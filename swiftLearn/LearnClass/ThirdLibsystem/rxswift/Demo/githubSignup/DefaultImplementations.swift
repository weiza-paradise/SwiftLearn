//
//  DefaultImplementations.swift
//  swiftLearn
//
//  Created by wei on 2021/3/16.
//

import Foundation
import RxSwift
import RxCocoa

class GitHubDefaultValidationService: GitHubValidationService {
    
    let API: GitHubApi
    
    static let sharedValidationService = GitHubDefaultValidationService(API: GitHubDefaultAPI.sharedApi)
   
    init(API: GitHubApi) {
        self.API = API
    }
    
    let minPasswordCount = 5
    
    func validateUsername(_ username: String) -> Observable<GithubValidationResult> {
        //容错处理
        if username.isEmpty {
            return .just(.empty)
        }
        
        //输入内容验证
        if username.rangeOfCharacter(from: CharacterSet.alphanumerics.inverted) != nil {
            return .just(.failed(mesage: "用户名只能包含字母和数字"))
        }
        
        //加载状态
        let loadingValue = GithubValidationResult.validating
        
        return API.usernameAvailable(username)
            .map { (available) in
                if available {
                    return .ok(message: "用户名验证成功")
                }else {
                    return .failed(mesage: "用户名验证失败")
                }
            }.startWith(loadingValue)
        
    }
    
    //密码验证
    func validatePassword(_ password: String) -> GithubValidationResult {
     
        let numberOfCharacters = password.count
        if numberOfCharacters == 0 {
            return .empty
        }
        
        if numberOfCharacters < minPasswordCount {
            return .failed(mesage: "密码长度不能少于\(minPasswordCount)字符")
        }
        return .ok(message: "密码正确")
        
    }
    
    //确认密码
    func validateRepeatedPassword(_ password: String, repeatedPassword: String) -> GithubValidationResult {
        
        if  repeatedPassword.count == 0 {
            return .empty
        }
        
        if  repeatedPassword == password {
            return .ok(message: "密码正确")
        }
        else {
            return .failed(mesage: "密码错误")
        }
    }
}

//接口类
class GitHubDefaultAPI: GitHubApi {
    
    let URLSession: Foundation.URLSession

    static let sharedApi = GitHubDefaultAPI(
        URLSession: Foundation.URLSession.shared
    )

    init(URLSession: Foundation.URLSession) {
        self.URLSession = URLSession
    }
    
    func usernameAvailable(_ username: String) -> Observable<Bool> {
        let url = URL(string: "https://github.com/\(username.URLEscaped)")!
        let request = URLRequest(url: url)
        return self.URLSession.rx.response(request: request)
            .map { (pair) in
                return pair.response.statusCode == 404
            }
            .catchErrorJustReturn(false)
    }
    
    func signup(_ username: String, password: String) -> Observable<Bool> {
        let signupResult = arc4random() % 5 == 0 ? false : true
        return Observable.just(signupResult)
            .delay(.seconds(1), scheduler: MainScheduler.instance)
    }
    
    
}


extension String {
    var URLEscaped: String {
       return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }
}




