//
//  PaintLineCapViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class PaintLineCapViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawLineCap()
    }
}


extension PaintLineCapViewController {

    fileprivate func drawLineCap() {
        
        let bgview = UIView()
        bgview.backgroundColor = UIColor.orange
        self.view.addSubview(bgview)
        bgview.snp.makeConstraints { (make) in
            make.left.bottom.right.equalTo(0)
            make.top.equalTo(navBarHeight)
        }
        
        
        let path = UIBezierPath()
        path.move(to:  CGPoint(x: 50, y: 100))
        path.addLine(to: CGPoint(x: 250, y: 100))
        path.addLine(to: CGPoint(x: 100, y: 300))
        path.lineWidth = 40
        
        //需要自定义view写到 draw 方法中
        
        //path.lineJoinStyle = .bevel
        //path.lineCapStyle = .round
        //path.stroke()
        
        let layer = CAShapeLayer()
        layer.lineWidth = 40
        layer.strokeColor = UIColor.purple.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.path = path.cgPath
        bgview.layer.addSublayer(layer)
    }
    
}
