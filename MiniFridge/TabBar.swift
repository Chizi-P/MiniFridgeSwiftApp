//
//  TabBar.swift
//  MiniFridge
//
//  Created by 🐽 on 3/11/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct TabBar: View {
    
    // 這可能要修改
    @AppStorage("PostIt") var postIt : Data = encodedPostIt([presetPostIt])
    
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    @State private var oldImage = UIImage()
    
    @State var selected = 1
    
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    var body: some View {
        TabView(selection: $selected) {
            HomeView().environmentObject(UserData()).tabItem {
                VStack {
                    Image(systemName: "house")
                    Text("首頁")
                }
            }.tag(1)
            
            PostItPage().tabItem {
                VStack {
                    Image(systemName: "viewfinder")
                    Text("冰箱")
                }
            }.tag(2)
            
            PostItPage().tabItem {
                VStack {
                    Image(systemName: "plus")
                    Text("")
                }
            }.tag(3)
            
            StorePage().tabItem {
                VStack {
                    Image(systemName: "bubble.right")
                    Text("商城")
                }
                Link(destination: URL(string: "taobao://")!){}
            }.tag(4)
            
            SelfPage().tabItem {
                VStack {
                    Image(systemName: "person")
                    Text("自己")
                }
            }.tag(5)
        }
        .accentColor(.orange)
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
