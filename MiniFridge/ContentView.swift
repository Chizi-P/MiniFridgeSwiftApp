//
//  ContentView.swift
//  MiniFridge
//
//  Created by 🐽 on 25/9/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @AppStorage("isSignIn") var isSignIn = false
    
    //    @Environment(\.managedObjectContext) var managedObjectContext
    //    @FetchRequest(FetchRequest: PostItItem.getAllPostItItems()) var postItItems: FetchedResults<PostItItem>
    //    @State var newPostItItem = ""
    
    //開場動畫
    @State var animate = false
    @State var endSplash = false
    
    var body: some View {
        ZStack {
            if isSignIn {
                BottomNavigationBar()
            } else {
                LoginPage()
            }
        }
            //開場動畫
//            ZStack{
//                Color("bg")
//                Image("t & G_large")
//                    .resizable()
//                    .renderingMode(.original)
//                    .aspectRatio(contentMode: animate ? .fill :.fit)
//                    .frame(width: animate ? nil : 85, height: animate ? nil :85)
//                    //scaling view...
//                    .scaleEffect(animate ? 3 : 1)
//                    //setting with avoid  over size...
//                    .frame(width: UIScreen.main.bounds.width)
//
//            }
//            .ignoresSafeArea(.all, edges: .all)
//            .onAppear(perform: animateSpalsh)
//            //動畫結束後。。。
//            .opacity(endSplash ? 0 : 1)
//        }
//    }
    
//    //動畫func
//    func animateSpalsh() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
//
//            withAnimation(Animation.easeOut(duration: 0.55)) {
//
//                animate.toggle()
//            }
//
//            withAnimation(Animation.linear(duration: 0.45)) {
//
//                endSplash.toggle()
//            }
//
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .edgesIgnoringSafeArea(.bottom)
    }
}
