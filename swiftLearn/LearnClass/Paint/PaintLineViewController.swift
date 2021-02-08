//
//  PaintLineViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

//画直线
class PaintLineViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        drawLine()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("PaintLineViewController deinit")
    }
}

//绘制直线
extension PaintLineViewController {
    
    fileprivate func drawLine() {
        
        //线的路径
        let linePath = UIBezierPath()
        //起点
        linePath.move(to: CGPoint(x: 20, y: 300))
        //其他点 可以添加n多个点 可为折线，直线等
        linePath.addLine(to: CGPoint(x: 200, y: 300))
        
        let lineLayer = CAShapeLayer()
        lineLayer.lineWidth = 1
        lineLayer.strokeColor = UIColor.green.cgColor
        lineLayer.path = linePath.cgPath
        lineLayer.fillColor = UIColor.clear.cgColor
        
        //添加动画
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue   = 1
        animation.duration  = 2
        lineLayer.add(animation, forKey: "")
        self.view.layer.addSublayer(lineLayer)
    }
}
