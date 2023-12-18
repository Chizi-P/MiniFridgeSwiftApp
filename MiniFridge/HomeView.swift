//
//  HomeView.swift
//  weiboDemo2
//
//  Created by tt Wong on 27/10/2020.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 1
    
    init() {
        //隱藏分割線
        UITableView.appearance().separatorStyle = .none
        
        //隱藏按鍵後灰色效果
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
    NavigationView {
        GeometryReader{
            geometry in
            HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height),
                                  leftPercent: self.$leftPercent)
            {
                
                HStack(spacing: 0 ) {
                    
                   PostListView(category: .recommend)
                            .frame(width: UIScreen.main.bounds.width )
                
                       
                    DoublePostList(category: .followed)
                            .frame(width: UIScreen.main.bounds.width )
                           
                }
                }
            
        }
       
            
//            ScrollView(.horizontal, showsIndicators: false ) {
//
//
//            }
            .edgesIgnoringSafeArea(.bottom)//邊界忽略安全區域
                .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
                .navigationBarTitle("首頁", displayMode: .inline)
    }
    .padding(.top, 9.0)
    .navigationViewStyle(StackNavigationViewStyle()) // 保持樣式
  }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserData()) //用了環境變量
    }
    
}
