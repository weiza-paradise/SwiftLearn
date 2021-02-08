//
//  AnimationViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/27.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class AnimationViewController: BaseViewController {
    
    fileprivate let listInfo = AnimationViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cellType: HomeListCell.self)
        table.register(headerFooterViewType: HeaderFooterView.self)
        table.delegate   = self
        table.dataSource = self
        table.rowHeight  = 65
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    deinit {
        print("AnimationViewController 释放了")
    }
}

extension AnimationViewController : UITableViewDataSource,UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        listInfo.animationListInfo[section].classInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeListCell.self)
        let headerInfo = listInfo.animationListInfo[indexPath.section]
        let itemInfo = headerInfo.classInfo[indexPath.row]
        cell.titleLable.text = itemInfo.name
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func numberOfSections(in tableView: UITableView) -> Int {
        listInfo.animationListInfo.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animationVC : UIViewController?
        switch indexPath.section {
        case 0:
            animationVC = BasisAnimationViewController(entryType: BaseAnimationType(rawValue: indexPath.row)!)
        case 1:
            animationVC = KeyFrameAnimationViewController(entryType: KeyFrameAnimationType(rawValue: indexPath.row)!)
        case 2:
            animationVC = GroupAnimationViewController(entryType: GroupAnimationType(rawValue: indexPath.row)!)
        case 3:
            animationVC = TransitionAnimationViewController(entryType: TransitionAnimationType(rawValue: indexPath.row)!)
        default:
            animationVC = BasisAnimationViewController(entryType: BaseAnimationType(rawValue: indexPath.row)!)
        }
        self.navigationController?.pushViewController(animationVC!)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headrView = tableView.dequeueReusableHeaderFooterView(HeaderFooterView.self)
        let info = listInfo.animationListInfo[section]
        headrView?.titleLable.text = info.title
        return headrView
    }
    
}
