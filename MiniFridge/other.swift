
//  after.swift
//  MiniFridge
//
//  Created by 🐽 on 28/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

// 磨砂模糊
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIVisualEffectView { UIVisualEffectView() }
    func updateUIView(_ uiView: UIVisualEffectView, context: UIViewRepresentableContext<Self>) { uiView.effect = effect }
}
// 使用方法 View
// VisualEffectView(effect: UIBlurEffect(style: .dark))
//                .edgesIgnoringSafeArea(.all)


// 百分比編碼
func escapedString(_ originalString: String) -> String {
    return originalString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
}

// 獲取日期時間
func getDate() -> String {
    let currentDate = Date()
    
    let dataFormatter = DateFormatter() //實體化日期格式化物件
    dataFormatter.locale = Locale(identifier: "zh_Hant_TW")
    dataFormatter.dateFormat = "YYYY年MM月dd日 HH:MM" //參照ISO8601的規則
    let stringDate = dataFormatter.string(from: currentDate)
    return stringDate
}


let userDefaults = UserDefaults.standard

func resetDefaults() {
    userDefaults.dictionaryRepresentation().keys.forEach(userDefaults.removeObject(forKey:))
}

// userDefaults.set("1", forKey: "ji")

//let postItListData = UserDefaults.standard
//class UpdataPostItData: ObservableObject {
//    @Published var postItData: [PostItData] {
//        didSet {
//            UserDefaults.standard.set(postItData, forKey: "postItData")
//        }
//    }
//
//    init() {
//        self.postItData = UserDefaults.standard.object(forKey: "postItData") as? [PostItData] ?? []
//    }
//}

//
//func savePostIt(postItDatas: [PostItData]) {
//    postItListData.set(postItDatas, forKey: "postItDatas")
//}
//
//func getPostIt() {
//    postItListData.value(forKey: "postItDatas")
//}


func setPostIt(postIt: PostItData) {
    // 拿出数据
    let objData = userDefaults.data(forKey: "postItData")
    // 解码
    let decoder : JSONDecoder = JSONDecoder()
    var decoded = try? decoder.decode([PostItData].self, from: objData!)
    //    var postItDatas = NSKeyedUnarchiver.unarchiveObject(with: objData!) as? [PostItData]
    
    // 在Array裡增加一笔资料
    decoded?.append(postIt)
    // 轉data
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(decoded) {
        // 储存数据
        userDefaults.set(encoded, forKey: "postItData")
    }
    //    let data = try? NSKeyedArchiver.archivedData(withRootObject: postItDatas, requiringSecureCoding: true)
}
//
//func getPostIt() -> [PostItData] {
//    let objData = userDefaults.data(forKey: "postItData")
//    let decoder : JSONDecoder = JSONDecoder()
//    if let decoded = try? decoder.decode([PostItData].self, from: objData!) {
//        return decoded
//    }
//    return [PostItData(label: "Error", count: 0, date: getDate(), content: "Error")]
//}


func encodedPostIt(_ postIt: [PostIt]) -> Data {
    //    let encoder = JSONEncoder()
    return try! JSONEncoder().encode(postIt)
}

func decodedPostIt(_ objData: Data) -> [PostIt] {
    return try! JSONDecoder().decode([PostIt].self, from: objData)
}

func NSencodedPostIt(_ postItData: [PostItData]) -> Data {
    return try! NSKeyedArchiver.archivedData(withRootObject: postItDatas, requiringSecureCoding: true)
}

//func NSdecodedPostIt(_ objData: Data) -> [PostItData] {
//    return try! NSKeyedUnarchiver.unarchivedArrayOfObjects(ofClass: PostItData.self, from: objData)
//}



//func encoded<T: Codable>(_ object: T) -> Data {
//    return try! JSONEncoder().encode(object)
//}

func decoded<T: Codable>(_ data: Data) -> T {
    return try! JSONDecoder().decode(T.self, from: data)
}


class UDM {
    static let shared = UDM()
    
    @AppStorage("token") var token = ""
    @AppStorage("isSignIn") var isSignIn = false
    @AppStorage("username") var username = ""
    @AppStorage("avatar") var avatar = ""
    @AppStorage("email") var email = ""
    @AppStorage("create_time") var create_time = ""
    @AppStorage("userType") var userType = ""
    @AppStorage("introduction") var introduction = ""
    @AppStorage("postCount") var postCount : Int = 0
    @AppStorage("followingCount") var followingCount : Int = 0
    @AppStorage("followerCount") var followerCount : Int = 0
    
    @AppStorage("isSigninLoading") var isSigninLoading = false
    @AppStorage("alertSignInMessage") var alertSignInMessage = false
    @AppStorage("signInMessage") var signInMessage = ""
    
    @AppStorage("goLogin") var goLogin = false
    @AppStorage("registered") var registered = false
    @AppStorage("isregisteredLoading") var isregisteredLoading = false
    @AppStorage("alertregisteredMessage") var alertregisteredMessage = false
    @AppStorage("registeredMessage") var registeredMessage = ""
    
