//
//  KListenMoyaProvider.swift
//  LearnSwift
//
//  Created by hkshen on 2020/1/10.
//  Copyright © 2020 hkshen. All rights reserved.
//

import Foundation
import Moya // Moya是对Alamofire的封装 其地位有点点类似YTKNetwork YTKNetwork是对AFNetworking的封装
import HandyJSON

// Moya入口
let KListenMoyaProvider = MoyaProvider<KListenTargetType>()

enum KListenTargetType {
    // 不带参数写法
    case guessYouLikeMoreList
    // 带参数写法
    case login(account: String, password: String)
}

extension KListenTargetType: TargetType {
    // 基础请求地址
    var baseURL: URL {
        return URL.init(string: "http://mobile.ximalaya.com")!
    }
    // 请求地址路径 path会拼接在baseURL后面组成一个完整的请求地址
    var path: String {
        switch self {
        case .guessYouLikeMoreList:
            return "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
        case .login:
            return "/discovery-firstpage/guessYouLike/list/ts-1534815616591"
        }
    }
    // 请求方法 .post .get .put .delete等
    var method: Moya.Method {
        switch self {
        case .guessYouLikeMoreList:
            return .get
        case .login:
            return .post
        }
    }
    // 提供用于测试的存根数据 (可能使用到的次数不多)
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    // 请求任务 相当于URLSessionTask
    var task: Task {
        var parmeters: [String: Any] = [:]
        switch self {
        case .guessYouLikeMoreList:
            // 写死参数
            parmeters = [
                "device":"iPhone",
                "appid":0,
                "inreview":false,
                "network":"WIFI",
                "operator":3,
                "pageId":1,
                "pageSize":20,
                "scale":3,
                "uid":124057809,
                "version":"6.5.3",
                "xt": Int32(Date().timeIntervalSince1970),
                "deviceId": UIDevice.current.identifierForVendor!.uuidString]
            // .get 请求
            return .requestParameters(parameters: parmeters, encoding: URLEncoding.default)
        case .login(let account, let password):
            // 传入参数
            parmeters["account"] = account
            parmeters["password"] = password
            let cdata = try? JSONSerialization.data(withJSONObject: parmeters, options: [])
            // .post 请求
            return .requestData(cdata!)
        }
    }
    // 要在请求中使用的头
    //var headers: [String : String]? { return nil }
    var headers: [String : String]? { return ["Content-type" : "application/json"] }
    
    /*
    public enum Task {
        /// 没有其他数据的请求。
        case requestPlain
        ///设置httpBody数据。
        case requestData(Data)
        /// 请求体设置为`Encodable`类型
        case requestJSONEncodable(Encodable)
        /// 请求体设置为`Encodable`类型和自定义编码器
        case requestCustomJSONEncodable(Encodable, encoder: JSONEncoder)
        /// 请求具有编码参数的主体集。
        case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
        /// 请求主体设置数据，并结合url参数。
        case requestCompositeData(bodyData: Data, urlParameters: [String: Any])
        /// 请求使用编码参数和url参数组合的主体集。
        case requestCompositeParameters(bodyParameters: [String: Any], bodyEncoding: ParameterEncoding, urlParameters: [String: Any])
        ///文件上载任务。
        case uploadFile(URL)
        /// A "multipart/form-data" upload task.
        case uploadMultipart([MultipartFormData])
        /// A "multipart/form-data" upload task  结合url参数。
        case uploadCompositeMultipart([MultipartFormData], urlParameters: [String: Any])
        /// 到目的地的文件下载任务。
        case downloadDestination(DownloadDestination)
        /// 使用给定编码的具有额外参数的目标的文件下载任务。
        case downloadParameters(parameters: [String: Any], encoding: ParameterEncoding, destination: DownloadDestination)
    }
    */
}
