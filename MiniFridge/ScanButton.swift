//
//  ScanButton.swift
//  MiniFridge
//
//  Created by 🐽 on 28/9/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct ScanButton: View {
    
    @State private var isShowScanButtonOptions = false
    @State private var isShowPhotoLibrary = false
    @State private var image = UIImage()
    
    // 旋轉動畫用
    @State private var rotateDegree : Double = 0
    @State private var opacity : Double = 0
    
    var body: some View {
        ZStack {
            Button(action: {
                print("Click Scan Button")
                if self.isShowScanButtonOptions {
                    self.rotateDegree = 0
                    self.isShowScanButtonOptions = false
                    self.opacity = 0
                } else {
                    self.rotateDegree = 135
                    self.isShowScanButtonOptions = true
                    self.opacity = 1
                }
                
            }) {
                RoundedRectangle(cornerRadius: 25)
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color.black)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(Color.gray)
                            .frame(width: 50, height: 50)
                    )
                }.zIndex(1)
                // 旋轉動畫
                .rotationEffect(.degrees(rotateDegree))
                .animation(.easeOut)
            
                RoundedRectangle(cornerRadius: 25) // 圓角矩形
                    .frame(width: 150, height: 200)
    //            .stroke(Color.black, lineWidth: 1) // 描邊
                .overlay(
                    VStack {
                        Text("增加食物")
                            .foregroundColor(Color.white)
                            .bold()
                            .font(.system(size: 16))
                            .padding(.top, 20)
                        Divider()
                            .background(Color.gray)
                        Button(action: {
                            self.isShowPhotoLibrary = true
                        }) {
                            Text("相簿照片辨識")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                                .bold()
                        }.sheet(isPresented: $isShowPhotoLibrary) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        }
                        
                        Divider()
                            .background(Color.gray)
                        Button(action: {
                            self.isShowPhotoLibrary = true
                        }) {
                            Text("拍照辨識")
                                .foregroundColor(Color.white)
                                .font(.system(size: 16))
                                .bold()
                        }.sheet(isPresented: $isShowPhotoLibrary) {
                            ImagePicker(sourceType: .camera, selectedImage: self.$image)
                        }
                        Spacer()
                    })
                    .offset(x: -45, y: -70)
                    .opacity(opacity)
                    .animation(.easeOut)
        }
    }
}

struct ScanButton_Previews: PreviewProvider {
    static var previews: some View {
        ScanButton()
    }
}
