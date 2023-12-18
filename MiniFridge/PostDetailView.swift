//
//  PostDetailView.swift
//  weiboDemo2
//
//  Created by tt Wong on 26/10/2020.
//

import SwiftUI

struct PostDetailView: View {
    
    let post : Post
    var body: some View {
  
        List { 
            PostCell(post: post)
                .listRowInsets(EdgeInsets())
                
            ForEach(1...10, id: \.self) { i in Text("評論\(i)")
                    .font(.system(size: 12))
            }
          }
        
        .navigationBarTitle("詳情", displayMode: .inline)
        //.font(.system(size: 17))
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData = UserData()
        return PostDetailView(post: userData.recommendPostList.list[0]).environmentObject(userData)
       //PostDetailView(post: postList.list[0])
    }
}
