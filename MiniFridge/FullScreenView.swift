//
//  FullScreenView.swift
//  MiniFridge
//
//  Created by 🐽 on 27/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct FullScreenView: View {
    @Binding var show : Bool
//    @State var show = true
    var backgroundColor = Color.white
    var view: AnyView = AnyView(Text("AnyView"))
    
    var body: some View {
        VStack {
            view
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .padding(.horizontal)
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
        .offset(y: show ? 0 : UIScreen.main.bounds.height)
        .animation(.default)
    }
}

//struct FullScreenView_Previews: PreviewProvider {
//    static var previews: some View {
//        FullScreenView()
//    }
//}
