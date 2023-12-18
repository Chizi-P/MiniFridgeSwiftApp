//
//  DoublePostView.swift
//  Login
//
//  Created by tt Wong on 16/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct DoublePostView: View {
    @State var selectedTab = "plus.circle.fill"
    @State var text = ""
    @State var isSearch = false
    @State var result : [User] = []
    
    @AppStorage("hotPost") var hotPost : Data = try! JSONEncoder().encode([presetUserPost])
    @State var DChotPost : [UserPost] = []
    @AppStorage("updatePostView") var updatePostView = false
    
//    var userPost : [UserPost] = [presetUserPost]
    var user = UDM.shared
    @AppStorage("commented") var commented = false
    
    @State var onfocuseTextField = false
    
    init() {
        //隱藏分割線
        UITableView.appearance().separatorStyle = .none
        
        //隱藏按鍵後灰色效果
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        VStack {
            //Search Bar
            if onfocuseTextField {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("返回")
                    Spacer()
                }
                .foregroundColor(.blue)
                .padding(.horizontal)
                .padding(.top)
                .onTapGesture(perform: {
                    text = ""
                    onfocuseTextField = false
                    endEditing()
                })
            }
            HStack(spacing: 15) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("搜索你喜愛的用戶或食譜", text: $text)
                    .onTapGesture(perform: {
                        onfocuseTextField = true
                    })
//                , onEditingChanged: { editingChanged in
//                    if editingChanged {
//                        onfocuseTextField = true
//                        print("TextField focused")
//                    } else {
//                        onfocuseTextField = false
//                        print("TextField focus removed")
//                    }
//                })
                if text != "" {
                    Text("搜尋")
                        .foregroundColor(.blue)
                        .animation(.easeInOut)
                        .onTapGesture(perform: {
                            print("搜尋")
                            endEditing()
                            self.isSearch = true
                            UDM.shared.searchUser(username: text) { res in
                                self.result = res
                            }
                        })
                }
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(.systemGray6))
            .clipShape(Capsule())
            .padding()
            if onfocuseTextField {
                searchPage(isSearch: isSearch, result: self.result)
            } else {
                HStack {
                    ScrollView(.vertical, showsIndicators : false) {
                        VStack {
                            HStack {
                                Button(action: {} ) {
                                    Text("分類")
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                                Spacer(minLength: 0)
                                Button(action: {} ) {
                                    Text("全部")
                                        .foregroundColor(.gray)
                                }
                            }
                            .padding(.top, 25)
                            //DoubleView
                            LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2),spacing: 10) {
                                ForEach(DChotPost, id: \.self) { post in
                                    NavigationLink(
                                        destination: PostDetail(post: post)) {
                                        CourseCardView(post: post)
                                    }.buttonStyle(PlainButtonStyle())
                                }
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                }
                .background(Color.white)
            }
            Spacer()
        }
        .onAppear{
            UDM.shared.getHotPost() { result in
                DChotPost = result
                self.hotPost = try! JSONEncoder().encode(result)
            }
            
        }
        .onChange(of: updatePostView) { value in
            if value == true {
                UDM.shared.getHotPost() { result in
                    DChotPost = result
                    self.hotPost = try! JSONEncoder().encode(result)
                }
            }
        }
        .animation(.easeInOut)
    }
}

//Card View
struct CourseCardView : View {
    
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
                        HStack {
                            WebImage(url: URL(string: minifridgePath + "user/\(post.username)/avatar"))
                                .placeholder { Color(.systemGray6) }
                                .resizable()
                                .frame(width: 20, height: 20)
                                .scaledToFit()
                                .clipShape(Circle())
                            Text("\(post.username)")
                                .foregroundColor(Color(.systemGray))
                        }
                    }
                    .foregroundColor(.black)
                    Spacer(minLength: 0)
                }
                .padding()
            }
            .background(Color(.systemGray6).ignoresSafeArea(.all, edges: .all))
            .cornerRadius(15)
            //也可以在Grid Item中的flexible中使用max height
            Spacer(minLength: 0)
        }
        .shadow(radius: 6)
    }
}


//struct DoublePostView_Previews: PreviewProvider {
//    static var previews: some View {
//        DoublePostView()
//
//    }
//}


// 個人頁面的Post
struct SelfDoublePostView: View {
    @State var selectedTab = "plus.circle.fill"
    @State var text = ""
    
    var userPost : [UserPost] = [presetUserPost]
    @AppStorage("commented") var commented = false
    
    var body: some View {
        VStack {
            HStack {
//                ScrollView(.vertical, showsIndicators : false) {
                    VStack {
                        //DoubleView
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 10), count: 2),spacing: 10) {
                            ForEach(userPost, id: \.self) { post in
                                NavigationLink(
                                    destination: PostDetail(post: post)) {
                                    CourseCardView(post: post)
                                }
                            }
                        }
//                        .padding(.top)
                    }
                    .padding()
//                }
            }
            .background(Color.white)
        }
        .onAppear {
            UDM.shared.getSelfPost()
        }
    }
}



// 搜尋功能
struct searchPage: View {
//    @State var text = ""
    var isSearch = false
    var result : [User]
    
    var body: some View {
        ScrollView {
//        Group {
            if !isSearch {
                Text("熱門")
                // 熱門搜尋
            } else {
                // 搜尋結果
                LazyVStack(alignment: .leading) {
                    ForEach(result, id: \.self) { user in
                        userListCell(user: user)
                    }
                }
            }
        }
    }
}

struct userListCell: View {
    var user : User
    
    var body: some View {
        HStack(spacing: 20) {
            NavigationLink(destination: userDetailPage(user: user)) {
                WebImage(url: URL(string: minifridgePath + "user/\(user.username)/avatar"))
                    .placeholder { Color(.systemGray3) }
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
                    .scaledToFit()
                    .clipShape(Circle())
                Text(user.username)
                    .foregroundColor(.black)
                    .padding(.horizontal)
                Spacer()
                Capsule()
                    .foregroundColor(userTypeColor[user.userType])
                    .frame(width: 100, height: 30)
                    .overlay(
                        Text("#\(user.userType)")
                            .foregroundColor(.white)
                    )
            }
//            RoundedRectangle(cornerRadius: .infinity)
//                .stroke(Color("bg"), lineWidth: 1)
//                .overlay(
//                    Text("關注")
//                        .foregroundColor(Color("bg"))
//                )
//                .onTapGesture(perform: {
//                            NetworkAPI.following(username: UDM.shared.username)
//                })
//                .onAppear(
//                            NetworkAPI.isFollowing(username: UDM.shared.username) { isFollow in
//
//                            }
//                )
            Spacer()
            Divider()
        }
        .padding(.horizontal)
    }
}

let userTypeColor = ["家庭主婦": Color(red: 1, green: 102/255, blue: 153/255),
                     "單身貴族": Color(red: 102/255, green: 51/255, blue: 204/255),
                     "廚神達人": Color(red: 1, green: 204/255, blue: 102/255),
                     "萌廚新手": Color(red: 102/255, green: 204/255, blue: 1),
                     "網紅博主": Color(red: 1, green: 102/255, blue: 102/255),
                     "神秘莫測": Color(red: 11/255, green: 11/255, blue: 11/255)
]

