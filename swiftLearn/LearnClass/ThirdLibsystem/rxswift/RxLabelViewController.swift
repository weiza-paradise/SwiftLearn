//
//  RxLabelViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/3/1.
//

import UIKit
import RxSwift
import RxCocoa
import Highlightr

class RxLabelViewController: BaseViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //定义一个定时器.
        let time = Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        //0.1执行一次,通过map函数整理数据,并绑定到label上
        time.map{ "\(($0/60)%60):\($0 % 60)"}
            .bind(to: textLabel.rx.text)
            .disposed(by: disposeBag)
        
        desLabel.text = "通过源码我们发现,rxswift对label加了“text”和“attributedText”属性.我们也可以自己去添加."
        let highlightr = Highlightr()!
        let code = """
                    通过源码我们发现,rxswift对label加了“text”和“attributedText”属性.我们也可以自己去添加.

                    //源码
                    extension Reactive where Base : UILabel {

                        /// Bindable sink for `text` property.
                        public var text: RxCocoa.Binder<String?> { get }

                        /// Bindable sink for `attributedText` property.
                        public var attributedText: RxCocoa.Binder<NSAttributedString?> { get }
                    }
                   """
        let highlightedCode = highlightr.highlight(code, as: "swift")
        desLabel.attributedText = highlightedCode
    }
    
}
