//
//  TakePhotoView.swift
//  MiniFridge
//
//  Created by 🐽 on 28/9/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import UIKit
import SwiftUI

// 創建ImagePicker類別 用於訪問相機和相冊
// 參考https://www.appcoda.com.tw/swiftui-camera-photo-library/
/** 使用方法
 在 struct 中定義
 @State private var isShowPhotoLibrary = false
 @State private var image = UIImage()
 
 修改isShowPhotoLibrary來顯示選擇照片介面
 選擇到的圖片儲存在image
 
 在button action 裡加入 self.isShowPhotoLibrary = true
 在Stack外面加
 .sheet(isPresented: $isShowPhotoLibrary) {
     ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
 
 .photoLibrary 改成 .camera 來使用相機
 */

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}
