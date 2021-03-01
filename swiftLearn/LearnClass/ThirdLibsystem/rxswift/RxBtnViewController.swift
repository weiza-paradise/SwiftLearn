//
//  RxBtnViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/1.
//

import UIKit
import RxCocoa
import RxSwift

class RxBtnViewController: BaseViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var switchs: UISwitch!
    
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button1: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        button.rx.tap.subscribe { (event) in
            print("点击了我呀")
        }.dispose()
        
        let time1 = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        time1.map { "\($0)" }
            .bind(to: button.rx.title(for: .normal))
            .dispose()
        
        let time2 = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        time2.map {
            let imageName = ( $0 / 2 == 0  ? "navBack1" : "navBack3" )
            return UIImage(named: imageName)!
        }.bind(to: button.rx.image())
         .dispose()
        
        
        //将按钮放入数组中,并进行强制解包
        let  buttons = [button1,button2,button3].map({$0!})
        button.isSelected = true
        button1.isSelected = true
        
        //创建一个可观察队列. 发送最后一次点击的按钮. 也就是需要选中的按钮
        
        let selectBtn = Observable.from(buttons.map({ (button) in
            button.rx.tap.map { button }
        })).merge()
        
        //遍历按钮对selectedButton进行订阅,根据它是否当前选中的按钮绑定isSelected属性
        for btn in buttons {
            selectBtn.map { $0 == btn }
                .bind(to: btn.rx.isSelected)
                .dispose()
        }
            
        switchs.rx.isOn.bind(to: button1.rx.isSelected)
            .dispose()
        
        switchs.rx.isOn.asObservable().subscribe { [weak self] in
            self?.button2.isEnabled = $0
        }.dispose()

    }
}
