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
    ]
    
}

class RxSwiftViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listData = RxSwiftViewModel().list
    }

}
