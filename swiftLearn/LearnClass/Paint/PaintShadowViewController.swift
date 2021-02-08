//
//  PaintShadowViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

class PaintShadowViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawShadow()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("PaintShadowViewController deinit")
    }
    
}

extension PaintShadowViewController {
    
    fileprivate func drawShadow() {
        
        //线的路径
        let linePath = UIBezierPath()
        //起点
        linePath.move(to: CGPoint(x: 20, y: 400))
        //其他点
        linePath.addLine(to: CGPoint(x: 20, y: 300))
        linePath.addLine(to: CGPoint(x: 50, y: 200))
        linePath.addLine(to: CGPoint(x: 70, y: 267))
        //        linePath.addLine(to: CGPoint(x: 90, y: 267))
        //        linePath.addLine(to: CGPoint(x: 200, y: 100))
        //        linePath.addLine(to: CGPoint(x: 250, y: 168))
        //        linePath.addLine(to: CGPoint(x: 150, y: 210))
        linePath.addLine(to: CGPoint(x: 120, y: 170))
        linePath.addLine(to: CGPoint(x: 100, y: 240))
        linePath.addLine(to: CGPoint(x: 200, y: 400))
        
        let lineLayer = CAShapeLayer()
        lineLayer.lineWidth   = 1
        lineLayer.strokeColor = UIColor.green.cgColor
        lineLayer.path        = linePath.cgPath
        lineLayer.fillColor   = UIColor.purple.withAlphaComponent(0.3).cgColor
        
        //动画
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue   = 1
        animation.duration  = 2
        lineLayer.add(animation, forKey: "")
        
        self.view.layer.addSublayer(lineLayer)
        
    }
    
}