    @AppStorage("isShowSetting") var isShowSetting = false
    
    @AppStorage("posting") var posting = false
    @AppStorage("isPostingLoading") var isPostingLoading = false
    @AppStorage("alertpostingMessage") var alertpostingMessage = false
    @AppStorage("postingMessage") var postingMessage = ""
    
    @AppStorage("shopPosting") var shopPosting = false
    @AppStorage("isShopPostingLoading") var isShopPostingLoading = false
    @AppStorage("alerShopPostingMessage") var alerShopPostingMessage = false
    @AppStorage("shopPostingMessage") var shopPostingMessage = ""
    @AppStorage("isNavigationBarRightButton") var isNavigationBarRightButton = false
    
    @AppStorage("userPost") var userPost : Data = try! JSONEncoder().encode([presetUserPost])
    @AppStorage("alertGetUserPostMessage") var alertGetUserPostMessage = false
    @AppStorage("getUserPostMessage") var getUserPostMessage = ""
    
    @AppStorage("recommendedPost") var recommendedPost = try! JSONEncoder().encode([presetUserPost])
    
    // ！要刪掉
    @AppStorage("hotPost") var hotPost : Data = try! JSONEncoder().encode([presetUserPost])
    
    @AppStorage("alertCreateCommentMessage") var alertCreateCommentMessage = false
    @AppStorage("createCommentMessage") var createCommentMessage = ""
    @AppStorage("commented") var commented = false
    
    @AppStorage("followPost") var followPost : Data = try! JSONEncoder().encode([presetUserPost])
    @AppStorage("alertGetFollowPostMessage") var alertGetFollowPostMessage = false
    @AppStorage("getFollowPostMessage") var getFollowPostMessage = ""
    
    @AppStorage("modelDatas") var modelDatas : Data = try! JSONEncoder().encode([presetModelData])
    
    @AppStorage("favorites") var favorites : Data = try! JSONEncoder().encode([presetFavorites])
    
    @AppStorage("postItUpdateView") var postItUpdateView : Bool = false
    // 更新post畫面
    @AppStorage("updatePostView") var updatePostView = false

    //    @AppStorage("postIt") var postIt = ""
    func signIn(username: String, password: String) {
        self.isSigninLoading = true
        NetworkAPI.signIn(username: username, password: password) { result in
            switch result {
            case let .success(data):
                NetworkManager.shared.token = data.token
                self.token = data.token
                print("token: ", self.token)
                self.isSignIn = true
            case let .failure(error):
                // ！ 跳出提示框
                print(error)
                self.signInMessage = (error as NSError).domain
                self.alertSignInMessage = true
            }
            self.isSigninLoading = false
        }
    }
    
    func signOut() {
        ["token",
         "username",
         "avatar",
         "email",
         "create_time",
         "introduction",
         "postCount",
         "followingCount",
         "followerCount",
         "postIt"
        ].forEach { key in
            userDefaults.removeObject(forKey: key)
            print("remove: ", key)
        }
        self.isSignIn = false
        self.isShowSetting = false
    }
    
    func signUp(username: String, password: String, email: String, avatar: UIImage, userType: String) {
        self.isregisteredLoading = true
        NetworkAPI.signUp(username: username, password: password, email: email, avatar: avatar, userType: userType) { result in
            switch result {
            // ！ 沒返回成功登入的message
            case .success(_):
                self.registered = false
            case let .failure(error):
                self.alertregisteredMessage = true
                self.registeredMessage = (error as NSError).domain
            }
            self.isregisteredLoading = false
        }
    }
    
