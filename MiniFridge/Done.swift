//
//  Done.swift
//  MiniFridge
//
//  Created by 🐽 on 3/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct Done: View {
//    @State private var selection: String? = nil
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                NewBottomNavigationBar()
            }
            .animation(Animation.easeOut(duration: 0.5).delay(3))
    //        .edgesIgnoringSafeArea(.bottom) // 清除底下安全區
        }
    }
}

struct Done_Previews: PreviewProvider {
    static var previews: some View {
        Done()
    }
}
