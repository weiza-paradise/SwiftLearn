//
//  BasisAnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/27.
//

import UIKit
import Highlightr

enum BaseAnimationType: Int {
    case position = 0    //位移
    case rotate          //旋转
    case scale           //缩放
    case opacity         //透明度
    case backgroundColor //背景色
}

/// 基础动画
class BasisAnimationViewController: BaseAnimationViewController {
    
    fileprivate var type: BaseAnimationType = .position
    
    convenience init(entryType: BaseAnimationType) {
        self.init()
        type = entryType
    }
    
    override func palyAnimationAction() {
        switch type {
        case .position:
            positionAnimation()
        case .rotate:
            rotateAnimation()
        case .scale:
            scaleAnimation()
        case .opacity:
            opacityAnimation()
        case .backgroundColor:
            backgroundColorAnimation()
        }
    }
    
    deinit {
        print("basisViewController deinfi")
    }
}

extension BasisAnimationViewController {
    
    /**
     *   记录下 keyPath 的值:
     
     *   KeyPath                  描述                  值
     *
     *   transform.scale          比例变化               0 ~ 1
     *   transform.scale.x        宽比例变化              0 ~ 1
     *   transform.scale.y        宽比例变化              0 ~ 1
     *   transform.rotation.x     围绕X轴旋转             0 ~ 2*M_PI
     *   transform.rotation.y     围绕Y轴旋转             0 ~ 2*M_PI
     *   transform.rotation.z     围绕Z轴旋转             0 ~ 2*M_PI
     *   cornerRadius             圆角变化                0 ~ 2*MAX(width,height)
     *   backgroundColor          颜色变化，透明度不变      AnyColor.cgColor^1
     *   opacity                  透明度变化              0 ~ 1
     *   bounds                   大小变化，中心不变        CGRect
     *   position                 中心变化                CGPoint
     *   position.x               中心X变化               CGFloat
     *   position.y               中心Y变化               CGFloat
     *   contents                 内容变化 如ImageView.image    image.cgImage^1
     *   borderWidth              边框宽                  0 ~
     
     */
    
    
    /// 位移动画
    fileprivate func positionAnimation() {
        //初始化一个keyPath 为 position 的动画
        let animation = CABasicAnimation(keyPath: "position")
        //fromValue 开始的Point(x,y) 坐标
        animation.fromValue = CGPoint.init(x: 0, y: screenHeight / 2 - margin_Top)
        //toValue  结束的Point(x,y) 坐标
        animation.toValue = CGPoint.init(x: screenWidth - margin_MidPosition, y: screenHeight / 2 - margin_Top)
        //持续时间
        animation.duration = 1.0
        //给对象添加动画,并命名
        testView.layer.add(animation, forKey: "positionAnimation")
    }
    
    //旋转动画
    fileprivate func rotateAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.rotation.z")
        animation.toValue = NSNumber.init(value: Double.pi)
        animation.duration = 0.1
        //无限重复次数
        animation.repeatCount = 50
        testView.layer.add(animation, forKey: "rotateAnimation")
    }
    
    //缩放动画
    fileprivate func scaleAnimation() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = NSNumber.init(value: 2.0)
        animation.duration = 1.0
        testView.layer.add(animation, forKey: "scaleAnimation")
    }
    
    //透明度动画
    fileprivate func opacityAnimation() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = NSNumber.init(value: 1.0)
        animation.toValue = NSNumber.init(value: 0.0)
        animation.duration = 1.0
        testView.layer.add(animation, forKey: "opacityAnimation")
    }
    
    //背景色动画
    fileprivate func backgroundColorAnimation() {
        let animation = CABasicAnimation(keyPath: "backgroundColor")
        animation.toValue = UIColor.blue.cgColor
        animation.duration = 1.0
        testView.layer.add(animation, forKey: "backgroundColorAnimation")
    }
    
}



