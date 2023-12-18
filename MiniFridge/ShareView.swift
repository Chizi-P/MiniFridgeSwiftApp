//
//  ShareView.swift
//  MiniFridge
//
//  Created by 🐽 on 24/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct shareButtonBox: View {
    var body: some View {
        BoxView(width: 80, height: 80, color: Color(red: 235 / 256, green: 235 / 256, blue: 235 / 256), cornerRadius: 20, shadowColor: Color(red: 224 / 256, green: 224 / 256, blue: 224 / 256), shadowRadius: 20, shadowX: 0, shadowY: 0)
    }
}


struct ShareView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "square.and.arrow.up")
                Text("分享至")
                    .font(.system(size: 16))
            }
            Divider()
                .padding(.bottom, 20)
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    shareButtonBox()
                        .overlay(
                            Link(destination: URL(string: "https://line.me/R/msg/text/?%e5%86%b0%e7%ae%b1%e8%b2%bc")!) {
                            Image(systemName: "link")
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 30, height: 30)
                            }
                        )
                }
                Spacer()
                Button(action: {
                    
                }) {
                    shareButtonBox()
                        .overlay(
                            Link(destination: URL(string: "wechat://")!) {
                                Image("wechat")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                            }
                        )
                }
                Spacer()
                Button(action: {
                    
                }) {
                    shareButtonBox()
                        .overlay(
                            Link(destination: URL(string: "https://line.me/R/msg/text/" + escapedString("冰箱貼"))!) {
                                Image("line")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 30, height: 30)
                            }
                        )
                }
                Spacer()
            }
            Spacer()
                .frame(height: 35)
            Text("點擊分享你的個人檔案")
                .foregroundColor(.gray)
        }
    }
}

struct ShareView_Previews: PreviewProvider {
    static var previews: some View {
        ShareView()
    }
}
