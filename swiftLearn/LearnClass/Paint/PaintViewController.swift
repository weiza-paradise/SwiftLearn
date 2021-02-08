//
//  PaintViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

class PaintViewController: TableViewController {

    fileprivate let listInfo = PaintViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listData = listInfo.paintListData
    }
    
    deinit {
        print("PaintViewController 释放了")
    }
}
