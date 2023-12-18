//
//  BoxView.swift
//  MiniFridge
//
//  Created by 🐽 on 9/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct BoxView: View {
    let width : CGFloat
    let height: CGFloat
    let color : Color
    let cornerRadius: CGFloat
    let shadowColor: Color
    let shadowRadius: CGFloat
    let shadowX: CGFloat
    let shadowY: CGFloat
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius) // 圓角矩形
            .foregroundColor(color)
            .frame(width: width, height: height)
            .shadow(color: shadowColor, radius: shadowRadius, x: shadowX, y: shadowY)
    }
}

struct BoxView_Previews: PreviewProvider {
    static var previews: some View {
        BoxView(width: UIScreen.main.bounds.width - 70, height: 70, color: Color(red: 224 / 256, green: 224 / 256, blue: 224 / 256), cornerRadius: 20, shadowColor: Color(red: 224 / 256, green: 224 / 256, blue: 224 / 256), shadowRadius: 20, shadowX: 0, shadowY: 5)
    }
}
