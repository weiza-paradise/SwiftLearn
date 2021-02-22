//
//  ThirdlibraryViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/2/20.
//

import UIKit

struct ThirdlibraryModel {

    let list : [ClassInfo] = [
        ClassInfo(name: "Alamofire", class: AlamofireLearnViewController.self),
    ]
    
}

class ThirdlibraryViewController: TableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        listData = ThirdlibraryModel().list
    }
}
