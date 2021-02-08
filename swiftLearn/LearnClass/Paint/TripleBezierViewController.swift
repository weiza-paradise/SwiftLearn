//
//  TripleBezierViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class TripleBezierViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawView()
    }

}

extension TripleBezierViewController {
    
    fileprivate func drawView() {
        
        let bgview = UIView(frame: CGRect(x: 50, y: 350, width: 200, height: 200))
        bgview.backgroundColor = UIColor.orange
        view.addSubview(bgview)
      
        // 绿色三次贝塞尔曲线
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 100))
        //三次贝塞尔曲线
        path.addCurve(to: CGPoint(x: 200, y: 50), controlPoint1: CGPoint(x: 10, y: 0), controlPoint2: CGPoint(x: 70, y: 180))
        //在加  可画出n次贝塞尔曲线
        //path.addCurve(to: CGPoint(x: 200, y: 50), controlPoint1: CGPoint(x: 40, y: 40), controlPoint2: CGPoint(x: 90, y: 120))
        
        let layer = CAShapeLayer()
        layer.lineWidth = 1
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = nil
        layer.path = path.cgPath
        
        //动画1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        layer.add(animation, forKey: "")
        
        bgview.layer.addSublayer(layer)
        
    }
}
