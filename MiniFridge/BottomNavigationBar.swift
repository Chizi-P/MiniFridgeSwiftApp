//
//  bottomNavigationBar.swift
//  MiniFridge
//
//  Created by 🐽 on 3/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import UIKit
import SwiftUI

struct BottomNavigationBarButton: View {
    
    let systemName : String
    let buttonText : String
    let action : () -> Void
    
    let iconColor = Color.orange // <--
    let iconSize : CGFloat = 20 // <--
    var body: some View {
        VStack {
            Button(action : action) {
                Image(systemName: systemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .foregroundColor(iconColor)
                    .background(circleView().opacity(0.2))
            }
        }
        .overlay(
            Text(buttonText)
                .font(.system(size: 12))
                .foregroundColor(.black)
                .frame(width: 40, height: 20)
                .offset(y: 22)
        )
    }
}

struct BottomNavigationBar: View {
    
    @AppStorage("postIt") var postIt : Data = encodedPostIt([presetPostIt])
    
    let backgroundColor = Color.white // <--
    let barHeight : CGFloat = 50 // <--
    let paddingVal : CGFloat = 35 // <--
    
    // 用於plus
    @State var isShowPhotoLibrary = false
    @State var plusOption = false
    
    @State var selectedPage : String = "home"
    @State var isHiding : Bool = false
    
    @State var image = UIImage()

    @State var alertPictureCannotBeResized = false
    @State var alertProblemWithModel = false
    
//    @AppStorage("isSignIn") var isSignIn = false
    
//    var postIts = postItDatas
//    @ObservedObject var postItClass = UpdatePostIt(postIts: postItDatas)
    // 增加數據
//    func addPostIt(label: String, count: Int, date: String, content: String) {
//        postItClass.postIts.append(PostItData(label: label, count: count, date: date, content: content))
//    }
    // 移動數據
//    func move(from source: IndexSet, to destination: Int) {
//        postItClass.postIts.swapAt(source.first!, destination)
//    }
    @AppStorage("isCreatingPostIt") var isCreatingPostIt = false
    
    var body: some View {
        VStack {
            if self.selectedPage == "home" {
                ViewHome()
                    .environmentObject(UserData()) //用了環境變量
            } else if self.selectedPage == "post-it" {
                PostItPage()
            } else if self.selectedPage == "post" {
//                PostingPage()
            } else if self.selectedPage == "shop" {
                shop()
            } else if self.selectedPage == "self" {
                SelfPage()
            }
            HStack {
                BottomNavigationBarButton(systemName: "house", buttonText: "首頁", action: {
                    print("click home button")
                    self.selectedPage = "home"
                    
                })
                .padding(.leading, paddingVal)
                
                Spacer()
                BottomNavigationBarButton(systemName: "viewfinder", buttonText: "冰箱貼", action : {
                    print("click scan button")
                    self.selectedPage = "post-it"
                })
                Spacer()
                BottomNavigationBarButton(systemName: "plus",buttonText: " ", action : {
                    print("click plus button")
//                    plusOption = true
                    isShowPhotoLibrary = true
//                    self.selectedPage = "post"
                })
//                .actionSheet(isPresented: $plusOption) {
//                    ActionSheet(title: Text("選擇"),
//                                buttons: [
//                                    .default(Text("增加食物")) {
//                                        isShowPhotoLibrary = isSignIn
//                                    },
//                                    .default(Text("增加食譜筆記")) {
//
//                                    },
//                                    .default(Text("發布食譜")) {
//
//                                    },
//                                    .cancel()
//                                ])
//                }
                .sheet(isPresented: $isShowPhotoLibrary, onDismiss: {
                    let classificationLabel: String = performImageClassification(image: self.image)
                    if classificationLabel == "沒變" {
                        return
                    } else if classificationLabel == "圖像無法轉換大小" {
                        self.alertPictureCannotBeResized = true
                    } else if classificationLabel == "模型出現問題" {
                        self.alertProblemWithModel = true
                    } else {
                        isCreatingPostIt = true
                        UDM.shared.createPostIt(label: classificationLabel, count: 1, remark: "remark", image: self.image) { _ in
                            
                        }
                        // ！更新頁面，以上要改成callback
                    }
                    self.image = UIImage()
                    self.selectedPage = "post-it"
                }) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                }
                .alert(isPresented: self.$alertPictureCannotBeResized) {
                    return Alert(title: Text("出現問題"), message: Text("圖像無法轉換大小"))
                }
                .alert(isPresented: self.$alertProblemWithModel) {
                    return Alert(title: Text("出現問題"), message: Text("圖像無法轉換大小"))
                }
                
                Spacer()
                //            BottomNavigationBarBotton(systemName: "bag", action : {
                //                print("click inbox button")
                //            })
                //            Spacer()
                
//                Link(destination: URL(string: "taobao://")!) {
//                    VStack {
//                        Link(destination: URL(string: "taobao://")!) {
//                            Image(systemName: "bubble.right")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 20, height: 20)
//                                .foregroundColor(Color.orange)
//                                .background(circleView().opacity(0.2))
//                        }
//                        .overlay(
//                            Text("商城")
//                                .font(.system(size: 12))
//                                .foregroundColor(.black)
//                                .frame(width: 40, height: 20)
//                                .offset(y: 22)
//                        )
//                    }
//                }
                
                BottomNavigationBarButton(systemName: "bag",buttonText: "商城", action : {
                    print("click plus button")
                    self.selectedPage = "shop"
                })
                
                
                Spacer()
                BottomNavigationBarButton(systemName: "person", buttonText: "自己", action : {
                print("click self button")
                self.selectedPage = "self"
                }).padding(.trailing, paddingVal)
            }
            .frame(height: barHeight)
            .padding(.bottom, 10)
        }.opacity(self.isHiding ? 0 : 1)
    }
}

struct BottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        BottomNavigationBar()
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct notSignedView: View {
    @AppStorage("goLogin") var goLogin = false
    var body: some View {
        VStack {
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .cornerRadius(15)
            Spacer()
            Button(action: {goLogin = true}) {
                RoundedRectangle(cornerRadius: .infinity)
                    .frame(width: 100, height: 50)
                    .foregroundColor(Color("bg"))
                    .overlay(
                        Text("登入")
                            .foregroundColor(.white)
                    )
            }
            .fullScreenCover(isPresented: $goLogin) {
                Login()
            }
            Spacer()
        }
    }
}
