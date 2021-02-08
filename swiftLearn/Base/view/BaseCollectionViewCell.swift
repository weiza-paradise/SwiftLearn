//
//  BaseCollectionViewCell.swift
//  SwiftExamples
//
//  Created by wei on 2020/2/10.
//  Copyright © 2020 weiza. All rights reserved.
//

import UIKit
import Reusable

class BaseCollectionViewCell: UICollectionViewCell,Reusable {
    
   override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        autoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
    open func autoLayout() {}
}
