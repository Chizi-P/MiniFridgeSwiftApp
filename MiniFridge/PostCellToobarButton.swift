//
//  PostCellToobarButton.swift
//  weiboDemo2
//
//  Created by tt Wong on 25/10/2020.
//

import SwiftUI

struct PostCellToobarButton: View {
    //執行點贊按鈕的動作
    let image: String
    let text: String
    let color: Color
    let action: () -> Void  // closure, function //Void表示什麼都不反回
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 5) {
              
                Image(systemName: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 12, height: 12)
                Text(text)
                    .font(.system(size: 12))
                
            }
        }
        .foregroundColor(color)
        .buttonStyle(BorderlessButtonStyle()) //增加button效果
    }
}

struct PostCellToobarButton_Previews: PreviewProvider {
    static var previews: some View {
        PostCellToobarButton(image: "heart",text: "點讚", color: .red) {
            print("點讚")
        }
    }
}
