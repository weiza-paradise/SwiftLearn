//
//  ClosureLearn.swift
//  swift-learn
//
//  Created by wei on 2021/1/26.
//

import UIKit
import Highlightr

class ClosureLearn: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "闭包"
        // Do any additional setup after loading the view.
        //使用highlightr将代码着色成相应的NSAttributedString
        let highlightr = Highlightr()!
        let code = """
                    //闭包表达式语法

                    { (parameters) -> return type in
                        statements
                    }

                    ///小练习:

                    //没有返回参数和返回值的闭包，好像匿名函数呀

                    let learn = {
                        print("练习闭包")
                    }

                    //带有参数的闭包
                    //in 关键字在闭包中,用来隔离参数返回值 和 函数体

                    let learn1 = { (lan: String) in
                        
                    }

                    //带有参数和返回值的闭包

                    let learn2 = { (lan: String) -> String  in
                       
                    }

                    learn()
                    learn1("闭包")
                    let le = learn2("闭包")
                    print(le)

                    /**
                    练习闭包
                    练习闭包
                    练习闭包
                    */

                   """
        let highlightedCode = highlightr.highlight(code, as: "swift")
        
        let textView = UITextView(frame: self.view.frame)
        textView.isEditable = false
        self.view.addSubview(textView)
        textView.attributedText = highlightedCode
    }
    
    deinit {
        print("ClosureLearn 释放了")
    }

}
