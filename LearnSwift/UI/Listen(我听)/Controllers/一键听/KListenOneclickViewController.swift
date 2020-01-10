//
//  KListenOneclickViewController.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/9.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit
import LTScrollView

class KListenOneclickViewController: UIViewController, LTTableViewProtocal {
    
    // 在OC中用NSStringFromClass获取类的字符串 但在Swift中NSStringFromClass得到的"你的工程名字.YourTableViewCell"
    // 还是老老实实写个字符串吧
    private let KListenOneclickTableViewCellId = "KListenOneclickTableViewCellId"
    
    // MARK: - 懒加载
    private lazy var kTBView: UITableView = {
        // LTTableViewProtocal
        let kTBView = tableViewConfig(CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - StatusHeight! - NavHeight! - TabBarHeight!), self, self, nil)
        kTBView.register(KListenOneclickTableViewCell.self, forCellReuseIdentifier: KListenOneclickTableViewCellId)
        kTBView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        kTBView.separatorStyle = UITableViewCell.SeparatorStyle.none
        kTBView.tableFooterView = UIView()
        return kTBView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(kTBView)
        glt_scrollView = kTBView
        if #available(iOS 11.0, *) {
            kTBView.contentInsetAdjustmentBehavior = .never
        }
        else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }

}

// MARK: - TableView 数据源和代理
extension KListenOneclickViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  3 //viewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return SizeFloat(x: 100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kListenOneclickTBVCell: KListenOneclickTableViewCell = tableView.dequeueReusableCell(withIdentifier: KListenOneclickTableViewCellId, for: indexPath) as! KListenOneclickTableViewCell
        kListenOneclickTBVCell.selectionStyle = UITableViewCell.SelectionStyle.none
        //cell.albumResults = viewModel.albumResults?[indexPath.row]
        return kListenOneclickTBVCell
    }
}
