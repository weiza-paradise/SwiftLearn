//
//  QuadRaticBezierViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class QuadRaticBezierViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        drawQuadRaticBezier()
        sameEndPointQuadRaticBezierView()
    }

}

extension QuadRaticBezierViewController {
    
    //总结: 起点和终点的距离越小,趋向控制点结束越早. 趋向终点开始越早,曲线弧度越大.
    //起点相同,控制点不相同
    fileprivate func drawQuadRaticBezier() {
        
        let bgview = UIView(frame: CGRect(x: 50, y: 100, width: 200, height: 200))
        bgview.backgroundColor = UIColor.orange
        self.view.addSubview(bgview)
      
        let greenPath = UIBezierPath()
        greenPath.move(to: CGPoint(x: 10, y: 100))
        //添加二次贝塞尔曲线 to 终点  controlPoint 控制点
        greenPath.addQuadCurve(to: CGPoint(x: 200, y: 50), controlPoint: CGPoint(x: 100, y: 200))
        
        let layer1 = CAShapeLayer()
        layer1.lineWidth = 1
        layer1.strokeColor = UIColor.green.cgColor
        layer1.path = greenPath.cgPath
        layer1.fillColor = nil
        bgview.layer.addSublayer(layer1)
        
        // 红色二次贝塞尔曲线
        let redPath = UIBezierPath()
        redPath.move(to: CGPoint(x: 10, y: 100))
        // 二次贝塞尔曲线
        redPath.addQuadCurve(to: CGPoint(x: 100, y: 50), controlPoint: CGPoint.init(x: 100, y: 200))
        let layer2 = CAShapeLayer()
        layer2.lineWidth = 1
        layer2.strokeColor = UIColor.red.cgColor
        layer2.path = redPath.cgPath
        layer2.fillColor = nil
        bgview.layer.addSublayer(layer2)
    }
    
    
    /**
     总结：控制点与起点和终点所在直线偏移距离越大，曲线弧度越大。
     */
    func sameEndPointQuadRaticBezierView() {
        let bgview = UIView(frame: CGRect(x: 50, y: 350, width: 200, height: 200))
        bgview.backgroundColor = UIColor.orange
        view.addSubview(bgview)
                
        // 绿色二次贝塞尔曲线
        let greenPath = UIBezierPath  ()
        greenPath.move(to: CGPoint(x: 0, y: 100))
        //二次贝塞尔曲线
        greenPath.addQuadCurve(to: CGPoint(x: 200, y: 50), controlPoint: CGPoint.init(x: 100, y: 200))
        let layer1 = CAShapeLayer()
        layer1.lineWidth = 1
        layer1.strokeColor = UIColor.green.cgColor
        layer1.fillColor = nil
        layer1.path = greenPath.cgPath
        bgview.layer.addSublayer(layer1)
        
        // 红色二次贝塞尔曲线
        let redPath = UIBezierPath()
        redPath.move(to: CGPoint(x: 0, y: 100))
        // 二次贝塞尔曲线
        redPath.addQuadCurve(to: CGPoint(x: 200, y: 50), controlPoint: CGPoint.init(x: 100, y: 150))
        let layer2 = CAShapeLayer()
        layer2.lineWidth = 1
        layer2.strokeColor = UIColor.red.cgColor
        layer2.fillColor = nil
        layer2.path = redPath.cgPath
        bgview.layer.addSublayer(layer2)
    }
    
    
}
