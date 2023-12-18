//
//  NewBottomNavigationBar.swift
//  MiniFridge
//
//  Created by 🐽 on 8/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct circleView : View{
    var body: some View {
        RoundedRectangle(cornerRadius: 20) // 圓角矩形
            //            .stroke(Color.orange, lineWidth: 1) // 描邊
            .frame(width: 40, height: 40)
            .foregroundColor(Color.orange)
        
    }
}

struct NewBottomNavigationBarButton: View {
    let systemName : String
    let tag : String
    let isActionBy : String
    let action : () -> Void
    
    var color : Color {
        if self.isActionBy == self.tag {
            return Color.white
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        Button(action : action) {
            Image(systemName: systemName)
                .foregroundColor(self.color)
                .background(
                    Group {
                        if self.isActionBy == self.tag {
                            circleView()
                        }
                    }
                )
        }
    }
}

struct NewBottomNavigationBar: View {
    @State private var selectedPage : String = "home"
    
    var body: some View {
        BoxView(width: UIScreen.main.bounds.width - 70, height: 70, color: Color(red: 230 / 256, green: 230 / 256, blue: 230 / 256), cornerRadius: 20, shadowColor: Color(red: 230 / 256, green: 230 / 256, blue: 230 / 256), shadowRadius: 20, shadowX: 0, shadowY: 5)
            .overlay(
                HStack {
                    Spacer()
                    NewBottomNavigationBarButton(systemName: "house", tag: "home", isActionBy: self.selectedPage) {
                        self.selectedPage = "home"
                    }
                    Spacer()
                    NewBottomNavigationBarButton(systemName: "viewfinder",  tag: "post-it", isActionBy: self.selectedPage) {
                        self.selectedPage = "post-it"
                    }
                    Spacer()
                    NewBottomNavigationBarButton(systemName: "bubble.right",  tag: "news", isActionBy: self.selectedPage) {
                        self.selectedPage = "news"
                    }
                    Spacer()
                    NewBottomNavigationBarButton(systemName: "person",  tag: "self", isActionBy: self.selectedPage) {
                        self.selectedPage = "self"
                    }
                    Spacer()
                }
            )
    }
}

struct NewBottomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NewBottomNavigationBar()
    }
}
