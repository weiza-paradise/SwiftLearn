//
//  GroupAnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

enum GroupAnimationType: Int {
    case sameTime = 0 //同时
    case goOn        //连续
}

//组合动画
class GroupAnimationViewController: BaseAnimationViewController {
    
    fileprivate var type : GroupAnimationType = .sameTime
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    convenience init(entryType: GroupAnimationType) {
        self.init()
        type = entryType
    }
    
    deinit {
        print("GroupAnimationViewController deinit")
    }

}

extension GroupAnimationViewController {
    
    override func palyAnimationAction() {
        switch type {
        case .sameTime:
            sameTimeAnimation()
        case .goOn:
            goOnAnimation()
        }
    }
}

extension GroupAnimationViewController {
    
    //同时
    fileprivate func sameTimeAnimation() {
        
        //关键帧动画
        let animation_Position = CAKeyframeAnimation.init(keyPath: "position")
        let value_0 = CGPoint.init(x: margin_MidPosition, y: screenHeight / 2 - margin_MidPosition)
        let value_1 = CGPoint.init(x: screenWidth / 3, y: screenHeight / 2 - margin_MidPosition)
        let value_2 = CGPoint.init(x: screenWidth / 3, y: screenHeight / 2 + margin_MidPosition)
        let value_3 = CGPoint.init(x: screenWidth / 3 * 2, y: screenHeight / 2 + margin_MidPosition)
        let value_4 = CGPoint.init(x: screenWidth / 3 * 2, y: screenHeight / 2 - margin_MidPosition)
        let value_5 = CGPoint.init(x: screenWidth - margin_MidPosition, y: screenHeight / 2 - margin_MidPosition)
        animation_Position.values = [value_0, value_1, value_2, value_3, value_4, value_5]
        //背景
        let animation_BGColor = CABasicAnimation.init(keyPath: "backgroundColor")
        animation_BGColor.toValue = UIColor.green.cgColor
        //旋转动画
        let animation_Rotate = CABasicAnimation.init(keyPath: "transform.rotation")
        animation_Rotate.toValue = NSNumber.init(value: Double.pi * 4)
        
        let animation_Group = CAAnimationGroup()
        animation_Group.animations = [animation_Position, animation_BGColor, animation_Rotate]
        animation_Group.duration = 4.0
        testView.layer.add(animation_Group, forKey: "groupAnimation")
    }
    
    //连续动画 最主要的是处理好各个动画时间的衔接
    fileprivate func goOnAnimation() {
        
        //定义一个动画开始的时间
        let currentTime = CACurrentMediaTime()
        
        let animation_Position = CABasicAnimation.init(keyPath: "position")
        animation_Position.fromValue = CGPoint.init(x: margin_MidPosition, y: screenHeight / 2)
        animation_Position.toValue = CGPoint.init(x: screenWidth / 2, y: screenHeight / 2)
        animation_Position.duration = 1.0
        animation_Position.fillMode = CAMediaTimingFillMode(rawValue: "forwards") //只在前台
        animation_Position.isRemovedOnCompletion = false //切出界面再回来动画不会停止
        animation_Position.beginTime = currentTime
        testView.layer.add(animation_Position, forKey: "positionAnimation")
        
        let animation_Scale = CABasicAnimation.init(keyPath: "transform.scale")
        animation_Scale.fromValue = NSNumber.init(value: 0.7)
        animation_Scale.toValue = NSNumber.init(value: 2.0)
        animation_Scale.duration = 1.0
        animation_Scale.fillMode = CAMediaTimingFillMode(rawValue: "forwards")
        animation_Scale.isRemovedOnCompletion = false
        animation_Scale.beginTime = currentTime + 1.0
        testView.layer.add(animation_Scale, forKey: "scaleAnimation")
        
        let animation_Rotate = CABasicAnimation.init(keyPath: "transform.rotation")
        animation_Rotate.toValue = NSNumber.init(value: Double.pi * 4)
        animation_Rotate.duration = 1.0
        animation_Rotate.fillMode = CAMediaTimingFillMode(rawValue: "forwards")
        animation_Rotate.isRemovedOnCompletion = false
        animation_Rotate.beginTime = currentTime + 2.0
        testView.layer.add(animation_Rotate, forKey: "rotateAnimation")
    }
}
