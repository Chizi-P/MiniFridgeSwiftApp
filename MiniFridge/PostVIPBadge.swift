//
//  PostVIPBadge.swift
//  weiboDemo2
//
//  Created by tt Wong on 24/10/2020.
//

import SwiftUI

struct PostVIPBadge: View {
    let vip: Bool
    
    var body: some View {
        Group{
            
            if vip{
                
                Text("V")
                    .bold()                       //字體加粗
                    .font(.system(size: 11))      //指定系統字體
                    .frame(width: 15, height: 15) //寬高
                    .foregroundColor(.yellow)     //字體顏色
                    .background(Color.red)       // 背景顏色
                    .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)         //裁成圓形
                    .overlay(                    //添加邊框
                        RoundedRectangle(cornerRadius: 7.5)//圓角矩形（半徑：）
                            .stroke(Color.white, lineWidth: 1) //畫邊框（顏色：，粗細）
                    )
          }
       }
    }
}

struct PostVIPBadge_Previews: PreviewProvider {
    static var previews: some View {
        PostVIPBadge(vip: true)
    }
}
