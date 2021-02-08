//
//  PaintTrajectoryViewViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

//画圆弧的UIBezierPath相关方法
//+ (instancetype)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
//center:圆弧的中心，相对所在视图； radius：圆弧半径； startAngle：起始点的角度(相对角度坐标系0)； endAngle：结束点的角度(相对角度坐标系0)； clockwise：是否为顺时针方向。
//- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
//在原有的线上添加一条弧线 。center:圆弧的中心，相对所在视图； radius：圆弧半径； startAngle：起始点的角度(相对角度坐标系0)； endAngle：结束点的角度(相对角度坐标系0)； clockwise：是否为顺时针方向。

class PaintTrajectoryViewViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        paintTrajectory()
        lineAndTrajectoryView()
    }

}


extension PaintTrajectoryViewViewController {
    
    /// 在矩形中画一个圆弧
    fileprivate func paintTrajectory() {
        let view = UIView(frame: CGRect(x: 100, y: 150, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        
        let viewCenter = CGPoint(x: view.width/2, y: view.height/2)
        let path = UIBezierPath(arcCenter: viewCenter, radius: 35, startAngle: 0, endAngle: CGFloat(1.75*Double.pi), clockwise: true)
        
        let layer = CAShapeLayer()
        layer.lineWidth = 2
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.path = path.cgPath
        view.layer.addSublayer(layer)
    }
    
    // 折线和弧线构成的曲线
    fileprivate func lineAndTrajectoryView() {
        
        let view = UIView.init(frame: CGRect.init(x: 100, y: 300, width: 150, height: 150))
        view.backgroundColor = UIColor.orange
        self.view.addSubview(view)
        
        //线的路径
        let viewCenter = CGPoint(x: view.width/2, y: view.height/2)// 画弧的中心点，相对于view
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: viewCenter)
        // 添加一条弧线
        path.addArc(withCenter: viewCenter, radius: 50, startAngle: 0, endAngle: CGFloat(Double.pi), clockwise: true)

        let layer = CAShapeLayer()
        layer.lineWidth   = 1
        layer.strokeColor = UIColor.green.cgColor
        layer.fillColor   = UIColor.blue.cgColor
        layer.path        = path.cgPath
        view.layer.addSublayer(layer)
    }
    
}
