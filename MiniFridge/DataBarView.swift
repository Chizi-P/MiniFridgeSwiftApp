//
//  DataBarView.swift
//  MiniFridge
//
//  Created by 🐽 on 9/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct DataBarView: View {
    let text : String
    let textSize : CGFloat
    let textColor: Color
    let barColor : Color
    let barBackgroundColor : Color
    let barHeigth: CGFloat
    let percent: CGFloat
    
    var body: some View {
        HStack {
            Text(text)
                .font(.system(size: self.textSize))
                .foregroundColor(self.textColor)
            GeometryReader { metrics in
                Capsule()
                    .foregroundColor(self.barBackgroundColor)
                    .overlay(
                        Capsule()
                            .foregroundColor(self.barColor)
                            .padding(.trailing, metrics.size.width * (1 - self.percent))
                    )
                }
        }
        .frame(height: self.barHeigth)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
    }
}

struct DataBarView_Previews: PreviewProvider {
    static var previews: some View {
        DataBarView(text: "50%", textSize: 10, textColor: Color.black, barColor: Color.green, barBackgroundColor: Color(red: 224 / 256, green: 224 / 256, blue: 224 / 256), barHeigth: 10, percent: 0.5)
    }
}
