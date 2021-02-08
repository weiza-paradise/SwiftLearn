//
//  PaintRoundedRectangleViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

//画单角的圆角矩形的UIBezierPath相关方法
//public convenience init(roundedRect rect: CGRect, byRoundingCorners corners: UIRectCorner, cornerRadii: CGSize)
//为矩形的某一个角添加自定义大小的圆角（当自定义的圆角大小超过矩形宽或高的一半是，自动取矩形宽或高的一半作为圆角大小)


class PaintRoundedRectangleViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        drawCircleView()
        drawUnicornous()
    }
    
}


extension PaintRoundedRectangleViewController {
    
    //四角都是圆角
    fileprivate func drawCircleView() {
        
        let circleView = UIView(frame: CGRect(x: 100, y: 150, width: 200, height: 100))
        circleView.backgroundColor = UIColor.red
        self.view.addSubview(circleView)
        
        //线的路径
        let path = UIBezierPath(roundedRect: circleView.bounds, cornerRadius: 20)
        let layer =  CAShapeLayer()
        
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.path = path.cgPath
        layer.fillColor = UIColor.blue.cgColor
        //添加蒙版
        circleView.layer.mask = layer
    }
    
    fileprivate func drawUnicornous() {
        
        let circleView = UIView(frame: CGRect(x: 100, y: 300, width: 200, height: 100))
        circleView.backgroundColor = UIColor.red
        self.view.addSubview(circleView)
        
        //线的路径
        
        //此方法可以用来对多个角进行圆角切
        //        let path = UIBezierPath(roundedRect: view.bounds, byRoundingCorners: UIRectCorner(rawValue: UIRectCorner.RawValue(UInt8(UIRectCorner.topLeft.rawValue) | UInt8(UIRectCorner.bottomRight.rawValue))) , cornerRadii: CGSize.init(width: 20, height: 0))
        //此方法可以用来对单个角进行圆角切
        let path = UIBezierPath(roundedRect: circleView.bounds, byRoundingCorners: UIRectCorner.topRight, cornerRadii: CGSize.init(width: 20, height: 0))
        
        let layer = CAShapeLayer.init()
        layer.lineWidth = 1
        layer.strokeColor = UIColor.green.cgColor
        layer.path = path.cgPath
        circleView.layer.mask = layer
        
    }
}
