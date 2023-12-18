//
//  SelfView.swift
//  MiniFridge
//
//  Created by 🐽 on 6/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

// 是否已經登陸
var signIn : Bool = false

// 这部分要修改，不要！！！
struct myUserData {
    let userData = UserData()
    var name : String = UserData().recommendPostList.list[0].name
    var selfIntroduction : String = "放自介的地方，現在這是測試的。向左對齊，可能限制顯示行數為5行。"
    var avatarImage = Image(uiImage: UIImage(named: UserData().recommendPostList.list[0].images[0])!)
}
var userData : myUserData = myUserData()

struct SelfPage: View {
    @State private var userData = myUserData()
    let avatarSize : CGFloat = 80
    
    @State var image = UIImage()
    
    @State private var isShowAvatarOptions = false
    @State private var isShowPhotoLibrary = false
    @State private var isModifySelfIntroduction = false
    @AppStorage("isShowSetting") var isShowSetting = false
    @State var isShowAvatar = false
    
    @AppStorage("token") var token = ""
    @AppStorage("isSignIn") var isSignIn = false
    @AppStorage("username") var username = ""
    @AppStorage("avatar") var avatar = ""
    @AppStorage("email") var email = ""
    @AppStorage("create_time") var create_time = ""
    @AppStorage("userType") var userType = ""
    @AppStorage("introduction") var introduction = ""
    @AppStorage("postCount") var postCount : Int = 0
    @AppStorage("followingCount") var followingCount : Int = 0
    @AppStorage("followerCount") var followerCount : Int = 0
    
    @AppStorage("isNavigationBarRightButton") var isNavigationBarRightButton = false
    
    @AppStorage("userPost") var userPost : Data = try! JSONEncoder().encode([presetUserPost])
    
