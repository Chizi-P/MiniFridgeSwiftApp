//
//  NetworkAPI.swift
//  MiniFridge
//
//  Created by 🐽 on 3/11/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import Foundation
import SwiftUI
import Alamofire

class NetworkAPI {
    
    
    
//    static func recommendPostList(completion: @escaping (Result<PostList, Error>) -> Void) {
//        NetworkManager.shared.requestGet(path: "", parameters: nil) { result in
//            switch result {
//            case let .success(data):
//                let parseResult : Result<PostList, Error> = self.parseData(data)
//                completion(parseResult)
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
//
//    static func createPost(text: String, completion: @escaping (Result<Post, Error>) -> Void) {
//        NetworkManager.shared.requestPost(path: "createpost", parameters: ["text": text]) { result in
//            switch result {
//            case let .success(data):
//                let parseResult: Result<Post, Error> = self.parseData(data)
//                completion(parseResult)
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
//    }
    
    
    
    
    // 解碼 有result
    private static func parseData<T: Codable>(_ data: Data) -> APIResult<T> {
//        do {
//            return try JSONDecoder().decode(APIResult<T>.self, from: data)
//        } catch {
//            print("Can not parse data")
//        }
//        return try! (JSONDecoder().decode(APIResult<T>.self, from: data))
        
        guard let decodeData = try? JSONDecoder().decode(APIResult<T>.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
            print(error)
            return APIResult(success: false, message: error as? String ?? "", result : "error" as? T, error : "error")
        }
        return decodeData
        
//        if decodeData.success {
//            return .success(decodeData.result!)
//        } else {
//            let err = NSError(domain: "ServerAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: decodeData.error! as String])
//            return .failure(err)
//        }
    }
    
    // 解碼 無result
    private static func parseDatan(_ data: Data) -> APIResultn {
        guard let decodeData = try? JSONDecoder().decode(APIResultn.self, from: data) else {
            let error = NSError(domain: "NetworkAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Can not parse data"])
            return APIResultn(success: false, message: error as? String ?? "", error : "error")
        }
        return decodeData
//        if decodeData.success {
//            return .success(true)
//        } else {
//            let err = NSError(domain: "ServerAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: (decodeData.error ?? "伺服器問題") as String])
//            return .failure(err)
//        }
    }
    
    static var token = userDefaults.string(forKey: "token") ?? ""
    
    // ！輸入remark
