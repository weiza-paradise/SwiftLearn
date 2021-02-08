//
//  CalculationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class CalculationViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let startPoint = CGPoint(x: 0, y: 100+navBarHeight*2)
        let endPoint = CGPoint(x:  CGFloat(screenWidth), y: 50+CGFloat(navBarHeight)*2)
        
        // 绿色三次贝塞尔曲线
        let path = UIBezierPath()
        path.move(to: startPoint)
        //三次贝塞尔曲线
        path.addCurve(to: endPoint, controlPoint1: CGPoint(x: 100, y: navBarHeight), controlPoint2: CGPoint(x: 240, y: 180+navBarHeight))
        
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
        
        self.view.layer.addSublayer(layer)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
