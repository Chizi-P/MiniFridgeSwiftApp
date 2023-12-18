//
//  LoadingScreen.swift
//  Login
//
//  Created by tt Wong on 12/11/2020.
//

import SwiftUI

struct LoadingScreen: View {
    
    @State var animate = false
    
    var body: some View {
        
        ZStack {
            Color.black.opacity(0.3)
                .ignoresSafeArea(.all, edges: .all)
            
            Circle()
                .trim(from: 0, to: 0.8)
                .stroke(Color.white,lineWidth: 10)
                .rotationEffect(.init(degrees: animate ? 360 : 0))
                .frame(width: 60, height: 60)
                .padding(40)
                .background(Color("bg"))
                .cornerRadius(15)

        }
        .onAppear(perform: {
            withAnimation(Animation.linear.speed(0.6).repeatForever(autoreverses: false)) {
                animate.toggle()
            }
        })
    }
  
}

