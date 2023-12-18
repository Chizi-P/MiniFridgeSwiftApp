//
//  LoginPage.swift
//  MiniFridge
//
//  Created by 🐽 on 30/11/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct LoginPage: View {
    
    @AppStorage("goLogin") var goLogin = false
    @AppStorage("registered") var registered = false
    
    // 動畫
    @State var offsetImageCloseFridge = false
    @State var offsetTextMiniFridge = false
    @State var offsetSignInSignOut = false
    
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.85).edgesIgnoringSafeArea(.all)
            Image("closeFridge")
                .resizable()
                .scaledToFill()
                .frame(width: 600, height: 0)
                .offset(x: offsetImageCloseFridge ? UIScreen.main.bounds.width / 3 : UIScreen.main.bounds.width, y: -120)
                .animation(.easeInOut(duration: 1.5))
            Text("B     X     T")
                .font(.system(size: 60))
                .foregroundColor(.white)
                .bold()
                .offset(x : offsetTextMiniFridge ? 0 :  -UIScreen.main.bounds.width)
                .shadow(radius: 15)
                .animation(.easeInOut(duration: 1.5))
                
            VStack(spacing: 15) {
                Spacer()
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.white, lineWidth: 1.5)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 70)
                    .background(Color.black.opacity(0.2)).cornerRadius(20)
                    .overlay(
                        Text("登入")
                            .foregroundColor(.white)
                    )
                    .fullScreenCover(isPresented: $goLogin, content: {
                        Login()
                    })
                    .onTapGesture(perform: {
                        goLogin = true
                    })
                    .animation(.easeInOut(duration: 1.8))
                
                RoundedRectangle(cornerRadius: 20)
                    .frame(width: UIScreen.main.bounds.width - 60, height: 70)
                    .foregroundColor(.white)
                    .overlay(
                        Text("註冊")
                    )
                    .fullScreenCover(isPresented: $registered, content: {
                        Registered()
                    })
                    .onTapGesture(perform: {
                        registered = true
                    })
                    .animation(.easeInOut(duration: 2.0))
                Text("享受你的生活")
                    .font(.system(size: 10))
                    .foregroundColor(.white)
                    .animation(.easeInOut(duration: 2.2))
            }
            .offset(y: offsetSignInSignOut ? 0 : 300)
        }
        .onAppear {
            offsetImageCloseFridge = true
            offsetTextMiniFridge = true
            offsetSignInSignOut = true
        }
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
