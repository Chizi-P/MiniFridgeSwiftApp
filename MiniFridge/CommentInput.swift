//
//  CommentInput.swift
//  weiboDemo2
//
//  Created by tt Wong on 31/10/2020.
//

import SwiftUI

struct CommentInput: View {
    let post: Post
    
    @State private var text: String = ""
    @State private var showEmptyTextHUD: Bool = false //HUD提示語
    
    //系統自帶的環境變數-下拉消失
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var userData: UserData
    
    //屬性改變，內容就會更新-需要賦值
    @ObservedObject private var keyboardResponder = KeyboardResponder()
    
    
    var body: some View {
        VStack(spacing: 0) {
            CommentTextView(text: $text, beginEditingOnAppear: true)
            
            HStack(spacing: 0) {
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                    //dismiss消失
                }) {
                    Text("取消")
                        .padding()
                }
                
                Spacer()
                
                Button(action: {
                    if self.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                        self.showEmptyTextHUD = true
                        
                        //1.5m秒後隱藏
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.showEmptyTextHUD = false
                        }
                        return
                    }
                    print(self.text)
                    var post = self.post
                    post.commentCount += 1
                    self.userData.update(post)
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("發送")
                        .padding()
                }
            }
            .font(.system(size: 18))
            //.foregroundColor(.black)
        }
        .overlay(
            Text("評論不能為空")
                .scaleEffect(showEmptyTextHUD ? 1 : 0.5)
                .animation(.spring(dampingFraction: 0.5))
                .opacity(showEmptyTextHUD ? 1 : 0)
                .animation(.easeInOut)
        )
        .padding(.bottom, keyboardResponder.keyboardHeight)
        .edgesIgnoringSafeArea(keyboardResponder.keyboardShow ? .bottom : [])
    }
}

struct CommentInput_Previews: PreviewProvider {
    static var previews: some View {
        CommentInput(post: UserData().recommendPostList.list[0])
    }
}

