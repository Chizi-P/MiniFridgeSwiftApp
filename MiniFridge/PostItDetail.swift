//
//  PostItDetail.swift
//  MiniFridge
//
//  Created by 🐽 on 27/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostItDetail: View {
    let postItItem : PostIt
     
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                WebImage(url: URL(string: minifridgePath + postItItem.image))
                    .placeholder { Color.gray }
                    .resizable()
                    .scaledToFill()
                    .frame(width: 300, height: 300)
                Spacer()
            }
            HStack {
                Text(postItItem.label)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                Spacer()
            }
            Text("數量：\(postItItem.count)")
            Text(postItItem.create_time)
                .font(.body)
                .foregroundColor(.gray)
            Text(postItItem.information ?? "")
                .font(.body)
            Spacer()
        }
        .padding()
    }
}

struct PostItDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostItDetail(postItItem: presetPostIt)
    }
}
