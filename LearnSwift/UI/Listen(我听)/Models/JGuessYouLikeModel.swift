//
//  JGuessYouLikeModel.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/10.
//  Copyright © 2020 hkshen. All rights reserved.
//

import Foundation
import KakaJSON

struct JGuessYouLikeModel: Convertible {
    var albumId: Int = 0
    var categoryId: Int = 0
    var commentsCount: Int = 0
    var infoType: String?
    var isDraft: Bool = false
    var isFinished: Int = 0
    var isPaid: Bool = false
    var isVipFree: Bool = false
    var lastUptrackAt: Int = 0
    var materialType: String?
    var nickname: String?
    var pic: String?
    var playsCount: Int = 0
    var recSrc: String?
    var recTrack: String?
    var refundSupportType: Int = 0
    var subtitle: String?
    var title: String?
    var tracksCount: Int = 0
    var vipFreeType: Int = 0
    
    /// 更多追加
    var coverMiddle:String?
    var recReason:String?
    var tracks:Int = 0
    var playsCounts:Int = 0
}
