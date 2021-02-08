//
//  HomeViewModel.swift
//  swift-learn
//
//  Created by wei on 2021/1/26.
//

import Foundation
import RxSwift
import RxDataSources

struct ClassInfo {
    var name = ""
    var `class` : AnyClass
    var link = ""
}

struct ClassHeaderInfo {
    var title = ""
    var classInfo : [ClassInfo]
}

struct HomeViewModel {
        
    let homeListData : [ClassInfo] = [
        ClassInfo(name: "swift 基础", class: BasisViewController.self),
        ClassInfo(name: "动画效果", class: AnimationViewController.self),
        ClassInfo(name: "画图", class: PaintViewController.self),
        ClassInfo(name: "算法题", class: PaintViewController.self),
        ClassInfo(name: "iOS底层进阶", class: BottomLayerViewController.self)

    ]
    
}
