//
//  PostListView.swift
//  weiboDemo2
//
//  Created by tt Wong on 25/10/2020.
//

import SwiftUI
import BBSwiftUIKit

struct PostListView: View {
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
    
    @EnvironmentObject var userData: UserData
    
    
    var body: some View {
        
        // List {
        BBTableView(userData.postList(for: category).list) { post in
            //            ForEach(userData.postList(for: category).list) { post in
            //               ZStack {  //垂直排列
            // PostCell(post: post)
            NavigationLink(destination: PostDetailView(post: post)) {
                PostCell(post: post)
                //  EmptyView()
                //                    }
                //                    //.hidden()
                //                }
                //                .listRowInsets(EdgeInsets())
                //
                //        }
            }
            .buttonStyle(OriginalButtonStyle())
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
        .bb_pullUpToLoadMore(bottomSpace: 30) {
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
        
    }
}
struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{  //上方出現空白//標題所佔的位置
            PostListView(category: .followed)
                .navigationBarTitle("主頁") //滑動時樣式會改變
                .navigationBarHidden(true) //隱藏title
            
        }
        .environmentObject(UserData()) //用了環境變量
        
    }
}

