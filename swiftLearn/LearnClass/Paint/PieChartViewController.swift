//
//  PieChartViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class PieChartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let pieView = RYQPieChartView.init(frame: CGRect.init(x: 0, y: 0, width: 0.8*screenWidth, height: 0.8*screenWidth))
        pieView.center = view.center
        pieView.backgroundColor = UIColor.white
        view.addSubview(pieView)
    }

}
