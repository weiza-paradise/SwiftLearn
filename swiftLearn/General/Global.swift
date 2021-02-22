//
//  Global.swift
//  SwiftExamples
//
//  Created by wei on 2020/2/10.
//  Copyright © 2020 weiza. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import NSObject_Rx
import RxDataSources
import Kingfisher
import SwifterSwift
import WebKit

public let processPool = WKProcessPool()

public let screenWidth  = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height

//MARK: 是否iphonex
public let isIPhoneX: Bool = {
    var isx = false
    if #available(iOS 11.0, *) {
        isx = UIApplication.shared.windows.first { $0.isKeyWindow }? .safeAreaInsets.bottom ?? 0.0 > 0.0
    }
    return isx
}()
//MARK: nav tab
public let statusBarHeight      = isIPhoneX ? 44 : 20
public let navBarHeight         = isIPhoneX ? 88 : 64
public let safeAreaBottomHeight = isIPhoneX ? 34 : 0
public let tabBarHeight         = isIPhoneX ? 83 : 49
//MARK: iPhone6 为基准去适配
public let iPhone6ScaleWidth    = screenWidth / 375
public let iPhone6ScaleHeight   = screenHeight / 667
