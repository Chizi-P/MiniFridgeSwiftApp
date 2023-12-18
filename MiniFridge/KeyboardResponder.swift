//
//  KeyboardResponder.swift
//  weiboDemo2
//
//  Created by tt Wong on 31/10/2020.
//

import SwiftUI

class KeyboardResponder: ObservableObject {
    @Published var keyboardHeight: CGFloat = 0
    
    var keyboardShow: Bool { keyboardHeight > 0 }
    
    //在默認的通知中心，添加一個通知的觀察者，觀察鍵盤即將出現的通知，self就是監聽者，當鍵盤出現時
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIWindow.keyboardWillShowNotification, object: nil)
        
        //監聽鍵盤消失。。。
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIWindow.keyboardWillHideNotification, object: nil)
    }
    //移除通知的監聽者
    deinit { NotificationCenter.default.removeObserver(self) }
    
    //當鍵盤出現時，則執行以下函數
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        //獲得鍵盤的位置大小 //?可以為空
        guard let frame = notification.userInfo?[UIWindow.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        keyboardHeight = frame.height
    }
    
    //鍵盤消失時
    @objc private func keyboardWillHide(_ notification: Notification) {
        keyboardHeight = 0
    }
}

