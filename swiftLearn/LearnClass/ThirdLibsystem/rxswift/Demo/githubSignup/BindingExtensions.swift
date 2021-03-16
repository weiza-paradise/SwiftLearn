//
//  BindingExtensions.swift
//  swiftLearn
//
//  Created by wei on 2021/3/16.
//

import UIKit
import RxSwift
import RxCocoa

extension GithubValidationResult {
    
    var description: String {
        switch self {
        case let .ok(message):
            return message
        case .empty:
            return ""
        case let .failed(mesage):
            return mesage
        case .validating:
            return "验证中..."
        }
    }
}

struct ValidationColors {
    static let okColor = UIColor(red: 138.0 / 255.0, green: 221.0 / 255.0, blue: 109.0 / 255.0, alpha: 1.0)
    static let errorColor = UIColor.red
}

extension GithubValidationResult {
    
    var textColor: UIColor {
        switch self {
        case .ok:
            return ValidationColors.okColor
        case .empty:
            return UIColor.black
        case .validating:
            return UIColor.black
        case .failed:
            return ValidationColors.errorColor
        }
    }
    
}


//给lable 增加rx属性 validationResult
extension Reactive where Base: UILabel {
    var validationResult: Binder<GithubValidationResult> {
        return Binder(base) { label ,result in
            label.textColor = result.textColor
            label.text = result.description
        }
    }
}
