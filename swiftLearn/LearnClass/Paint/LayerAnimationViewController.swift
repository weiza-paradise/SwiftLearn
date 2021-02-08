//
//  LayerAnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class LayerAnimationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        animation()
    }
    
}

extension LayerAnimationViewController {
    
    fileprivate func animation() {
        
        //MARK: 贝塞尔曲线
        let startPoint = CGPoint(x:20, y:400)
        let endPoint = CGPoint(x:320, y:400)
        let controlPoint = CGPoint(x:170, y:300)

        //曲线1
        let path = UIBezierPath()
        let layer10 = CAShapeLayer()
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        layer10.path = path.cgPath
        layer10.fillColor = UIColor.clear.cgColor
        layer10.strokeColor = UIColor.black.cgColor
        view.layer.addSublayer(layer10)
        
        //动画
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2
        layer10.add(animation, forKey: "")
    }
    
}
