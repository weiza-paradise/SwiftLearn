//
//  Foundation+Extension.swift
//  swiftLearn
//
//  Created by wei on 2021/3/8.
//

import Foundation


extension DispatchTime : ExpressibleByIntegerLiteral,
                         ExpressibleByFloatLiteral {

    public init(integerLiteral val: Int) {
        self = .now() + .seconds(val)
    }

    public init(floatLiteral val: Double) {
        self = .now() + .milliseconds(Int(val * 1000))
    }
}
