//
//  PostDetail.swift
//  Login
//
//  Created by tt Wong on 18/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostDetail: View {
    @State var post : UserPost
    
    @State var isShowImage = false
    @State var text = ""
    
    @State var isLike = false
    @State var isFavorites = false
    @State var share = false
    @State var likeCount : Int = 0
    @State var favoriting = false
    
    @AppStorage("favorites") var favorites : Data = try! JSONEncoder().encode(presetFavorites)
    @State var DCfavorites : [String: Set] = presetFavorites
    
    var body: some View {
            VStack(alignment: .leading, spacing: 10) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        HStack(spacing: 20) {
                            WebImage(url: URL(string: minifridgePath + "user/\(post.username)/avatar"))
                                .placeholder { Color(.systemGray6) }
                                .resizable()
                                .frame(width: 40, height: 40, alignment: .center)
                                .scaledToFit()
                                .clipShape(Circle())
                            VStack(alignment: .leading) {
                                Text(post.username)
                                Text(post.create_time)
                                    .foregroundColor(Color(.systemGray))
                                    .font(.subheadline)
                            }
                        }
                        WebImage(url: URL(string: minifridgePath + post.images))
                            .placeholder { Color(.systemGray6) }
                            .resizable()
                            .renderingMode(.original)
                            .scaledToFill()
                            .gesture(
                                TapGesture()
                                    .onEnded({ value in
                                        isShowImage = true
                                    })
                            )
//                            .onTapGesture(count: 2) {
//                                print("Double tapped!")
//                            }
                            .fullScreenCover(isPresented: $isShowImage, content: {
                                ZStack {
                                    Color.black
                                    WebImage(url: URL(string:  minifridgePath + post.images))
                                        .placeholder { Color(.systemGray6) }
                                        .resizable()
                                        .scaledToFit()
                                }
                                .gesture(
                                    TapGesture()
                                        .onEnded({ value in
                                            isShowImage = false
                                        })
                                )
                                .edgesIgnoringSafeArea(.all)
                            })
                        HStack(alignment: .center, spacing: 20) {
                            Spacer()
                            Text("\(likeCount)")
                                .foregroundColor(Color(.systemGray))
                                .offset(x: 10)
                                .isHidden(likeCount == 0)
                            // 點讚
                            Image(systemName: isLike ? "heart.fill" : "heart")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(isLike ? .red : .black)
                                .onTapGesture(perform: {
                                    if isLike {
                                        isLike = false
                                        UDM.shared.unLike(postID: post.postID) { _ in
                                            UDM.shared.isLike(username: UDM.shared.username, postID: post.postID, completion: { result in
                                                self.isLike = result
                                            })
                                            UDM.shared.postLikeCount(postID: post.postID) { result in
                                                self.likeCount = result
                                            }
                                        }
                                    } else {
                                        isLike = true
                                        UDM.shared.toLike(postID: post.postID) { _ in
                                            UDM.shared.isLike(username: UDM.shared.username, postID: post.postID, completion: { result in
                                                self.isLike = result
                                            })
                                            UDM.shared.postLikeCount(postID: post.postID) { result in
                                                self.likeCount = result
                                            }
                                        }
                                    }
                                })
                            // 收藏
                            Image(systemName: isFavorites ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(isFavorites ? .red : .black)
                                .onTapGesture(perform: {
                                    favoriting.toggle()
                                })
                                .sheet(isPresented: $favoriting, content: {
                                    VStack {
//                                        Text("收藏分類")
                                        NavigationView {
                                            List {
                                                ForEach(Array(DCfavorites.keys), id: \.self) { key in
                                                    Text(key)
                                                        .onTapGesture(perform: {
                                                            if !DCfavorites[key]!.contains(post.postID) {
                                                                DCfavorites[key]!.insert(post.postID)
                                                                print("收藏")
                                                            } else {
                                                                print("已經收藏了")
                                                            }
                                                            print(DCfavorites.values)
                                                        })
                                                }
                                            }
                                            .listStyle(PlainListStyle()) // 貼齊
                                            .navigationBarTitle("收藏分類", displayMode: .inline)
                                        }
                                    }
                                })
                            // 分享
                            Image(systemName: "paperplane.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.black)
                                .onTapGesture(perform: {
                                    share = true
                                    
                                })
                                .sheet(isPresented: $share, content: {
                                    Text("share")
                                })
                        }
                        .padding()
                        Text(post.title)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding()
                        Text(post.introduction)
                            .lineLimit(100)
                            .padding(.horizontal)
                        Spacer().padding(.vertical)
                        Text("留言")
                            .bold()
                        Divider()
                            .padding(.bottom, 10)
                        // 顯示評論
                        CommentView(postID: post.postID)
                    }
                }
                // 進行評論
                HStack(spacing: 15) {
                    Image(systemName: "pencil")
                        .foregroundColor(.gray)
                    TextField("評論點什麼吧", text: $text)
                    if text != "" {
                        Button(action: { // 發送評論
                            print("發送評論")
                            UDM.shared.createComment(postID: post.postID, text: text) { message in
                                text = ""
                            }
                        }) {
                            Image(systemName: "arrow.turn.right.up")
                                .foregroundColor(Color(.systemBlue))
                        }
                        .disabled(text == "")
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal)
                .background(Color(.systemGray6))
                .clipShape(Capsule())
                .animation(.easeIn)
            }
            .padding()
            //.navigationTitle(course.name)
            //.navigationBarHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button(action: {}, label: {
                Image(systemName: "house")
                    .renderingMode(.template)
                    .foregroundColor(.gray)
        }))
            .animation(.easeInOut)
        .onAppear {
            DCfavorites = try! JSONDecoder().decode([String: Set<Int>].self, from: favorites)
            for key in DCfavorites.keys {
                if DCfavorites[key]!.contains(post.postID) {
                    isFavorites = true
                }
            }
//            DCfavorites.values
//            for (key, values) in DCfavorites {
//                DCfavorites[values]
//            }
            
//            Array(DCfavorites.values).first(where: { set -> Bool in
//                return Array(set).first { postID -> Bool in
//                    return postID == post.postID
//                }
//            })
            
            UDM.shared.isLike(username: UDM.shared.username, postID: post.postID, completion: { result in
                self.isLike = result
            })
            UDM.shared.postLikeCount(postID: post.postID) { result in
                self.likeCount = result
            }
        }
        .onChange(of: DCfavorites, perform: { value in
            favorites = try! JSONEncoder().encode(DCfavorites)
        })
    }
}


struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(post: UserPost(postID: 0, username: "tt", images: "", title: "人生第一次做飯", introduction: "你們覺得如何？", create_time: "11月5日", postType: "文章"))
    }
}




struct CommentView : View  {
    
    @State var postID : Int
    @State var comments : [Comment] = [presetComment]
    
    @AppStorage("commented") var commented = false
    
    var body: some View {
        LazyVStack {
            ForEach(comments, id: \.self) { comment in
                commentCell(comment: comment)
            }
            if comments.count == 0 {
                Text("哎鴨，好空虛唷")
                    .foregroundColor(Color(.systemGray2))
            }
        }
        .onAppear {
            // 獲取對於這個post的評論
            UDM.shared.getPostComment(postID: postID) { comments in
                self.comments = comments
            }
        }
        .onChange(of: commented, perform: { value in
            if value == true {
                UDM.shared.getPostComment(postID: postID) { comments in
                    self.comments = comments
                    commented = false
                }
            }
        })
    }
}


struct commentCell : View  {
    
    var user = UDM.shared
    
    @State var comment : Comment
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                // ！ 頭像
                WebImage(url: URL(string: minifridgePath + "user/\(comment.username)/avatar"))
                    .placeholder { Color(.systemGray4) }
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
                    .clipped()
                Text(comment.username)
                    .foregroundColor(Color(.systemGray))
                Spacer()
            }
            Group {
                Text(comment.text)
                Text(comment.create_time)
                    .foregroundColor(Color(.systemGray3))
            }.padding(.leading, 40)
        }
    }
}

