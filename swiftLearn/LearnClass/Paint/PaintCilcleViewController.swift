//
//  PaintCilcleViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

class PaintCilcleViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawCircleView()
        drawCircleViewSecond()
        // Do any additional setup after loading the view.
    }
    
    deinit {
        print("PaintCilcleViewController deinit")
    }
    
}

extension PaintCilcleViewController {
    
    //椭圆形
    fileprivate func drawCircleView() {
        //画圆形需要正方形,椭圆形需要长方形
        let circleView = UIView(frame: CGRect(x: 100, y: 150, width: 200, height: 100))
        circleView.backgroundColor = UIColor.purple
        self.view.addSubview(circleView)
        
        //线的路径
        let path = UIBezierPath(ovalIn: circleView.bounds)
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = UIColor.green.cgColor
        layer.path = path.cgPath
        layer.fillColor = UIColor.brown.cgColor
        
        circleView.layer.addSublayer(layer)
        //layer 的 mask属性,添加蒙版
        circleView.layer.mask = layer
    }
    
    //画圆形
    func drawCircleViewSecond() {
        
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint.init(x: 100, y: 500), radius: 30, startAngle: 0, endAngle: 2*CGFloat(Double.pi), clockwise: true)
        
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = UIColor.green.cgColor
        layer.path = path.cgPath
        layer.fillColor = UIColor.orange.cgColor
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue   = 1
        animation.duration  = 2
        layer.add(animation, forKey: "")
        self.view.layer.addSublayer(layer)
        
    }
}
