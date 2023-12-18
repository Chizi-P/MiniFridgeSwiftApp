//
//  PostCell.swift
//  WeiBoDemo
//
//  Created by tt Wong on 24/10/2020.
//
//opacity:不透明度
//Vstack() 縱向排列 --左對齊-alignment：.leading  字間距：spacing：number

import SwiftUI

 
struct PostCell: View {
    let post : Post
    
    
    var bindingPost: Post {
        userData.post(forId: post.id)!
    }
    @State var presentComment: Bool = false
    
    @EnvironmentObject var userData: UserData
    
    
   // @State var isClicked = false  //點贊
    
    var body: some View {
        var post = bindingPost
        return VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 5) {
                post.avatorImage  //修改圖片樣式
                    .resizable()                          //可以縮放
                    .scaledToFill()                       //保持原圖的款高比來縮放
                    .frame(width: 50, height: 50)         //寬高
                    .clipShape(Circle())               //裁成形狀（形狀（））
                    .overlay(                             //加邊框
                        PostVIPBadge(vip: post.vip)
                            .offset(x: 16, y: 16)       //調整位置
                    )
                VStack(alignment: .leading, spacing: 5) {
                    
                    Text(post.name)
                            .font(Font.system(size:16))
                            .foregroundColor(Color( red: 242/255, green: 99/255, blue: 4/255, opacity: 10))
                            .lineLimit(1) //限制行數
                    Text(post.date)
                        .font(.system(size:11))
                        .foregroundColor(.gray)
                    }
                .padding(.leading, 10)//朝左邊
                
                if !post.isFollowed {
                    Spacer()
                    
                    Button(action: {  // 「按鈕（動作：{}）{按鈕的樣子}」
                        post.isFollowed = true
                        self.userData.update(post)
                    })  {
                    Text("關注")

                        .font(.system(size:14))
                        .foregroundColor(.orange)
                        .frame(width: 50, height:26) //按鍵的框高，控制按鈕的點擊區域
                        .overlay( //疊加一個view -overlay
                            RoundedRectangle(cornerRadius: 13) //圓角矩形（半徑：）
                                .stroke(Color.orange,lineWidth: 1)) //畫邊框（顏色，線寬）
                    }
                    
                       .buttonStyle(BorderlessButtonStyle()) //增加button效果
                }
               
            }
      
        
    
        
        if !post.images.isEmpty {
            
            PostImageCell(images: post.images,width: UIScreen.main.bounds.width - 30)
        }
            Text(post.title)
                .font(.system(size:19))
                .foregroundColor(.orange)
            
            Text(post.text)
               .font(.system(size: 17))
            
            Divider() //分割線。
            
//點贊/拼論按鈕 水平方向排列
            
            HStack(spacing: 2) {
               Spacer() //若顯示在右邊
                PostCellToobarButton(image: "message",
                                     text: post.commentCountText,
                                     color: .black)
                {
                    self.presentComment = true
                }
                .sheet(isPresented: $presentComment) {
                    CommentInput(post: post).environmentObject(self.userData)
                }
                //Spacer()若顯示在中間
                PostCellToobarButton(image: post.isLiked ? "heart.fill" : "heart",
                                     text: post.likeCountText,
                                     color: post.isLiked ? .red : .black)
                                   // color: isClicked ? .red : .black)
                {
                  // self.isClicked.toggle()
                    if post.isLiked {
                        post.isLiked = false
                        post.likeCount -= 1
                    } else {
                        post.isLiked = true
                        post.likeCount += 1
                    }
                    self.userData.update(post)
                }
                
                
               // Spacer()若顯示在中間
                
            }
 //灰色間距
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 230 / 255 , green: 238 / 255, blue: 238 / 255 ))
   }
     .padding(.horizontal, 15)
        .padding(.top, 15)
    
        
        }
    
    
        
}

            
struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        
        //PostCell(post: postList.list[0])
        let userData = UserData()
        return PostCell(post: userData.recommendPostList.list[0]).environmentObject(userData)
        
    }
}
