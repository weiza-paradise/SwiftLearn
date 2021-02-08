//
//  PaintViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/28.
//

import UIKit

class PaintViewController: BaseViewController {

    fileprivate let listInfo = PaintViewModel()
    
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
        print("PaintViewController 释放了")
    }
}


extension PaintViewController : UITableViewDataSource,UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        listInfo.paintListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeListCell.self)
        let info = listInfo.paintListData[indexPath.row]
        cell.titleLable.text = info.name
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = listInfo.paintListData[indexPath.row]
        pushViewController(info.class)
    }
}