    func getUserData() {
        NetworkAPI.getSelfUserData { result in
            switch result {
            case let .success(data):
                self.username = data.username
                self.avatar = data.avatar
                self.email = data.email
                self.create_time = data.create_time
                self.introduction = data.introduction
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func updataAvatar(avatar: UIImage) {
        NetworkAPI.updataAvatar(avatar : avatar) { result in
            switch result {
            case let .success(data):
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func createPost(title: String, introduction: String, images: UIImage, postType: String) {
        self.isPostingLoading = true
        NetworkAPI.createPost(title: title, introduction: introduction, images: images, postType: postType) { result in
            switch result {
            case let .success(message):
                self.posting = false
                print("createPost-message: ", message)
            case let .failure(error):
                self.alertpostingMessage = true
                self.postingMessage = (error as NSError).domain
                print(error)
            }
            self.isPostingLoading = false
            self.updatePostView.toggle()
        }
    }
    
    func getSelfPost() {
        NetworkAPI.singleUserPost(username: self.username) { result in
            switch result {
            case let .success(data):
                self.userPost = try! JSONEncoder().encode(data)
            case let .failure(error):
                self.alertGetUserPostMessage = true
                self.getUserPostMessage = (error as NSError).domain
                print(error)
            }
            self.isPostingLoading = false
        }
    }
    
    func singleUserPost(username: String, completion: @escaping ([UserPost]) -> Void) {
        NetworkAPI.singleUserPost(username: username) { result in
            switch result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getFollowPost(postType: String, completion: @escaping ([UserPost]) -> Void) {
        NetworkAPI.followPost(username: self.username, postType: postType) { result in
            switch result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                self.alertGetFollowPostMessage = true
                self.getFollowPostMessage = (error as NSError).domain
                print(error)
            }
        }
    }
    
    func getHotPost(completion: @escaping ([UserPost]) -> Void) {
        NetworkAPI.hotPost() { result in
            switch result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getAvatar(username: String, completion: @escaping (String) -> Void) {
        NetworkAPI.getAvatar(username: username) { result in
            switch result {
            case let .success(string):
                completion(string)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getPostComment(postID: Int, completion: @escaping ([Comment]) -> Void) {
        NetworkAPI.getPostComment(postID: postID) { result in
            switch result {
            case let .success(data):
                completion(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func createComment(postID: Int, text: String, completion: @escaping (String) -> Void) {
        NetworkAPI.createComment(postID: postID, text: text) { result in
            switch result {
            case let .success(string):
                self.commented = true
                completion(string)
            case let .failure(error):
                self.alertCreateCommentMessage = true
                self.createCommentMessage = (error as NSError).domain
                print(error)
            }
        }
    }
    
    func searchUser(username: String, completion: @escaping ([User]) -> Void) {
        NetworkAPI.searchUser(username: username) { result in
            switch result {
            case let .success(data):
                print(data)
                completion(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func toFollow(username: String, completion: @escaping (String) -> Void) {
        NetworkAPI.toFollow(username: username) { result in
            switch result {
            case let .success(message):
                completion(message)
                print(message)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func unFollow(username: String, completion: @escaping (String) -> Void) {
        NetworkAPI.unFollow(username: username) { result in
            switch result {
            case let .success(message):
                completion(message)
                print(message)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func isFollow(username1: String, username2: String, completion: @escaping (Bool) -> Void) {
        NetworkAPI.isFollow(username1: username1, username2: username2) { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func followingCount(username: String, completion: @escaping (FollowingCount) -> Void) {
        NetworkAPI.followingCount(username: username) { result in
            switch result {
            case let .success(data):
                completion(data[0])
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func followerCount(username: String, completion: @escaping (FollowerCount) -> Void) {
        NetworkAPI.followerCount(username: username) { result in
            switch result {
            case let .success(data):
                completion(data[0])
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func postCount(username: String, completion: @escaping (PostCount) -> Void) {
        NetworkAPI.postCount(username: username) { result in
            switch result {
            case let .success(data):
                completion(data[0])
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func toLike(postID: Int, completion: @escaping (String) -> Void) {
        NetworkAPI.toLike(postID: postID) { result in
            switch result {
            case let .success(message):
                completion(message)
                print(message)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func unLike(postID: Int, completion: @escaping (String) -> Void) {
        NetworkAPI.unLike(postID: postID) { result in
            switch result {
            case let .success(message):
                completion(message)
                print(message)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func isLike(username: String, postID: Int, completion: @escaping (Bool) -> Void) {
        NetworkAPI.isLike(username: username, postID: postID) { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func postLikeCount(postID: Int, completion: @escaping (Int) -> Void) {
        NetworkAPI.postLikeCount(postID: postID) { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // Shop
    func createShopPost(username: String, image: UIImage, title: String, cost: Float, introduction: String, type: String, completion: @escaping (String) -> Void) {
        self.isShopPostingLoading = true
        NetworkAPI.createShopPost(username: username, image: image, title: title, cost: cost, introduction: introduction, type: type) { result in
            switch result {
            case let .success(message):
                self.shopPosting = false
                completion(message)
                self.isNavigationBarRightButton = false
                self.isShopPostingLoading = false
                
                print(message)
            case let .failure(error):
                self.shopPostingMessage = (error as NSError).domain
                self.alerShopPostingMessage = true
                print(error)
            }
        }
    }
    
    func getFoodType(completion: @escaping ([FoodType]) -> Void) {
        NetworkAPI.getFoodType { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getShopPost(type: String, completion: @escaping ([Shop]) -> Void) {
        NetworkAPI.getShopPost(type: type) { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getPost(postID: Int, completion: @escaping (UserPost) -> Void) {
        NetworkAPI.getPost(postID: postID) { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func getModelData(label: String, completion: @escaping ([ModelData]) -> Void) {
        NetworkAPI.getModelData(label: label) { result in
            switch result {
            case let .success(data):
                completion(data)
                print(data)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    // PostIt
    func createPostIt(label: String, count: Int, remark: String, image: UIImage, completion: @escaping (String) -> Void) {
        NetworkAPI.createPostIt(label: label, count: count, remark: remark, image: image) { result in
            switch result {
            case let .success(message):
                self.postItUpdateView = true
                completion(message)
                print(message)
            case let .failure(error):
                print(error)
            }
        }
    }
}

