//
//  BaseAnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/27.
//

import UIKit

class BaseAnimationViewController: BaseViewController {

    let margin_Top: CGFloat = 100.0
    let margin_Width: CGFloat = 100.0
    let margin_MidPosition: CGFloat = 50.0
    
    lazy var testView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    lazy var button: UIButton = {
        let btn = UIButton(type: .custom)
        btn.setTitle("开始", for: .normal)
        btn.setTitleColor( .white, for: .normal)
        btn.backgroundColor = .brown
        btn.addTarget(self, action: #selector(palyAnimationAction), for: .touchUpInside)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func configUI() {
        
        view.addSubview(testView)
        testView.snp.makeConstraints { (make) in
            make.centerX.equalTo(view)
            make.centerY.equalToSuperview().offset(-margin_Width)
            make.width.height.equalTo(margin_Top)
        }
        
        view.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(testView.snp_bottomMargin).offset(20)
        }

    }

}

extension BaseAnimationViewController {
    
    @objc func palyAnimationAction() {
        
    }
    
}