    var body: some View {
        return ZStack {
            NavigationView {
                ScrollView(showsIndicators: false) {
                VStack {
                    userDetailPage(user: User(username: username, email: email, create_time: create_time, avatar: avatar, introduction: introduction, userType: userType))
                    Spacer()
                }
                // header
                .navigationTitle(username)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Button(action: { self.isShowSetting = true }) {
                        Image(systemName: "list.bullet")
                            .renderingMode(.original)
                    }
                    .fullScreenCover(isPresented: self.$isShowSetting) {
                        VStack{
                            HStack(alignment: .center) {
                                Button(action: { self.isShowSetting = false }) {
                                    Image(systemName:"chevron.left")
                                        .renderingMode(.original)
                                        .padding(.horizontal, 20)
                                        .padding(10)
                                }
                                Spacer()
                            }
                            .overlay(
                                Text("設定")
                                    .font(.title3)
                            )
                            Divider()
                            SettingPage()
                            //                    Spacer()
                        }
                    }
                , trailing:
                    Button(action: {
                        self.isNavigationBarRightButton = true
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .renderingMode(.original)
                    }
                    .sheet(isPresented: $isNavigationBarRightButton) {
                        NavigationView {
                            NavigationLink(destination: ShopPosting()) {
                                Text("發布產品")
                            }
                        }
                    }
                )
            }
            }
            FullScreenView(show: $isModifySelfIntroduction, view: AnyView(
                VStack(alignment: .leading) {
                    Spacer()
                        .frame(height: 10)
                    HStack {
                        Button(action: {
                            endEditing()
                        }) {
                            Text("取消")
                        }
                        Spacer()
                        Button(action: {
                            self.isModifySelfIntroduction = false
                            endEditing()
                        }) {
                            Text("完成")
                        }
                    }
                    Divider()
                        .padding(.bottom)
                    Group {
                        Text("個簽")
                        TextEditor(text: $userData.selfIntroduction)
                    }.font(.system(size: 18))
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            ))
        }
        .onAppear {
            if isSignIn { UDM.shared.getUserData() }
        }
        .onChange(of: isSignIn) { _ in
            if isSignIn { UDM.shared.getUserData() }
        }
        //        .fullScreenCover(isPresented: Binding<Bool>(get: {return !isSignIn},set: { p in isSignIn = !p})) {
        //            Login()
        //        }
        //        PhotoViewer(image: UIImage(named: postList.list[0].avatarImage))
    }
}

struct SelfView_Previews: PreviewProvider {
    static var previews: some View {
        SelfPage()
    }
}





struct userDetailPage: View{
    @State var userPost : [UserPost] = []
    @State var isLeft = true
    @State var isFollow = false
    @State var followingCount = 0
    @State var followerCount = 0
    @State var postCount = 0
    var user : User
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 10) {
                Spacer().frame(height: 60)
                WebImage(url: URL(string: minifridgePath + "user/\(user.username)/avatar"))
                    .placeholder { Color(.systemGray3) }
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 2.5, alignment: .center)
                    .clipShape(Circle())
                Text(user.username)
                    .font(.title)
                    .bold()
                Text(user.introduction)
                    .font(.headline)
                    .foregroundColor(Color(.systemGray2))
                    .padding()
                HStack {
                    VStack(spacing: 10) {
                        Text("\(postCount)")
                        Text("文章/食譜")
                            .frame(width: 100)
                            .foregroundColor(Color(.systemGray2))
                    }
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 4, height: 50)
                        .foregroundColor(Color(.systemGray4))
                    VStack(spacing: 10) {
                        Text("\(followerCount)")
                        Text("粉絲")
                            .frame(width: 100)
                            .foregroundColor(Color(.systemGray2))
                    }
                    RoundedRectangle(cornerRadius: .infinity)
                        .frame(width: 4, height: 50)
                        .foregroundColor(Color(.systemGray4))
                    VStack(spacing: 10) {
                        Text("\(followingCount)")
                        Text("關注")
                            .frame(width: 100)
                            .foregroundColor(Color(.systemGray2))
                    }
                }
                Spacer().frame(height: 30)
                if user.username != UDM.shared.username {
                    Text(isFollow ? "已追蹤" : "追蹤")
                        .foregroundColor(.white)
                        .frame(width: 150, height: 50)
                        .background(isFollow ? Color.green.cornerRadius(.infinity) : Color.black.cornerRadius(.infinity))
                        .onTapGesture(perform: {
                            if isFollow {
                                isFollow = false
                                UDM.shared.unFollow(username: user.username) { result in
                                    UDM.shared.isFollow(username1: UDM.shared.username, username2: user.username) { result in
                                        isFollow = result
                                    }
                                }
                            } else {
                                isFollow = true
                                UDM.shared.toFollow(username: user.username) { result in
                                    UDM.shared.isFollow(username1: UDM.shared.username, username2: user.username) { result in
                                        isFollow = result
                                    }
                                }
                            }
                        })
                }
                Spacer().frame(height: 30)
            }
            .padding()
//            .background(
//                Circle()
//                    .foregroundColor(Color("bg"))
//                    .frame(width: 850, height: 850)
//                    .offset(y: -UIScreen.main.bounds.height + 400)
//            )
            HStack(spacing: 10) {
                Spacer()
                Image(systemName: "square.split.2x2")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .onTapGesture(perform: {
                        isLeft = true
                    })
                Spacer()
                Image(systemName: "heart")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 22)
                    .onTapGesture(perform: {
                        isLeft = false
                    })
                Spacer()
            }
            SelfDoublePostView(userPost: userPost)
        }
        .onAppear {
            UDM.shared.followingCount(username: user.username) { result in
                self.followingCount = result.followingCount
            }
            UDM.shared.followerCount(username: user.username) { result in
                self.followerCount = result.followerCount
            }
            UDM.shared.postCount(username: user.username) { result in
                self.postCount = result.postCount
            }
            UDM.shared.isFollow(username1: UDM.shared.username, username2: user.username) { result in
                isFollow = result
            }
            UDM.shared.singleUserPost(username: user.username) { result in
                userPost = result
            }
        }
    }
}

struct userDetailPage_Preview: PreviewProvider {
    static var previews: some View {
        userDetailPage(user: presetUser)
        
    }
}
