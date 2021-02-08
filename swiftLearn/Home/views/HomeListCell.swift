//
//  HomeListCell.swift
//  swift-learn
//
//  Created by wei on 2021/1/26.
//

import UIKit

class HomeListCell: BaseTableViewCell {

    lazy var titleLable: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hex: 0x333333)
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    lazy var iconView: UIImageView = {
        let img = UIImageView()
        img.clipsToBounds = true
        img.backgroundColor = UIColor(hex: 0xe0e0e0)
        return img
    }()
    
    override func configUI() {
        contentView.addSubview(titleLable)
        titleLable.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(20)
        }
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.centerY.equalToSuperview()
            make.left.equalTo(titleLable.snp_rightMargin).offset(15)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
