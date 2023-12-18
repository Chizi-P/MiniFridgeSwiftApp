//
//  MySheet.swift
//  MiniFridge
//
//  Created by 🐽 on 25/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct MySheet: View {
    @Binding var show : Bool
    //    @State var show = true
    var height : CGFloat = 300
    var ShowDefaultStyle : Bool = true
    var view: AnyView = AnyView(Text("AnyView"))
    
    var body: some View {
        //        ZStack {
        VStack(spacing: 20.0) {
            if ShowDefaultStyle {
                // 橫條
                    Button(action: {self.show = false}) {
                        RoundedRectangle(cornerRadius: .infinity)
                            .frame(width: 60, height: 6)
                            .opacity(0.2)
                            .padding(.horizontal, 30)
                            .padding(.bottom, 5)
                    }
                }
                // 右邊的完成按鈕
//                    HStack {
//                        Spacer()
//                        Button(action: {self.show = false}) {
//                            Text("完成")
//                        }
//                    }
            view
            Spacer()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding()
        .padding(.horizontal)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(radius: show ? 60 : 0)
        .offset(y: show ? UIScreen.main.bounds.height - height : UIScreen.main.bounds.height)
        .animation(.default)
        .edgesIgnoringSafeArea(.all)
    }
}

//struct MySheet_Previews: PreviewProvider {
//    static var previews: some View {
//        MySheet()
//    }
//}
