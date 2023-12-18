//
//  ViewHome.swift
//  Login
//
//  Created by tt Wong on 17/11/2020.


import SwiftUI

struct ViewHome: View {
    
    @State var leftPercent: CGFloat = 1
    
    @AppStorage("ispostingLoading") var ispostingLoading = false
    @AppStorage("updatePostView") var updatePostView = false
    
    init() {
        //隱藏分割線
        UITableView.appearance().separatorStyle = .none
        
        //隱藏按鍵後灰色效果
        UITableViewCell.appearance().selectionStyle = .none
        
        UINavigationBar.appearance().barTintColor = .white
    }
    
    var body: some View {
        NavigationView {
            GeometryReader{ geometry in
                HScrollViewController(pageWidth: geometry.size.width, contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height),
                                      leftPercent: self.$leftPercent) {
                    HStack(spacing: 0 ) {
                        PostView()
                            .frame(width: UIScreen.main.bounds.width )
                        DoublePostView()
                            .frame(width: UIScreen.main.bounds.width )
                    }
                }
            }
            //            ScrollView(.horizontal, showsIndicators: false ) {
            //
            //
            //            }
            .navigationBarItems(leading: HomeNavigationBar(leftPercent: $leftPercent))
            .navigationBarTitle("首頁", displayMode: .inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ViewHome_Previews: PreviewProvider {
    static var previews: some View {
        ViewHome()
    }
}

