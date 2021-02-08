//
//  BaseTableViewHeaderFooterView.swift
//  SwiftExamples
//
//  Created by wei on 2020/2/10.
//  Copyright © 2020 weiza. All rights reserved.
//

import UIKit
import Reusable

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView,Reusable {

    override init(reuseIdentifier: String?) {
              super.init(reuseIdentifier: reuseIdentifier)
              configUI()
        }
          
    required init?(coder aDecoder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
    }
      
    open func configUI() {}
}
