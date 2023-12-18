//
//  CardView.swift
//  BXTview
//
//  Created by tt Wong on 18/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct CardView: View {
    var item : Shop   //資料
    var animation : Namespace.ID //ID
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .bottom)) {
            
            HStack(spacing: 15) {
                
                Text(item.title)
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Spacer(minLength: 0)
                WebImage(url: URL(string: minifridgePath + item.images))
                    .placeholder { Color(.systemGray5) }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.top,50)
                    //最大size
                    .frame(height: 180)
                    .matchedGeometryEffect(id: item.images, in: animation) //button
            }
            .padding(.horizontal)
            .padding(.bottom)
            .background(Color.white.cornerRadius(25).padding(.top,35))
            .padding(.trailing,8)
//            .background(Color.orange.cornerRadius(25).padding(.top,35))
            
            Text("NT$ \(String(format: "%.2f", Float(item.cost)))")
                .foregroundColor(Color.black.opacity(0.6))
                .padding(.vertical,10)
                .padding(.horizontal,35)
                .background(Color.orange)
                .clipShape(CustomCorner(corners: [.topRight,.bottomLeft], size: 15))
        }
    }
}

