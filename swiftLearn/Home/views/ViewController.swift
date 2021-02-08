//
//  ViewController.swift
//  swift-learn
//
//  Created by wei on 2021/1/25.
//

import UIKit
import Highlightr
import RxSwift
import RxCocoa
import Reusable

class ViewController: BaseViewController {
    
    let listData = HomeViewModel()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(cellType: HomeListCell.self)
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 70;
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "嗨! swift"
    }
    
    override func configUI() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    deinit {
        print("deinit viewcontroller")
    }
    
}

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        listData.homeListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeListCell.self)
        let info = listData.homeListData[indexPath.row]
        cell.titleLable.text = info.name
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = listData.homeListData[indexPath.row]
        pushViewController(info.class)
    }
    
}
