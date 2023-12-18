//
//  UserData.swift
//  weiboDemo2
//
//  Created by tt Wong on 27/10/2020.
//
//published 全部都會變化
import Combine
//環境對象:遵循的協議
class UserData: ObservableObject {
 @Published   var recommendPostList: PostList = loadPostListData("PostListData_recommend_1.json")
 @Published   var followedPostList: PostList = loadPostListData("PostListData_hot_1.json")
 @Published   var isRefreshing: Bool = false //默認刷新
 @Published   var isLoadingMore: Bool = false //默認上拉刷新
 @Published   var loadingError: Error? //默認出錯信息
    
    private var recommendPostDic: [Int: Int] = [:] //id: index【key：value】
    private var followedPostDic: [Int: Int]  = [:]//id: index
    //先初始化
    init() {
        for i in 0..<recommendPostList.list.count {
            let post = recommendPostList.list[i]
            recommendPostDic[post.id] = i
        }
        
        for i in 0..<followedPostList.list.count {
            let post = followedPostList.list[i]
            followedPostDic[post.id] = i
        }
    }
    
}
enum PostListCategory { //所有取值都是已知的
    case recommend, followed
 
}

//通過列表類型找到微博，返回postList
extension UserData {
    //是否展示加載錯誤的信息,如果加載錯誤信息不為空，展示加載信息
    var showLoadingError: Bool { loadingError != nil }
    var loadingErrorText: String {loadingError?.localizedDescription ?? ""} //雙問號，給錯誤信息提供沒人質
    func postList(for category: PostListCategory) -> PostList {
        switch category {
        case .recommend:
            return recommendPostList
        case.followed:
            return followedPostList
        }
    }
    //找id-對應的post
    func post(forId id: Int) -> Post? {
       if let index = recommendPostDic[id] {
        
        return recommendPostList.list[index]
        
        }
        
        if let index = followedPostDic[id] {
         
         return followedPostList.list[index]
         
         }
        return nil
    }
    
    func update(_ post: Post) {
        if let index = recommendPostDic[post.id] {
            recommendPostList.list[index] = post
        }
        
        if let index = followedPostDic[post.id] {
            followedPostList.list[index] = post
        }
        
    }
}

