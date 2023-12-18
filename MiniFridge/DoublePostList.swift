//
//  DoublePostList.swift
//  weiboDemo2
//
//  Created by tt Wong on 25/10/2020.
//

import SwiftUI
import BBSwiftUIKit

struct DoublePostList: View {
    
    let category: PostListCategory
    
    //    //判斷類型 ，解析不同的json文件
    //    var postList : PostList {
    //        switch category {
    //        case .recommend:
    //            return loadPostListData("PostListData_recommend_1.json")
    //        case .followed:
    //            return loadPostListData("PostListData_hot_1.json")
    //
    //        }
    //    }
    //
    
    //    let evenNumbers = (0...100).filter { number -> Bool in
    //        return number % 2 == 0
    //    }.prefix(10)
    
    //    let x = [0...userData.postList(for: category).list.count].filter({ $0 % 2 == 0})
    
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        
        BBTableView(0..<userData.postList(for: category).list.count / 2) { i in
            HStack {
                Spacer()
                ForEach([userData.postList(for: category).list[i * 2], userData.postList(for: category).list[i * 2 + 1]]) { post in
                    NavigationLink(destination: PostDetailView(post: post)) {
                        DoublePostCell(post: post)
                    }
                    Spacer()
                }
                
            }
            .buttonStyle(OriginalButtonStyle())
            
            .background(Color(red: 230 / 255 , green: 238 / 255, blue: 238 / 255))
        }
        .bb_setupRefreshControl {
            control in control.attributedTitle = NSAttributedString(string: "加載中...")
        }
        .bb_pullDownToRefresh(isRefreshing: $userData.isRefreshing) {
            print("Refresh")
            self.userData.loadingError = NSError(domain: "", code: 0, userInfo:[ NSLocalizedDescriptionKey:"Error"])//錯誤提示
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.userData.isRefreshing = false //一秒之後設為false
                self.userData.loadingError = nil //一秒之後將錯誤提示語設為nil
            }
        }
        .bb_pullUpToLoadMore(bottomSpace: 35) {
            if self.userData.isLoadingMore { return } //如果已經加載夠多，返回
            self.userData.isLoadingMore = true //如果沒有，則將設為true
            print("no more")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.userData.isLoadingMore = false //一秒之後設為false
                
            }
        }
        .overlay(
            Text(userData.loadingErrorText)
                .bold()
                .frame(width: 200)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.white)
                        .opacity(0.8)
                )
                //評論不能為空動畫
                .scaleEffect(userData.showLoadingError ? 1 : 0.5)
                .animation(.spring(dampingFraction: 0.5))
                .opacity(userData.showLoadingError ? 1 : 0)
                .animation(.easeInOut)
        )
        .background(
            Color(red: 230 / 255 , green: 238 / 255, blue: 238 / 255 )
                .edgesIgnoringSafeArea(.all)
        )
    }
}
        
        //        ScrollView {
        //            HStack(alignment: .top, spacing: 8) {
        //                Spacer()
        //                VStack {
        //                    ForEach(userData.postList(for: category).list) { post in
        //
        //                        NavigationLink(destination: PostDetailView(post: post))
        //                        {
        //                            if post.id % 2 == 0 {
        //                                DoublePostCell(post: post)
        //                            }
        //                        }
        //
        //                    }
        //                }
        //                VStack {
        //                    ForEach(userData.postList(for: category).list) { post in
        //                        NavigationLink(destination: PostDetailView(post: post))
        //                        {
        //                            if post.id % 2 != 0 {
        //                                DoublePostCell(post: post)
        //
        //                            }
        //                        }
        //                    }
        //                }
        //                Spacer()
        //            }
        //
        //
        //        }
        //        .background(
        //            Color(red: 230 / 255 , green: 238 / 255, blue: 238 / 255 )
        //                .edgesIgnoringSafeArea(.all)
        //        )



struct DoublePostList_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView{  //上方出現空白//標題所佔的位置
            DoublePostList(category: .recommend)
                .navigationBarTitle("主頁") //滑動時樣式會改變
                .navigationBarHidden(true) //隱藏title
            
        }
        .environmentObject(UserData()) //用了環境變量
        
        
    }
}


