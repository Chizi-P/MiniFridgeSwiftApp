//
//  PostingPage.swift
//  MiniFridge
//
//  Created by 🐽 on 6/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import UIKit

struct PostingPage: View {
    
    var user = UDM.shared
    
    @State var showPhotoLibrary = false
    
    @State var image : UIImage = UIImage()
    @State var images = [UIImage]()
    @State var title = ""
    @State var introduction = ""
    
    @State var selectedIndex = 0
    @State var alertMessage = ""
    @State var isAlert = false
    
    
    var weather = ["文章", "食譜"]
    
    @AppStorage("isPostingLoading") var isPostingLoading = false
    @AppStorage("posting") var posting = false
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Button(action:{
                    posting = false
                }) {
                    Image(systemName: "chevron.left")
                    Text("返回")
                }
                .padding(.horizontal)
                .foregroundColor(.black)
                HStack {
                    Spacer()
                    Picker(selection: $selectedIndex, label: Text("選擇發文方式")) {
                        ForEach(weather.indices) { (index) in
                            Text(weather[index])
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width / 2)
                    .pickerStyle(SegmentedPickerStyle())
                }
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 300)
                    //                .padding(.horizontal)
                    .foregroundColor(Color(.systemGray6))
                    .overlay(
                        Text("添加照片")
                    )
                    .overlay(
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { proxy in
                                LazyHStack {
//                                    ForEach(images, id: \.self) { image in
                                        Image(uiImage: image)
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: UIScreen.main.bounds.width, height: 300, alignment: .center)
//                                    }
                                }
                            }
                        }
                    )
                    .sheet(isPresented: $showPhotoLibrary, onDismiss: {
//                        if image != UIImage() {
//                            images.append(image)
//                            image = UIImage()
//                        }
                    }, content: {
                        ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                    })
                    .onTapGesture(perform: {
                        showPhotoLibrary = true
                    })
                Group {
                    Divider()
                    TextField("標題", text: $title)
                        .font(.title)
                        .padding(.horizontal)
                    Divider()
                    Text(selectedIndex == 0 ? "介紹" : "步驟")
                        .font(.headline)
                        .padding(.horizontal)
                    TextEditor(text: $introduction)
                        .frame(minHeight: 100, maxHeight: 200)
                        .lineLimit(2)
                        .lineSpacing(10)
                        .padding(.horizontal)
                        .disableAutocorrection(true)
                    Divider()
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 60, alignment: .center)
                        .padding(.horizontal)
                        .foregroundColor(Color(.systemBlue))
                        .overlay(
                            Group {
                                if isPostingLoading {
                                    Text("上傳中...")
                                } else {
                                    Text("發布")
                                }
                            }
                            .foregroundColor(.white)
                        )
                        .onTapGesture(perform: {
                            if isPostingLoading {
                                return
                            }
                            if image == UIImage() {
                                alertMessage = "未上傳照片"
                                isAlert = true
                                return
                            }
                            if title == "" {
                                alertMessage = "請填寫標題"
                                isAlert = true
                                return
                            }
                            user.createPost(title: title, introduction: introduction, images: image, postType: (selectedIndex == 0 ? "文章" : "食譜"))
                        })
                }
                Spacer()
            }
            .padding()
        }
    }
}

struct PostingPage_Previews: PreviewProvider {
    static var previews: some View {
        PostingPage()
    }
}
