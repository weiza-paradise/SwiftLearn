//
//  KeyFrameAnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

enum KeyFrameAnimationType: Int {
    case keyFrame = 0 //关键帧
    case path         //路径
    case shake        //抖动
}

//关键帧动画
class KeyFrameAnimationViewController: BaseAnimationViewController {
    
    fileprivate var type : KeyFrameAnimationType = .keyFrame
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    convenience init(entryType: KeyFrameAnimationType) {
        self.init()
        type = entryType
    }
    
    deinit {
        print("KeyFrameAnimationViewController deinit")
    }
    
}

extension KeyFrameAnimationViewController {
    
    override func palyAnimationAction() {
        switch type {
        case .keyFrame:
            keyFrameAnimation()
        case .path:
            pathAnimation()
        case .shake:
            shakeAnimation()
        }
    }
}

extension KeyFrameAnimationViewController {
    
    //关键帧动画
    fileprivate func keyFrameAnimation() {
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        let value_0 = CGPoint.init(x: margin_MidPosition, y: screenHeight / 2 - margin_Width)
        let value_1 = CGPoint.init(x: screenWidth / 3, y: screenHeight / 2 - margin_Width)
        let value_2 = CGPoint.init(x: screenWidth / 3, y: screenHeight / 2 + margin_Width)
        let value_3 = CGPoint.init(x: screenWidth * 2 / 3, y: screenHeight / 2 + margin_Width)
        let value_4 = CGPoint.init(x: screenWidth * 2 / 3, y: screenHeight / 2 - margin_Width)
        let value_5 = CGPoint.init(x: screenWidth - margin_MidPosition, y: screenHeight / 2 - margin_Width)
        animation.values = [value_0, value_1, value_2, value_3, value_4, value_5]
        animation.duration = 2.0
        testView.layer.add(animation, forKey: "keyFrameAnimation")
    }
    
    //路径动画
    fileprivate func pathAnimation() {
        
        let animation = CAKeyframeAnimation.init(keyPath: "position")
        let path = UIBezierPath.init(arcCenter: CGPoint.init(x: screenWidth / 2, y: screenHeight / 2), radius: 60, startAngle: 0.0, endAngle: .pi * 2, clockwise: true)
        animation.duration = 2.0
        animation.path = path.cgPath
        testView.layer.add(animation, forKey: "pathAnimation")
    }
    
    //抖动动画
    fileprivate func shakeAnimation() {
        
        let animation = CAKeyframeAnimation.init(keyPath: "transform.rotation")
        let value_0 = NSNumber.init(value: -Double.pi / 180 * 8)
        let value_1 = NSNumber.init(value: Double.pi / 180 * 8)
        animation.values = [value_0, value_1, value_0]
        animation.duration = 1.0
        animation.repeatCount = 1100
        testView.layer.add(animation, forKey: "shakeAnimation")
    }
    
}