//    static func getUserPost(username: String, completion: @escaping (Result<[UserPost], Error>) -> Void) {
//        NetworkManager.shared.requestGet(path: "user/\(username)/post", parameters: ["":""]) { result in
//            switch result {
//            case let .success(data):
//                let parseResult: Result<APIResult<[UserPost]>, Error> = self.parseData(data)
//
//                switch parseResult {
//                case let .success(data):
//                    if data.success {
//                        completion(Result.success(data.result!))
//                    }
//                case let .failure(error):
//                    completion(Result.failure(error))
//
////                if parseResult.success {
////                    return .success(decodeData.result!)
////                } else {
////                    let err = NSError(domain: "ServerAPIError", code: 0, userInfo: [NSLocalizedDescriptionKey: decodeData.error! as String])
////                    return .failure(err)
////                }
////
//            }
//            case .failure(_):
//
//            }
//    }
//
    /*
     
     static func createPostIt(label: String, count: Int, remark: String?, completion: @escaping (Result<Bool, Error>) -> Void) {
     
     //        let imageData = image.jpegData(compressionQuality: 0.50)! // 轉換成 Data
     ////        let imageData: NSData = image.pngData()! as NSData
     //        let strBase64 : String = imageData.base64EncodedString(options: .lineLength64Characters)
     //        print(strBase64)
     
     //        "image": "\(strBase64)"
     
     NetworkManager.shared.requestGet(path: "createpostit", parameters: ["label": label, "count": count, "remark": remark ?? "", "token": token]) { result in
     switch result {
     case let .success(data):
     let parseResult: Result<Bool, Error> = self.parseDatan(data)
     completion(parseResult)
     case let .failure(error):
     completion(.failure(error))
     }
     }
     }
     
     */
    
    // 完成
    static func deletePostIt(postItID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "api/deletepostit", parameters: ["postItID": postItID]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(true))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    // 完成
    static func getAllPostIt(completion: @escaping (Result<[PostIt], Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "api/getpostit", parameters: ["":""]) { result in
            switch result {
            case let .success(data):
                let parseResult : APIResult<[PostIt]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func updataAvatar(avatar: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
        let resizeImage = avatar.resizeTo(size: CGSize(width: 500, height: 500))
        let imageData = resizeImage.jpegData(compressionQuality: 0.1)!
        
        NetworkManager.shared.requestUpload(path: "api/userdata/avatar/update", parameters: ["":""], data: imageData, withName: "avatar", fileName: "avatar.jpeg", mineType: "image/jpeg", addtoken: false) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(true))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getAvatar(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "user/\(username)/avatar", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[getAvatar]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result![0].avatar))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
        
    }
    
    // ！ 可能需要支持上傳多張圖片 ！ 整合
    static func uploadImage(image: UIImage, completion: @escaping (Result<Bool, Error>) -> Void) {
        let imageData = image.jpegData(compressionQuality: 0.50)! // 轉換成 Data
        //        let imageData: NSData = image.pngData()! as NSData
        let strBase64 = imageData.base64EncodedString(options: .lineLength64Characters)
        print(strBase64)
        
        NetworkManager.shared.requestGet(path: "api/uploadimage", parameters: ["image": strBase64]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(true))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // ！ 應該要順便返回一些私人資料
    static func signIn(username: String, password: String, completion: @escaping (Result<SignIn, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "api/signin", parameters: ["username": username, "password": password]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<SignIn> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func signUp(username: String, password: String, email: String, avatar: UIImage, userType: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let resizeImage = avatar.resizeTo(size: CGSize(width: 500, height: 500))
        let imageData = resizeImage.jpegData(compressionQuality: 0.1)!
        
        NetworkManager.shared.requestUpload(path: "api/signup", parameters: ["username": username, "password": password, "email": email, "userType": userType], data: imageData, withName: "avatar", fileName: "avatar.jpeg", mineType: "image/jpeg", addtoken: false) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
        
        
//        NetworkManager.shared.requestGet(path: "api/signup", parameters: ["username": username, "password": password]) { result in
//            switch result {
//            case let .success(data):
//                let parseResult: APIResult<Bool?> = self.parseData(data)
//                if parseResult.success {
//                    completion(.success(true))
//                } else {
//                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
//                }
//            case let .failure(error):
//                completion(.failure(error))
//            }
//        }
    }
    
    static func getSelfUserData(completion: @escaping (Result<User, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "api/userdata", parameters: nil) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[User]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result![0]))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func createPost(title: String, introduction: String, images: UIImage, postType: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        let resizeImage = images.resizeTo(size: CGSize(width: 500, height: 500))
        let imageData = resizeImage.jpegData(compressionQuality: 0.1)!
        
        NetworkManager.shared.requestUpload(path: "api/post", parameters: ["title": title, "introduction": introduction, "postType": postType], data: imageData, withName: "images", fileName: "images.jpeg", mineType: "image/jpeg", addtoken: true) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // ！ 被singleUserPost取代
    static func selfPost(username: String, completion: @escaping (Result<[UserPost], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "user/\(username)/post", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[UserPost]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func singleUserPost(username: String, completion: @escaping (Result<[UserPost], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "user/\(username)/post", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[UserPost]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func followPost(username: String, postType: String, completion: @escaping (Result<[UserPost], Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "user/\(username)/followpost", parameters: ["postType": postType]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[UserPost]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func hotPost(completion: @escaping (Result<[UserPost], Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "hotpost", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[UserPost]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getPostComment(postID: Int, completion: @escaping (Result<[Comment], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "post/\(postID)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[Comment]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func createComment(postID: Int, text: String, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "api/post/\(postID)/comment/\(text)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func searchUser(username: String, completion: @escaping (Result<[User], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "search/userlike/\(username)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[User]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func toFollow(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "api/tofollow/\(username)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func unFollow(username: String, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "api/unfollow/\(username)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func isFollow(username1: String, username2: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "\(username1)/isfollow/\(username2)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<Bool> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func followingCount(username: String, completion: @escaping (Result<[FollowingCount], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "user/\(username)/followingcount", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[FollowingCount]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func followerCount(username: String, completion: @escaping (Result<[FollowerCount], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "user/\(username)/followercount", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[FollowerCount]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func postCount(username: String, completion: @escaping (Result<[PostCount], Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "user/\(username)/postcount", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[PostCount]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func toLike(postID: Int, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "api/tolike/post/\(postID)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func unLike(postID: Int, completion: @escaping (Result<String, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "api/unlike/post/\(postID)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func isLike(username: String, postID: Int, completion: @escaping (Result<Bool, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "user/\(username)/islike/post/\(postID)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<Bool> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func postLikeCount(postID: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "post/\(postID)/likecount", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<Int> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    
    // 完成
    static func createPostIt(label: String, count: Int, remark: String, image: UIImage, completion: @escaping (Result<String, Error>) -> Void) {
        //Parameter HERE
        let parameters : [String: String] = [
            "label" : label,
            "count" : "\(count)",
            "remark": remark
        ]
        var headers : HTTPHeaders {[
            "token" : token,
            "Content-type": "multipart/form-data",
            "Content-Disposition" : "form-data"
        ]}
        //！ 要按比例
        let resizeImage = image.resizeTo(size: CGSize(width: 500, height: 500))
        let imageData = resizeImage.jpegData(compressionQuality: 0.1)!
        
        AF.upload(multipartFormData: { multipartFormData in
            // for img in image {
            multipartFormData.append(imageData, withName: "image", fileName: "image.jpeg", mimeType: "image/jpeg")
            // }
            for (key, value) in parameters {
                multipartFormData.append((value as String).data(using: String.Encoding.utf8)!, withName: key)
            }
        },to: "https://minifridge.herokuapp.com/api/createpostit", usingThreshold: UInt64.init(),
        method: .post, headers: headers).response{ response in
            if (response.error != nil) {
                do {
                    if let jsonData = response.data{
                        let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                        print("parsedData: ", parsedData)
                    }
                } catch {
                    print("error message")
                    completion(.failure(error))
                }
            } else {
                print("response: ", response)
                completion(.success("成功"))
            }
        }
    }
    
    static func getModelData(label: String, completion: @escaping (Result<[ModelData], Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "getmodeldata", parameters: ["label": label]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[ModelData]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    // Shop
    static func createShopPost(username: String, image: UIImage, title: String, cost: Float, introduction: String, type: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        //！ 要按比例
        let resizeImage = image.resizeTo(size: CGSize(width: 500, height: 500))
        let imageData = resizeImage.jpegData(compressionQuality: 0.1)!
        
        let parameters : [String : String]  = [
            "username" : username,
            "title" : title,
            "cost" : "\(cost)",
            "introduction" : introduction,
            "type" : type
        ]
        
        NetworkManager.shared.requestUpload(path: "api/createshoppost", parameters: parameters, data: imageData, withName: "images", fileName: "images.jpeg", mineType: "image/jpeg", addtoken: true) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResultn = self.parseDatan(data)
                if parseResult.success {
                    completion(.success(parseResult.message))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getFoodType(completion: @escaping (Result<[FoodType], Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "foodtype", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[FoodType]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getShopPost(type : String, completion: @escaping (Result<[Shop], Error>) -> Void) {
        NetworkManager.shared.requestPost(path: "getshoppost", parameters: ["type": type]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<[Shop]> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    static func getPost(postID: Int, completion: @escaping (Result<UserPost, Error>) -> Void) {
        NetworkManager.shared.requestGet(path: "post/postID/\(postID)", parameters: [:]) { result in
            switch result {
            case let .success(data):
                let parseResult: APIResult<UserPost> = self.parseData(data)
                if parseResult.success {
                    completion(.success(parseResult.result!))
                } else {
                    completion(.failure(NSError(domain: parseResult.message, code: 0)))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}


// 定義數據結構
struct APIResult<T: Codable> : Codable{
    let success : Bool
    let message : String
    let result : T?
    let error : String?
}

struct APIResultn: Codable{
    let success : Bool
    let message : String
    let error : String?
}

struct SignIn: Codable {
    let token : String
}

struct User: Codable, Hashable {
    let username : String
    let email : String
    let create_time: String
    let avatar : String
    let introduction : String
    let userType : String
}
let presetUser = User(username: "", email: "", create_time: "", avatar: "", introduction: "", userType: "神秘莫測")

// ！Post名稱被使用
//struct Post {
//    let postID : Int
//    let username : String
//    let images : String
//    let text : String
//    let create_time: String
//}
struct UserPost: Codable, Hashable {
    let postID : Int
    let username : String
    let images : String
    let title : String
    let introduction : String
    let create_time: String
    let postType : String
}
let presetUserPost = UserPost(postID: 0, username: "加載中", images: "", title: "加載中", introduction: "加載中", create_time: "加載中", postType: "文章")

struct Likes: Codable {
    let likeID : Int
    let username : String
    let postID : Int
    let create_time: String
}

struct Comment: Codable, Hashable {
    let commentID: Int
    let username: String
    let postID: Int
    let text: String
    let create_time: String
}
let presetComment = Comment(commentID: 0, username: "", postID: 1, text: "", create_time: "")

struct ModelData: Codable, Hashable {
    let id : Int
    let label : String
    let introduction : String
    let bestBefore : String
    let calories : Double
    let fat : Double
    let carbohydrates : Double
    let protein : Double
    let type : String
}
let presetModelData = ModelData(id: 0, label: "", introduction: "", bestBefore: "", calories: 0, fat: 0, carbohydrates: 0, protein: 0, type: "")

struct PostIt: Codable, Hashable {
    let postItID : Int
    let username : String
    let label : String
    let image : String
    let count : Int
    let remark : String
    let hidden : Int
    let create_time : String
    let information : String?
    var modelData : ModelData? = presetModelData
}
// 預設數據
let presetPostIt = PostIt(postItID: 0, username: "用戶", label: "加載中", image: "", count: 0, remark: "加載中", hidden: 0, create_time: "加載中", information: "加載中", modelData: ModelData(id: 0, label: "", introduction: "", bestBefore: "", calories: 0, fat: 0, carbohydrates: 0, protein: 0, type: "其他"))


struct getAvatar: Codable {
    let avatar : String
}

struct Shop: Codable, Hashable {
    let shopID : Int
    let username : String
    let images : String
    let title : String
    let cost : Float
    let introduction : String
    let type : String
    let create_time : String
}
let presetShop = Shop(shopID: 0, username: "", images: "", title: "", cost: 0, introduction: "", type: "", create_time: "")

// 因為有可能擴張所以保留只有一個數據的struct FoodType
struct FoodType: Codable, Hashable {
    let foodType : String
}

struct FollowingCount: Codable, Hashable {
    let followingCount : Int
}
struct FollowerCount: Codable, Hashable {
    let followerCount : Int
}
struct PostCount: Codable, Hashable {
    let postCount : Int
}
