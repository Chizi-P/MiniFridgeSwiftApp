//
//  NetworkManager.swift
//  MiniFridge
//
//  Created by 🐽 on 3/11/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkRequestResult = Result<Data, Error>
typealias NetworkRequestCompletion = (NetworkRequestResult) -> Void
//https://minifridge.herokuapp.com/
let minifridgePath = "http://localhost:60000/"
private let NetworkAPIBaseURL = "http://localhost:60000/api/"    // 路徑前端

class NetworkManager {
    static let shared = NetworkManager()
    var token = userDefaults.string(forKey: "token") ?? ""
    var commonHeaders: HTTPHeaders {["token": self.token]}
    
    private init() {} // 不允許進行定義
    
    // GET方法
    @discardableResult
    func requestGet(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(minifridgePath + path,
                   parameters: parameters,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
            }
    }

    // POST方法
    @discardableResult
    func requestPost(path: String, parameters: Parameters?, completion: @escaping NetworkRequestCompletion) -> DataRequest {
        AF.request(minifridgePath + path,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.prettyPrinted,
                   headers: commonHeaders,
                   requestModifier: { $0.timeoutInterval = 15})
            .responseData { response in
                switch response.result {
                case let .success(data): completion(.success(data))
                case let .failure(error): completion(self.handleError(error))
                }
            }
    }
    
//    @discardableResult
    func requestUpload(path: String, parameters: [String: String], data: Data, withName: String, fileName: String, mineType: String, addtoken: Bool, completion: @escaping NetworkRequestCompletion) -> Void {
        
        // ！ 我不知道怎麼給headers添加header進去
        var headers : HTTPHeaders {[
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data"
        ]}
        var tokenHeaders : HTTPHeaders {[
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data",
            "token": self.token
        ]}
        
        
        AF.upload(multipartFormData: { multipartFormData in
            // for img in image {
            multipartFormData.append(data, withName: withName, fileName: fileName, mimeType: mineType)
            // }
            for (key, value) in parameters {
                multipartFormData.append((value as String).data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: minifridgePath + path, usingThreshold: UInt64.init(),
        method: .post, headers: addtoken ? tokenHeaders : headers).responseData { response in
            switch response.result {
            case let .success(data): completion(.success(data))
            case let .failure(error): completion(self.handleError(error))
            }
        }
    }
    
    // 無網路連接之錯誤處理
    private func handleError(_ error: AFError) -> NetworkRequestResult {
        if let underlyingError = error.underlyingError {
            let nserror = underlyingError as NSError
            let code = nserror.code
            if  code == NSURLErrorNotConnectedToInternet ||
                code == NSURLErrorTimedOut ||
                code == NSURLErrorInternationalRoamingOff ||
                code == NSURLErrorDataNotAllowed ||
                code == NSURLErrorCannotFindHost ||
                code == NSURLErrorCannotConnectToHost ||
                code == NSURLErrorNetworkConnectionLost {
                var userInfo = nserror.userInfo
                userInfo[NSDebugDescriptionErrorKey] = "網路連接出現問題"
                let currentError = NSError(domain: nserror.domain, code: code, userInfo: userInfo)
                return .failure(currentError)
            }
        }
        return .failure(error)
    }
}


