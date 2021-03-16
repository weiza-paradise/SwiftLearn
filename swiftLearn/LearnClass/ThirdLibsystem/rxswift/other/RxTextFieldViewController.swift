//
//  RxTextFieldViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/2.
//

import UIKit
import RxCocoa
import RxSwift

class RxTextFieldViewController: BaseViewController {
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var textField1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "UITextField"
        // Do any additional setup after loading the view.
        //
        
        //绑定textfiled1的输入事件
        textField1.rx.text.orEmpty.asObservable().subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        //文本框的变化序列
        let tfInput = textField1.rx.text.orEmpty.asDriver() //将普通序列转成Driver
            .throttle(DispatchTimeInterval.seconds(1))
        
        //将内容绑定到另一个输入框
        tfInput.drive(textField2.rx.text).disposed(by: disposeBag)
        
        //将内容绑定到label
        tfInput.map { "当前输入了\($0.count)个字" }
            .drive(label.rx.text)
            .disposed(by: disposeBag)
        
        //将内容绑定到button上. 输入超过5个字才可以点击
        tfInput.map { $0.count > 5 }
            .drive(button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        //同时监听两个textfield
        Observable.combineLatest(textField1.rx.text.orEmpty, textField2.rx.text.orEmpty) {
            text1, text2 -> String in
            return "前一个值\(text1),后一个值\(text2)"
        }.map { $0 }
        .bind(to: totalLabel.rx.text)
        .disposed(by: disposeBag)
        
        //监听textfield的回车事件
        textField1.rx.controlEvent( .editingChanged)
            .subscribe(onDisposed:  { [weak self] in
                self!.textField2.becomeFirstResponder()
            }).disposed(by: disposeBag)
        
        //监听textfield 的所有事件
        textField2.rx.controlEvent( .allEditingEvents)
            .subscribe { (event) in
                print("正在监听输入事件")
            }.disposed(by: disposeBag)
    }
    
    
}
