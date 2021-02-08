//
//  BaseViewController.swift
//  SwiftExamples
//
//  Created by wei on 2020/2/10.
//  Copyright © 2020 weiza. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: 0xf1f1f1)
        //UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func configUI() {}
    
}

extension UIViewController {
    
    open func controllerFromString(className: String) -> UIViewController {
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            return UIViewController.init()
        }
        let cls: AnyClass? = NSClassFromString((clsName as! String) + "." + className)
        guard let clsType = cls as? UIViewController.Type else {
            return UIViewController.init()
        }
        return clsType.init()
    }
    
    /// push String 跳转
    /// - Parameter className: className
    open func pushStringView(className: String) {
        navigationController?.pushViewController(controllerFromString(className: className), animated: true)
    }
    
    /// push AnyClass 跳转
    /// - Parameters:
    ///   - vc:
    ///   - animated:
    func pushViewController(_ vc : AnyClass, animated: Bool = true) {
        guard let cls = vc as? UIViewController.Type else { return }
        let viewcontroller = cls.init()
        self.navigationController?.pushViewController(viewcontroller, animated: animated)
    }
}
