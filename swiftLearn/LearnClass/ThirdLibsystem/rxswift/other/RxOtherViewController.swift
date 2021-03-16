//
//  RxOtherViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/2.
//

import UIKit

class RxOtherViewController: BaseViewController {

    @IBOutlet weak var steper: UIStepper!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var switch1: UISwitch!
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //UISegmentedControl
        segment.rx.selectedSegmentIndex.asObservable().subscribe { (event) in
            print("选择了\(event)个")
        }.disposed(by: disposeBag)
        
        
        //UISwitch 的开关 控制 UIActivityIndicatorView 是否执行动画
        switch1.rx.isOn.bind(to: activityView.rx.isAnimating).disposed(by: disposeBag)
        
        switch1.rx.isOn.bind(to: UIApplication.shared.rx.isNetworkActivityIndicatorVisible).disposed(by: disposeBag)
        
        
        slider.rx.value.asObservable().subscribe { (pro) in
            print("当前值 \(pro)")
        }.disposed(by: disposeBag)
        
        steper.rx.value.asObservable().subscribe { (event) in
            print("steper当前值 \(event)")
        }.disposed(by: disposeBag)
        
        //steper 绑定 slider 的值
        steper.rx.value.asObservable().map { Float($0) }
            .bind(to: slider.rx.value)
            .disposed(by: disposeBag)
        
        
    }

}
