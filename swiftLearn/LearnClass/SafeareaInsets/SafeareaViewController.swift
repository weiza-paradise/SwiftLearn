//
//  SafeareaViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/12/16.
//

import UIKit
import SnapKit
//https://blog.csdn.net/u013712343/article/details/107211700
//https://blog.csdn.net/gaoqinghuadage/article/details/79961750?spm=1001.2101.3001.6650.2&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.nonecase&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7Edefault-2.nonecase
class SafeareaViewController: UIViewController {

    let redView = UIView()
    
    //使用autolayout布局,使用safeAreaLayoutGuide可直接在viewdidload中使用
    //safeAreaLayoutGuide是UILayoutGuide类型,适用于autolayout,而safeAreaInsets是UIEdgeInsets类型,适用于用frame设置位置
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(redView)
        redView.backgroundColor = .brown
        redView.insetsLayoutMarginsFromSafeArea = false
        redView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        let blueBtn = UIButton(type: .custom);
        blueBtn.setTitle("点我", for: .normal)
        blueBtn.addTarget(self, action: #selector(clickBtnAction), for: .touchUpInside)
        redView.addSubview(blueBtn)
        blueBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 100, height: 100))
            make.center.equalTo(redView)
        }
    
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear \(view.safeAreaInsets)")
    }
    
    @objc func clickBtnAction() {
        let vc = SafeareaSendViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true) {
            
        }
    }
    
    //如果是硬编码的话,就需要在 viewSafeAreaInsetsDidChange 中设置.
    //一个vc从创建到界面显示,会依次调用以下方法:
    //viewDidLoad ->viewWillAppear->viewSafeAreaInsetsDidChange->viewWillLayoutSubviews->viewDidLayoutSubviews->viewDidAppear
    //在viewSafeAreaInsetsDidChange 方法时界面的safeAreaInsets值会被计算出来,在这个方法中可以更改控件位置:
    /*
    override func viewSafeAreaInsetsDidChange() {
        print("insets123 \(view.safeAreaInsets)")
        redView.frame = CGRect(x: view.safeAreaInsets.left,
                            y: view.safeAreaInsets.top,
                               width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                               height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    */

    
    
}
