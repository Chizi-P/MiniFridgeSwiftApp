//
//  DoublePostDetailView.swift
//  weiboDemo2
//
//  Created by tt Wong on 27/10/2020.
//

import SwiftUI

struct DoublePostDetailView: View {
    
    let post : Post
    
//    var bindingPost: Post {
//        userData.post(forId: post.id)!
//    }
//
//    @EnvironmentObject var userData: UserData
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
        
//        if !post.isFollowed {
//            Spacer()
//            
//            Button(action: {  // 「按鈕（動作：{}）{按鈕的樣子}」
//                post.isFollowed = true
//                self.userData.update(post)
//            })  {
//            Text("關注")
//
//                .font(.system(size:14))
//                .foregroundColor(.orange)
//                .frame(width: 50, height:26) //按鍵的框高，控制按鈕的點擊區域
//                .overlay( //疊加一個view -overlay
//                    RoundedRectangle(cornerRadius: 13) //圓角矩形（半徑：）
//                        .stroke(Color.orange,lineWidth: 1)) //畫邊框（顏色，線寬）
//            }
//            
//               .buttonStyle(BorderlessButtonStyle()) //增加button效果
//        }
       
    }
}

struct DoublePostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let userData = UserData()
        return PostDetailView(post: userData.followedPostList.list[0]).environmentObject(userData)
    }
}
