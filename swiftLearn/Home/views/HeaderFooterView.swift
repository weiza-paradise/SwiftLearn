//
//  HeaderFooterView.swift
//  swiftLearn
//
//  Created by wei on 2021/1/27.
//

import UIKit

class HeaderFooterView: BaseTableViewHeaderFooterView {

    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    override func configUI() {
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
    }

}
