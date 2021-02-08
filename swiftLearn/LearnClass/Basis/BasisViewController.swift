//
//  BasisViewController.swift
//  swift-learn
//
//  Created by wei on 2021/1/26.
//

import UIKit

class BasisViewController: BaseViewController {

    let listData = BasisViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cellType: HomeListCell.self)
        table.delegate   = self
        table.dataSource = self
        table.rowHeight  = 100;
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "swift 基础"
    }
    
    override func configUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    deinit {
        print("BasisViewController 释放了")
    }
    
}


extension BasisViewController: UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        listData.basisListInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeListCell.self)
        let info = listData.basisListInfo[indexPath.row]
        cell.titleLable.text = info.name
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = listData.basisListInfo[indexPath.row]
        pushViewController(info.class)
        //pushStringView(className: info.className)
    }
    
}
