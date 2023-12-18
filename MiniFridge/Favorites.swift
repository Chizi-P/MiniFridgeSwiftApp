//
//  Favorites.swift
//  MiniFridge
//
//  Created by 🐽 on 6/12/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import Foundation
import SwiftUI

struct Favorites: Codable, Hashable {
    let favorite : [String : [Favorite]]
}
struct Favorite: Codable, Hashable {
    let item : Int
}
//var presetFavorites = Favorites(favorite: ["默認" : [Favorite(item: 0)]])
var presetFavorites : [String: Set<Int>] = ["默認": Set([])]

struct favorite: View {
    var favorite : [Int]
    @State var post : UserPost = presetUserPost
    var body: some View {
        Text("")
        ForEach(favorite, id: \.self) { item in
            NavigationLink(
                destination: PostDetail(post: post),
                label: {
                    Text("")
                }
            )
            .onAppear {
                UDM.shared.getPost(postID: item) { result in
                    post = result
                }
            }
        }
    }
}
