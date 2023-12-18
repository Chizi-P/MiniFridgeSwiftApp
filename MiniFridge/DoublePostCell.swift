//
//  PostCell.swift
//  WeiBoDemo
//
//  Created by tt Wong on 24/10/2020.
//
//opacity:不透明度
//Vstack() 縱向排列 --左對齊-alignment：.leading  字間距：spacing：number

import SwiftUI


struct DoublePostCell: View {
    let post : Post
    
    var bindingPost: Post {
        userData.post(forId: post.id)!
    }
    
    @EnvironmentObject var userData: UserData
    
 //   @State var isClicked = false
    
//    @State private var img : AnyView() = AnyView(loadImage(name: post.images[0]))
    
    var body: some View {
        var post = bindingPost
     // if !post.images.isEmpty {
        return VStack(spacing: 10) {
            VStack(alignment: .center) {
                loadImage(name: post.images[0]) //func取得圖片
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width / 2 - 12, height: UIScreen.main.bounds.width / 2 - 6)
//                    .frame(width: UIScreen.main.bounds.width / 2 - 12, height: )
                    .clipped()
                }
            HStack() {
                Text(post.title)
                    .font(.footnote)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                    
                    
                Spacer()
            }
            .padding(.leading, 6)
            
            Divider() //分割線。
            
            //點贊/拼論按鈕 水平方向排列
            
            HStack() {
                HStack(spacing: 5) {
                    post.avatorImage  //修改圖片樣式
                        .resizable()                          //可以縮放
                        .scaledToFill()                       //保持原圖的款高比來縮放
                        .frame(width: 15, height: 15)         //寬高
                        .clipShape(Circle())               //裁成形狀（形狀（））
                    VStack(alignment: .leading, spacing: 5) {
                        
                        Text(post.name)
                            .font(Font.system(size: 12))
                            .foregroundColor(Color( red: 242/255, green: 99/255, blue: 4/255, opacity: 10))
                            .lineLimit(1) //限制行數
                    }
                    
                    if !post.isFollowed {
                        Spacer()
                    }
                }
                .padding(.leading, 6)
                
                Spacer()
                PostCellToobarButton(image: post.isLiked ? "heart.fill" : "heart",
                                     text: post.likeCountText,
                                     color: post.isLiked ? .red : .black)
                {
                    if post.isLiked {
                        post.isLiked = false
                        post.likeCount -= 1
                    } else {
                        post.isLiked = true
                        post.likeCount += 1
                    }
                    self.userData.update(post)
                    
                }
                
            }
            .padding(.trailing)
            .padding(.bottom)
            Rectangle()
                .frame(height: 10)
                .foregroundColor(Color(red: 230 / 255 , green: 238 / 255, blue: 238 / 255 ))
        }
        .frame(width: UIScreen.main.bounds.width / 2 - 12)
        .background(Color.white)
        
    }
}


struct DoublePostCell_Previews: PreviewProvider {
    static var previews: some View {
        
        //DoublePostCell(post: postList.list[1])
        let userData = UserData()
        return DoublePostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)
        
    }
}
