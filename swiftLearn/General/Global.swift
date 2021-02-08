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
import Alamofire
import SwifterSwift
import WebKit

public let processPool = WKProcessPool()

public let screenWidth  = UIScreen.main.bounds.width
public let screenHeight = UIScreen.main.bounds.height

//MARK: 是否iphonex
public let isIPhoneX: Bool = (screenHeight == 812 || screenHeight == 896) ? true : false
//MARK: nav tab
public let statusBarHeight      = isIPhoneX ? 44.0 : 20.0
public let navBarHeight         = isIPhoneX ? 88.0 : 64.0
public let safeAreaBottomHeight = isIPhoneX ? 34.0 : 0.0
public let tabBarHeight         = isIPhoneX ? 83.0 : 49.0
//MARK: iPhone6 为基准去适配
public let iPhone6ScaleWidth    = screenWidth / 375.0
public let iPhone6ScaleHeight   = screenHeight / 667.0
