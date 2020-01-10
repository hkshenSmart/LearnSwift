//
//  KListenRecommendViewController.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/9.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit
import LTScrollView
import HandyJSON
import SwiftyJSON
import KakaJSON

class KListenRecommendViewController: UIViewController, LTTableViewProtocal {
    
    var kListenRecommendArray: [JGuessYouLikeModel]?
    
    // 在OC中用NSStringFromClass获取类的字符串 但在Swift中NSStringFromClass得到的"你的工程名字.YourTableViewCell"
    // 还是老老实实写个字符串吧
    private let KListenRecommendTableViewCellId = "KListenRecommendTableViewCellId"
    
    // MARK: - 懒加载
    private lazy var kTBView: UITableView = {
        // LTTableViewProtocal
        let kTBView = tableViewConfig(CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - StatusHeight! - NavHeight! - TabBarHeight!), self, self, nil)
        kTBView.register(KListenRecommendTableViewCell.self, forCellReuseIdentifier: KListenRecommendTableViewCellId)
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
        
        self.requestData()
    }

}

// MARK: - 请求
extension KListenRecommendViewController {
    
    func requestData() {
        // 网络请求入口
        KListenMoyaProvider.request(.guessYouLikeMoreList) { result in
            if case let .success(response) = result {
                // 解析数据 使用KaKaJson转模型 主要OC使用MJExtension
                let data = try? response.mapJSON()
                let json = JSON(data!) // SwiftyJSON
                let jsonList = json["list"].description
                /*
                let jsonList: [[String: Any]] = [
                    ["title": "a", "recReason": "1"],
                    ["title": "b", "recReason": "2"],
                    ["title": "c", "recReason": "3"]
                ]
                */
                self.kListenRecommendArray = jsonList.kj.modelArray(JGuessYouLikeModel.self)
                self.kTBView.reloadData()
            }
        }
    }
}

// MARK: - TableView 数据源和代理
extension KListenRecommendViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return  kListenRecommendArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return SizeFloat(x: 100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kListenRecommendTBVCell: KListenRecommendTableViewCell = tableView.dequeueReusableCell(withIdentifier: KListenRecommendTableViewCellId, for: indexPath) as! KListenRecommendTableViewCell
        kListenRecommendTBVCell.selectionStyle = UITableViewCell.SelectionStyle.none
        kListenRecommendTBVCell.jmodel = kListenRecommendArray?[indexPath.row]
        return kListenRecommendTBVCell
    }
}
