//
//  IrregularGradientViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/29.
//

import UIKit

class IrregularGradientViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //绘制UIBezierPath路径
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: navBarHeight))
        path.addLine(to: CGPoint(x: 0, y: 150+navBarHeight))
        path.addCurve(to: CGPoint(x: CGFloat(screenWidth), y: 150 + CGFloat(navBarHeight)),
                      controlPoint1: CGPoint(x: CGFloat(screenWidth) * 0.3, y: 200 + CGFloat(navBarHeight)),
                      controlPoint2: CGPoint(x: CGFloat(screenWidth) * 0.8, y: 50 + CGFloat(navBarHeight)))
        path.addLine(to: CGPoint(x: CGFloat(screenWidth), y: CGFloat(navBarHeight)))
        
        //绘制渐变 图片
        let img = drawLinearGradient(startColor: UIColor.green.cgColor, endColor: UIColor.red.cgColor)
        let layer = CAShapeLayer()
        //本质上生成一张渐变色图片 作为layer的填充背景
        layer.fillColor = UIColor(patternImage: img).cgColor
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
    }
    
    /**
     绘制渐变
     */
    func drawLinearGradient(startColor:CGColor, endColor:CGColor) -> UIImage {
        
        //创建CGContextRef
        UIGraphicsBeginImageContext(self.view.bounds.size)
        let context = UIGraphicsGetCurrentContext()
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: navBarHeight))
        path.addLine(to: CGPoint(x: 0, y: screenHeight))
        path.addLine(to: CGPoint(x: screenWidth, y: screenHeight))
        path.addLine(to: CGPoint(x: screenWidth, y: 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations = [CGFloat(0.0), CGFloat(1.0)]
        let colors = [startColor, endColor]
        let gradient = CGGradient(colorsSpace: colorSpace, colors: colors as CFArray, locations: locations)
        
        let pathRect: CGRect = path.cgPath.boundingBox
        //具体方向可根据需求修改
        let startPoint = CGPoint(x: pathRect.minX, y: pathRect.midY)
        let endPoint = CGPoint(x: pathRect.maxX, y: pathRect.midY)
        
        context?.saveGState()
        context?.addPath(path.cgPath)
        context?.clip()
        context?.drawLinearGradient(gradient!, start: startPoint, end: endPoint, options: CGGradientDrawingOptions(rawValue: 0))
        context?.restoreGState()
        //获取绘制的图片
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return img!
    }


}
