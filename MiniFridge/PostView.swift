//
//  PostView.swift
//  Login
//
//  Created by tt Wong on 14/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostView: View {
    @State var selectedTab = "plus.circle.fill"
    @State var text = ""
    
    @AppStorage("followPost") var followPost = try! JSONEncoder().encode([presetUserPost])
    @State var DCfollowPost : [UserPost] = []
    @AppStorage("updatePostView") var updatePostView = false
    
//    var userPost : [UserPost] = [presetUserPost]
    @AppStorage("commented") var commented = false
    
    @State var isShowMenu = false
    @State var selectedIndex = "全部"
    
    init() {
        //隱藏分割線
        UITableView.appearance().separatorStyle = .none
        
        //隱藏按鍵後灰色效果
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        VStack {
            Spacer()
            //Search Bar
            HStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("搜索你喜愛的食譜",text: $text)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .clipShape(Capsule())
            .padding(.horizontal)
            HStack {
                ScrollView(.vertical, showsIndicators : false) {
                    VStack {
                        HStack {
//                            Button(action: {} ) {
//                                Text("分類")
//                                    .fontWeight(.bold)
//                                    .foregroundColor(.black)
//                            }
                            Spacer()
                            Menu(content: {
                                Button(action: {selectedIndex = "全部"}) {
                                    Text("全部")
                                }
                                Button(action: {selectedIndex = "文章"}) {
                                    Text("文章")
                                }
                                Button(action: {selectedIndex = "食譜"}) {
                                    Text("食譜")
                                }
                            }, label: {Text(selectedIndex)})
                        }
                        .padding(.top, 25)
//                        RoundedRectangle(cornerRadius: 0)
//                            .foregroundColor(Color.white)
//                            .frame(height: 80)
//                            .overlay(
//                                VStack(alignment: .leading, spacing: 10) {
//                                    HStack {
//                                        Text("全部")
//                                            .onTapGesture(count: 1) {
//                                                selectedIndex = "全部"
//
//                                            }
//                                        Spacer()
//                                    }
//                                    HStack {
//                                        Text("文章")
//                                            .onTapGesture(count: 1) {
//                                                selectedIndex = "文章"
//                                            }
//                                        Spacer()
//                                    }
//                                    HStack {
//                                        Text("食譜")
//                                            .onTapGesture(count: 1) {
//                                                selectedIndex = "食譜"
//                                            }
//                                        Spacer()
//                                    }
//                                }
//                                .padding()
//                            )
//                            .background(Color.white)
//                            .isHidden(!isShowMenu, remove: true)
//                            .animation(.easeInOut)
                        
                        Spacer(minLength: 0)
                        //DoubleView
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 1), spacing: 20) {
                            ForEach(DCfollowPost, id: \.self) { post in
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
                                    Spacer()
                                }
                                NavigationLink(
                                    destination: PostDetail(post: post)) {
                                    CourseCardView2(post: post)
                                }
                                .buttonStyle(PlainButtonStyle())
                                Spacer().frame(height: 5)
                            }
                        }
                        .padding(.top)
                    }
                    .padding()
                }
            }
            .background(Color.white)
        }
        .onAppear{
//            var DCfollowPost = try! JSONDecoder().decode([UserPost].self, from: followPost)
            UDM.shared.getFollowPost(postType: selectedIndex) { result in
                followPost = try! JSONEncoder().encode(result)
                self.DCfollowPost = result
            }
        }
        .onChange(of: selectedIndex) { value in
            UDM.shared.getFollowPost(postType: selectedIndex) { result in
                followPost = try! JSONEncoder().encode(result)
                self.DCfollowPost = result
            }
        }
        .onChange(of: updatePostView) { value in
            if value == true {
                UDM.shared.getFollowPost(postType: selectedIndex) { result in
                    followPost = try! JSONEncoder().encode(result)
                    self.DCfollowPost = result
                }
            }
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}


//Card View
struct CourseCardView2 : View {
    
    var post : UserPost
    
    var body : some View {
        
        //double View
        VStack {
            VStack {
                WebImage(url: URL(string: minifridgePath + post.images))
                    .placeholder { Color(.systemGray5) }
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
//                    .padding(.top, 10)
//                    .padding(.leading, 10)
//                    .background(Color(.systemGray6))
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        //Title
                        Text(post.title)
                            .fontWeight(.bold)
                        //作者
                        Text("\(post.username)")
                    }
                    .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color.black.opacity(0.03).ignoresSafeArea(.all, edges: .all))
            .cornerRadius(15)
            //也可以在Grid Item中的flexible中使用max height
            Spacer(minLength: 0)
        }
    }
}
