//
//  TransitionAnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

enum TransitionAnimationType: Int{
    case fade    = 0 //淡出 默认
    case moveIn      //覆盖原图
    case push        // 推出
    case reveal      //底部显示出来
    case cube        //立方旋转
    case suck        //吸走
    case oglFlip     //水平翻转 沿y轴
    case ripple      //滴水效果
    case curl        //卷曲翻页(向上翻页)
    case unCurl      //卷曲翻页返回(向下翻页)
    case caOpen      //相机开启
    case caClose     //相机关闭
}

//过度动画
class TransitionAnimationViewController: BaseAnimationViewController {
    
    fileprivate var type : TransitionAnimationType = .fade
    fileprivate var label_Num: UILabel!
    fileprivate var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label_Num = UILabel()
        label_Num.font = UIFont.systemFont(ofSize: 40)
        label_Num.textAlignment = .center
        testView.addSubview(label_Num)
        label_Num.snp.makeConstraints { (make) in
            make.centerX.centerY.equalTo(testView)
            make.width.height.equalTo(40)
        }
        changeLabelNum()
    }
    
    convenience init(entryType: TransitionAnimationType) {
        self.init()
        type = entryType
    }
    
    deinit {
        print("TransitionAnimationViewController deinit")
    }
    
}

extension TransitionAnimationViewController {
    
    fileprivate func changeLabelNum() {
        
        if index > 4{ index = 0 }
        
        let array_Color = [UIColor.cyan, UIColor.magenta, UIColor.red, UIColor.purple, UIColor.orange]
        let array_Num = ["1", "2", "3", "4", "5"]
        
        testView.backgroundColor = array_Color[index]
        label_Num.text = array_Num[index]
        
        index += 1
    }
    
    override func palyAnimationAction() {
        
        changeLabelNum()
        
        switch type {
        case .fade:
            fadeAnimation()
        case .moveIn:
            moveInAnimation()
        case .push:
            pushAnimation()
        case .reveal:
            revealAnimation()
        case .cube:
            cubeAnimation()
        case .suck:
            suckAnimation()
        case .oglFlip:
            oglFlipAnimation()
        case .ripple:
            rippleAnimation()
        case .curl:
            curlAnimation()
        case .unCurl:
            unCurlAnimation()
        case .caOpen:
            caOpenAnimation()
        case .caClose:
            caCloseAnimation()
        }
    }
}

extension TransitionAnimationViewController {
    
    // CATransition 转场动画
    
    func fadeAnimation() {
        
        let animation_Fade = CATransition()
        animation_Fade.type = CATransitionType(rawValue: "fade")
        animation_Fade.duration = 1.50
        testView.layer.add(animation_Fade, forKey: "fadeAnimation")
    }
    
    func moveInAnimation() {
        
        let animation_MoveIn = CATransition()
        animation_MoveIn.type = CATransitionType(rawValue: "moveIn")
        animation_MoveIn.duration = 1.0
        testView.layer.add(animation_MoveIn, forKey: "moveInAnimation")
    }
    
    func pushAnimation() {
        
        let animation_Push = CATransition()
        animation_Push.type = CATransitionType(rawValue: "push")
        animation_Push.subtype = CATransitionSubtype(rawValue: "fromRight") /* the legal values are `fromLeft', `fromRight', `fromTop' and`fromBottom'. */
        animation_Push.duration = 1.0
        testView.layer.add(animation_Push, forKey: "pushAnimation")
    }
    
    func revealAnimation() {
        
        let animation_Reveal = CATransition()
        animation_Reveal.type = CATransitionType(rawValue: "reveal")
        animation_Reveal.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_Reveal.duration = 1.0
        testView.layer.add(animation_Reveal, forKey: "revealAnimation")
    }
    
    func cubeAnimation() {
        
        let animation_Cube = CATransition()
        animation_Cube.type = CATransitionType(rawValue: "cube")
        animation_Cube.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_Cube.duration = 1.0
        testView.layer.add(animation_Cube, forKey: "cubeAnimation")
    }
    
    func suckAnimation() {
        
        let animation_Suck = CATransition()
        animation_Suck.type = CATransitionType(rawValue: "suckEffect")
        animation_Suck.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_Suck.duration = 1.0
        testView.layer.add(animation_Suck, forKey: "suckAnimation")
    }
    
    func oglFlipAnimation() {
        
        let animation_OglFlip = CATransition()
        animation_OglFlip.type = CATransitionType(rawValue: "oglFlip")
        animation_OglFlip.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_OglFlip.duration = 1.0
        testView.layer.add(animation_OglFlip, forKey: "oglFlipAnimation")
    }
    
    func rippleAnimation() {
        
        let animation_Ripple = CATransition()
        animation_Ripple.type = CATransitionType(rawValue: "rippleEffect")
        animation_Ripple.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_Ripple.duration = 1.0
        testView.layer.add(animation_Ripple, forKey: "rippleAnimation")
    }
    
    func curlAnimation() {
        
        let animation_Curl = CATransition()
        animation_Curl.type = CATransitionType(rawValue: "pageCurl")
        animation_Curl.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_Curl.duration = 1.0
        testView.layer.add(animation_Curl, forKey: "curlAnimation")
    }
    
    func unCurlAnimation() {
        
        let animation_UnCurl = CATransition()
        animation_UnCurl.type = CATransitionType(rawValue: "pageUnCurl")
        animation_UnCurl.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_UnCurl.duration = 1.0
        testView.layer.add(animation_UnCurl, forKey: "unCurlAnimation")
    }
    
    func caOpenAnimation() {
        
        let animation_CaOpen = CATransition()
        animation_CaOpen.type = CATransitionType(rawValue: "cameraIrisHollowOpen")
        animation_CaOpen.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_CaOpen.duration = 1.0
        testView.layer.add(animation_CaOpen, forKey: "caOpenAnimation")
    }
    
    func caCloseAnimation() {
        
        let animation_CaClose = CATransition()
        animation_CaClose.type = CATransitionType(rawValue: "cameraIrisHollowClose")
        animation_CaClose.subtype = CATransitionSubtype(rawValue: "fromRight")
        animation_CaClose.duration = 1.0
        testView.layer.add(animation_CaClose, forKey: "caCloseAnimation")
    }
    
}
