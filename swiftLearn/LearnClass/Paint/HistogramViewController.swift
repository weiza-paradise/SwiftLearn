//
//  HistogramViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class HistogramViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        solidBarChart()
        //边框柱形图
        aborderBarChart()
        //边框柱形图的动画
        aborderBarChartAnimation()
    }
    
}

extension HistogramViewController {
    
    /// 实心圆柱
    fileprivate func solidBarChart() {
        
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        path.move(to: CGPoint(x: screenWidth/6, y: screenHeight/2))
        path.addLine(to: CGPoint(x: screenWidth/6, y: screenHeight/3))//
        layer.strokeColor = UIColor.green.cgColor
        layer.lineWidth = 30
        layer.path = path.cgPath
        //动画1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue   = 1
        animation.duration  = 1
        layer.add(animation, forKey: "")
        view.layer.addSublayer(layer)
        
    }
    
    /**
     边框柱形图 没有动画
     */
    fileprivate func aborderBarChart() {
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        path.move(to: CGPoint(x: screenWidth/3, y: screenHeight/2))
        path.addLine(to: CGPoint(x: screenWidth/3, y: screenHeight/3))//
        path.addLine(to: CGPoint(x: screenWidth/3+30, y: screenHeight/3))
        path.addLine(to: CGPoint(x: screenWidth/3+30, y: screenHeight/2))
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.red.withAlphaComponent(0.1).cgColor
        layer.lineWidth = 1
        layer.path = path.cgPath
        
        self.view.layer.addSublayer(layer)
    }
    
    /**
     边框柱形图的动画
     */
    fileprivate func aborderBarChartAnimation() {
        self.drawAborderBarChartAnimation(star: CGPoint(x: screenWidth/2, y: screenHeight/2),
                                          end: CGPoint(x: screenWidth/2, y: screenHeight/3),
                                          duration: 1,
                                          lineWidth: 30,
                                          borderWidth: 1,
                                          mainColor: UIColor(hex: 0xe84855)!,
                                          borderColor: UIColor(hex: 0xfadadd)!)
    }
    
    fileprivate func drawAborderBarChartAnimation(star:CGPoint, end:CGPoint, duration:CGFloat, lineWidth:CGFloat, borderWidth:CGFloat, mainColor:UIColor, borderColor:UIColor) {
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        path.move(to: star)
        path.addLine(to: end)//
        layer.strokeColor = mainColor.cgColor
        layer.lineWidth = lineWidth
        layer.path = path.cgPath
        //动画1
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = CFTimeInterval(duration)
        layer.add(animation, forKey: "")
        
        let inSidePath = UIBezierPath()
        let inSideLayer = CAShapeLayer()
        let yPoint = end.y+borderWidth
        let newEnd = CGPoint(x: end.x, y: yPoint)
        
        inSidePath.move(to: star)
        inSidePath.addLine(to: newEnd)//
        inSideLayer.strokeColor = borderColor.cgColor
        inSideLayer.lineWidth = (lineWidth-borderWidth*2)
        inSideLayer.path = inSidePath.cgPath
        inSideLayer.add(animation, forKey: "")
        
        self.view.layer.addSublayer(layer)
        self.view.layer.addSublayer(inSideLayer)
    }
}
