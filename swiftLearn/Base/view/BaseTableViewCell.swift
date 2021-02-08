//
//  BaseTableViewCell.swift
//  SwiftExamples
//
//  Created by wei on 2020/2/10.
//  Copyright © 2020 weiza. All rights reserved.
//

import UIKit
import Reusable

//非nib,遵循Rsusable(可复用)协议 , xib 遵循 NibReusable
class BaseTableViewCell: UITableViewCell,Reusable {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}
