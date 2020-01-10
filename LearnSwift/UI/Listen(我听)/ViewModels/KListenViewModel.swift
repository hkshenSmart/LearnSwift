//
//  KListenViewModel.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/10.
//  Copyright © 2020 hkshen. All rights reserved.
//

import UIKit
import HandyJSON
import SwiftyJSON

class KListenViewModel: NSObject {
    // 得到一个数组
    var kListenGuessYouLikeArray: [KGuessYouLikeModel]?
    
    // 闭包 可以想到OC的Block
    typealias BackDataBlock = () -> Void
    var backDataBlock: BackDataBlock?
}

extension KListenViewModel {
    func requestData() {
        KListenMoyaProvider.request(.guessYouLikeMoreList) { result in
            if case let .success(response) = result {
                //解析数据
                let data = try? response.mapJSON()
                let json = JSON(data!)
                if let kmodel = JSONDeserializer<KGuessYouLikeModel>.deserializeModelArrayFrom(json: json["list"].description) {
                    self.kListenGuessYouLikeArray = kmodel as? [KGuessYouLikeModel]
                    //self.collectionView.reloadData()
                }
            }
        }
    }
}
