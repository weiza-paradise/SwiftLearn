//
//  RxTextViewViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/2.
//

import UIKit
import RxCocoa
import RxSwift

class RxTextViewViewController: BaseViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        textView.rx.didBeginEditing.subscribe { (event) in
            print("开始编辑")
        }.disposed(by: disposeBag)
        
        
        textView.rx.didEndEditing.subscribe { (event) in
            print("结束编辑")
        }.disposed(by: disposeBag)
        
        
        textView.rx.didChange.subscribe { (event) in
            print("内容改变")
        }.disposed(by: disposeBag)
        
        textView.rx.didChangeSelection.subscribe { (event) in
            print("选中的内容发送改变")
        }.disposed(by: disposeBag)
        
    }

}
