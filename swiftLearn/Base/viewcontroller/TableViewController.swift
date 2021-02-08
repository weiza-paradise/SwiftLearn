//
//  TableViewController.swift
//  swiftLearn
//
//  Created by wei on 2021/1/27.
//

import UIKit

enum TableStyle : Int {
    case plain   = 0
    case grouped = 1
}

class TableViewController: BaseViewController {
    
    fileprivate var style: TableStyle = .plain
    
    lazy var tableView: UITableView = {
        let table = UITableView()
//        table.delegate   = self
//        table.dataSource = self
        table.rowHeight  = 100
        return table
    }()
    
    convenience init(style: TableStyle) {
        self.init()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

//extension TableViewController: UITableViewDelegate,UITableViewDataSource {
//
//    //MARK: - UITableViewDataSource
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
//        listData.homeListData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeListCell.self)
//        let info = listData.homeListData[indexPath.row]
//        cell.titleLable.text = info.name
//        return cell
//    }
//
//    //MARK: - UITableViewDelegate
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let info = listData.homeListData[indexPath.row]
//        pushStringView(className: info.className)
//    }
//
//}
