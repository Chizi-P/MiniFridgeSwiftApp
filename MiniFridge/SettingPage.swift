//
//  SettingPage.swift
//  MiniFridge
//
//  Created by 🐽 on 24/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct SettingPage: View {
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    
                    settingItemButton(text: "隱私", systemName: "lock") {}
                    settingItemButton(text: "安全", systemName: "shield") {}
                    settingItemButton(text: "反饋", systemName: "exclamationmark.circle") {}
                    settingItemButton(text: "關於", systemName: "info.circle") {}
                    settingItemButton(text: "登出", systemName: "person.crop.circle.badge.xmark") {
                        UDM.shared.signOut()
                    }
                    Link(destination: URL(string: "tel:0985004234")!, label: {
                        HStack {
                            Image(systemName: "phone")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 12, height: 20)
                                .padding(.leading, 5)
                                .padding(.trailing, 10)
                            Text("聯繫客服")
                        }
                    })
                    Button(action: {resetDefaults()}) {
                        Text("重設")
                    }
                }
            }
            .navigationBarTitle("設定", displayMode: .inline)
            .navigationBarHidden(true)
            .listStyle(PlainListStyle())
        }
    }
}

struct SettingPage_Previews: PreviewProvider {
    static var previews: some View {
        SettingPage()
    }
}

struct settingItemButton: View {
    let text : String
    let systemName : String
    let action : () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: systemName)
                .resizable()
                .scaledToFill()
                .frame(width: 12, height: 20)
                .padding(.leading, 5)
                .padding(.trailing, 10)
            Text(text)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
