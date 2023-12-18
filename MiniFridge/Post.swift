//
//  Post.swift
//  weiboDemo2
//
//  Created by tt Wong on 24/10/2020.
//

import Foundation
import UIKit
import SwiftUI

struct PostList: Codable {
    var list: [Post]
}

//Data Model


struct Post: Codable, Identifiable {
    //Property 屬性
    let id: Int
    let avatar: String //頭像，圖片名稱
    let vip: Bool //ture/false
    let name: String
    let date: String
    let title: String
    
    var isFollowed: Bool
    
    let text: String
    let images: [String]
    
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
}
//添加誇長
extension Post: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

//擴張類型-和view相關的東西
 extension Post {
        
    var avatorImage: Image {
        return  loadImage(name: avatar)
    }
    
    //只讀屬性/只能獲取值，不能獲取
    var commentCountText: String {
        if commentCount <= 0 { return "評論" }
        if commentCount < 1000 { return "\(commentCount)" }
        return String(format: "%.1fK", Double(commentCount) / 1000)
    }
    var likeCountText: String {
        if likeCount <= 0 { return "評論" }
        if likeCount < 1000  { return "\(likeCount)" }
        return String(format: "%.1fK", Double(likeCount) / 1000) //%f代表這個是小數.1就是保留一位小數
    }
    
  }


//let postList = loadPostListData("PostListData_hot_1.json")

func loadPostListData(_ fileName: String) -> PostList {
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("Can not find \(fileName) in main bundle")
    }
    guard let data = try? Data(contentsOf: url) else {
        fatalError("Can not load \(url)")
    }
    guard let list = try? JSONDecoder().decode(PostList.self, from: data) else {
        fatalError("Can not parse post list json data")

 }
return list

}

func loadImage(name: String) -> Image {
    return Image(uiImage: UIImage(named: name)!)
}






