//
//  ShopPosting.swift
//  MiniFridge
//
//  Created by 🐽 on 4/12/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct ShopPosting: View {
    
    @State var showPhotoLibrary = false
    
    @State var image : UIImage = UIImage()
//    @State var images = [UIImage]()
    @State var title = ""
    @State var introduction = ""
    @State var cost = ""
    @State var foodType : [FoodType] = []
    @State var selectFoodType = ""
    
    @State var isAlert = false
    @State var alertMessage = ""
    
    @AppStorage("shopPosting") var shopPosting = false
    @AppStorage("isShopPostingLoading") var isShopPostingLoading = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
//                Button(action:{
//                    shopPosting = false
//                }) {
//                    Image(systemName: "chevron.left")
//                    Text("返回")
//                }
//                .padding(.horizontal)
//                .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 0)
                    .frame(height: 300)
                    //                .padding(.horizontal)
                    .foregroundColor(Color(.systemGray6))
                    .overlay(
                        Text("添加照片")
                    )
                    .overlay(
                        ScrollView(.horizontal) {
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
//                Divider()
                TextField("商品名稱", text: $title)
                    .font(.title)
                    .padding(.horizontal)
                ScrollView(.horizontal) {
//                    GeometryReader { geometry in
                        LazyHStack {
                            ForEach(foodType, id :\.self) { item in
                                Button(action: {selectFoodType = item.foodType}) {
                                    Text(item.foodType)
                                        .font(.system(size: 15))
                                        .fontWeight(selectFoodType == item.foodType ? .bold : .none)
                                        .foregroundColor(selectFoodType == item.foodType ? Color(.systemYellow) : Color.white)
                                        .padding(.vertical, 10)
                                        .padding(.horizontal, 20)
                                        .background(Color(.black).opacity(selectFoodType == item.foodType ? 0.5 : 0.85))
                                        .cornerRadius(10)
                                }
            //                        if (item.foodType != foodType[foodType.count - 1].foodType) {
            //                            Spacer(minLength: 0)
            //                        }
                            }
//                        }
                    }
                }
                .onAppear {
                    UDM.shared.getFoodType { result in
                        foodType = result
                    }
                }
                Divider()
                TextField("價格", text: $cost)
                    .padding(.horizontal)
                Divider()
                VStack(alignment: .leading) {
                    Text("商品詳情：")
                        .font(.headline)
                        .padding(.horizontal)
                    TextEditor(text: $introduction)
                        .frame(minHeight: 100, maxHeight: 200)
                        .lineLimit(2)
                        .lineSpacing(10)
                        .padding(.horizontal)
                        .disableAutocorrection(true)
                }
                VStack {
                    Divider()
                    RoundedRectangle(cornerRadius: 15)
                        .frame(height: 60, alignment: .center)
                        .padding(.horizontal)
                        .foregroundColor(Color(.systemBlue))
                        .overlay(
                            Group {
                                if isShopPostingLoading {
                                    Text("上傳中...")
                                } else {
                                    Text("發布")
                                }
                            }
                            .foregroundColor(.white)
                        )
                        .onTapGesture(perform: {
                            if isShopPostingLoading {
                                return
                            }
                            if selectFoodType == "" {
                                alertMessage = "請選擇商品類別"
                                isAlert = true
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
                            UDM.shared.createShopPost(username: UDM.shared.username, image: image, title: title, cost: (cost as NSString).floatValue, introduction: introduction, type: selectFoodType) { result in
                                image = UIImage()
                                title = ""
                                introduction = ""
                                cost = ""
                                foodType = []
                                selectFoodType = ""
                            }
                        })
                }
                Spacer()
            }
            .padding()
        }
        .alert(isPresented: $isAlert) {
            return Alert(title: Text("問題"), message: Text(alertMessage))
        }
    }
}

struct ShopPosting_Previews: PreviewProvider {
    static var previews: some View {
        ShopPosting(foodType: [FoodType(foodType: "蔬菜"), FoodType(foodType: "肉類"), FoodType(foodType: "海鮮"), FoodType(foodType: "零食")])
    }
}
