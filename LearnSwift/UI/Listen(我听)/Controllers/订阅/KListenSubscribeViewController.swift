//
//  KListenSubscribeViewController.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/9.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit
import LTScrollView
import Alamofire
import HandyJSON
import SwiftyJSON

class KListenSubscribeViewController: UIViewController, LTTableViewProtocal {
    
    var kListenSubscribeArray: [KGuessYouLikeModel]?
    
    // 在OC中用NSStringFromClass获取类的字符串 但在Swift中NSStringFromClass得到的"你的工程名字.YourTableViewCell"
    // 还是老老实实写个字符串吧
    private let KListenSubscribeTableViewCellId = "KListenSubscribeTableViewCellId"
    
    // MARK: - 懒加载
    private lazy var kTBView: UITableView = {
        // LTTableViewProtocal
        let kTBView = tableViewConfig(CGRect(x: 0, y: 0, width: Screen_Width, height: Screen_Height - StatusHeight! - NavHeight! - TabBarHeight!), self, self, nil)
        kTBView.register(KListenSubscribeTableViewCell.self, forCellReuseIdentifier: KListenSubscribeTableViewCellId)
        kTBView.backgroundColor = UIColor.init(r: 240, g: 241, b: 244)
        kTBView.separatorStyle = UITableViewCell.SeparatorStyle.none
        kTBView.tableFooterView = UIView()
        return kTBView
    }()
    
    // MARK: - VC周期
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
        
        self.requestData();
    }

}

// MARK: - 请求
extension KListenSubscribeViewController {
    
    func requestData() {
        // 网络请求入口
        KListenMoyaProvider.request(.guessYouLikeMoreList) { result in
            if case let .success(response) = result {
                // 解析数据 HandyJSON转模型
                let data = try? response.mapJSON()
                let json = JSON(data!) // SwiftyJSON
                if let kmodelArray = JSONDeserializer<KGuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.kListenSubscribeArray = kmodelArray as? [KGuessYouLikeModel] // []数组
                    self.kTBView.reloadData()
                }
            }
        }
    }
}

// MARK: - TableView 数据源和代理
extension KListenSubscribeViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return kListenSubscribeArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return SizeFloat(x: 100)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let kListenSubscribeTBVCell: KListenSubscribeTableViewCell = tableView.dequeueReusableCell(withIdentifier: KListenSubscribeTableViewCellId, for: indexPath) as! KListenSubscribeTableViewCell
        kListenSubscribeTBVCell.selectionStyle = UITableViewCell.SelectionStyle.none
        kListenSubscribeTBVCell.cmodel = kListenSubscribeArray?[indexPath.row]
        return kListenSubscribeTBVCell
    }
}
