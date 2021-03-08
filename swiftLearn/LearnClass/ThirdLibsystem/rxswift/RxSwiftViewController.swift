//
//  RxSwiftViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/1.
//

import UIKit

let storyboardName = "RxSwift"

struct RxSwiftViewModel {
    
    let list : [ClassInfo] = [
        ClassInfo(name: "RxSwift - label", class: RxSwiftViewController.self, isStoryboard: true, storyboardId: "RxLabelVc", storyboardName: storyboardName),
        ClassInfo(name: "RxSwift - UIButton", class: RxBtnViewController.self, isStoryboard: true, storyboardId: "RxBtnVC", storyboardName: storyboardName),
        ClassInfo(name: "RxSwift - UITextField", class: RxTextFieldViewController.self, isStoryboard: true, storyboardId: "RxTextFieldVC", storyboardName: storyboardName),
        ClassInfo(name: "RxSwift - UITextView", class: RxTextViewViewController.self, isStoryboard: true, storyboardId: "RxTextViewVC", storyboardName: storyboardName),
        ClassInfo(name: "RxSwift - OtherView", class: RxOtherViewController.self, isStoryboard: true, storyboardId: "RxOtherVC", storyboardName: storyboardName),
        ClassInfo(name: "RxSwift - UIDatePicker", class: RxDatePickerViewController.self, isStoryboard: true, storyboardId: "RxDatePickerVC", storyboardName: storyboardName),
        ClassInfo(name: "RxSwift - Observable 创建", class: RxCreateViewController.self),
        ClassInfo(name: "RxSwift - Subject", class: RxSubjectViewController.self),
        ClassInfo(name: "RxSwift - Operator", class: RxOperatorViewController.self),
    ]
    
}

class RxSwiftViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listData = RxSwiftViewModel().list
    }

}
