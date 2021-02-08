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
    
    public var listData = [ClassInfo]() {
        didSet {
            tableView.reloadData()
        }
    }
        
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate   = self
        table.dataSource = self
        table.register(cellType: HomeListCell.self)
        table.rowHeight  = 70
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

extension TableViewController: UITableViewDelegate,UITableViewDataSource {

    //MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        listData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: HomeListCell.self)
        let info = listData[indexPath.row]
        cell.titleLable.text = info.name
        return cell
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = listData[indexPath.row]
        if info.link.isEmpty {
            pushViewController(info.class)
        }else{
            let webView = WebViewController()
            webView.startUrl = info.link
            webView.titleStr = info.name
            navigationController?.pushViewController(webView, animated: true)
        }
    }

}
