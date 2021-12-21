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
    var name           = ""
    var `class` : AnyClass
    var link           = ""
    var isStoryboard   = false
    var storyboardId   = ""
    var storyboardName = ""
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
        ClassInfo(name: "算法题", class: AlgorithmViewController.self),
        ClassInfo(name: "iOS底层进阶", class: BottomLayerViewController.self),
        ClassInfo(name: "第三方库", class: ThirdlibraryViewController.self),
        ClassInfo(name: "Safearea", class: SafeareaViewController.self),
    ]
    
}
