//
//  shop.swift
//  BXTview
//
//  Created by tt Wong on 18/11/2020.
//

import SwiftUI

struct shop: View {
    
    var foodType = ["全部", "蔬菜", "水果", "肉類", "飲料", "零食", "其他"]
    
    @State var search = ""
    @State var selectFoodType = "全部"
    @State var selected : Shop = Shop(shopID: 0, username: "", images: "", title: "", cost: 0, introduction: "", type: "", create_time: "") //按邊個？
    @Namespace var animation //動作
    @State var show = false  //是否顯示詳細
    
    @AppStorage("shopPosts") var shopPosts : Data = try! JSONEncoder().encode(Shops(shop: ["全部" : [presetShop]]))
    @State var shopPost : [Shop] = []
    
    var body: some View {
        
        ZStack {
            VStack {
                //title and 購物車button
                HStack {
                    Text("SHOP")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(Color(.white))
                    
                    Spacer()
                    
                    Button(action: {}) {
                        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                            Image(systemName: "cart")
                                .font(.system(size: 25))
                                .foregroundColor(Color(.white))
                            
                        //如果有野就顯示
                            Circle()
                                .fill(Color.red)
                                .frame(width: 8, height: 11)
                        }
                    }
                }
                .padding()
                
                //search bar
                HStack(spacing: 15) {
                    
                    Image(systemName: "magnifyingglass")
                        .font(.title2)
                        .foregroundColor(Color(.white))
                    
                    TextField("尋找你要的",text: $search)
//                        .preferredColorScheme(.dark)
                }
                .padding()
                .background(Color.white.opacity(0.1))
                .cornerRadius(15)
                .padding()
                
                //商店分類
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(foodType, id :\.self) {type in
                            Button(action: {selectFoodType = type}) {
                                Text(type)
                                    .font(.system(size: 15))
                                    .fontWeight(selectFoodType == type ? .bold : .none)
                                    .foregroundColor(selectFoodType == type ? Color.orange : Color.white)
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color(.white).opacity(selectFoodType == type ? 0.9 : 0.2))
                                    .cornerRadius(10)
                            }
                        }
                    }
                }
                .frame(height: 50)
                .padding(.horizontal)
//
//                HStack(spacing: 0) {
//
//                    ForEach(foodType, id :\.self){title in
//                        shopMenu(title : title, selected: $selectedFoodType)
//
//                        //giving space for all expect for last...
//
//                        if title != foodType.last {
//
//                            Spacer(minLength: 0)
//                        }
//                    }
//                }
//               // .padding()
//               // Spacer(minLength: 0)
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        ForEach(try! JSONDecoder().decode(Shops.self, from: shopPosts).shop[selectFoodType] ?? [], id: \.self) {item in
                            
                            CardView(item: item, animation: animation)
                                .shadow(color: Color.black.opacity(0.16), radius: 5, x: 0, y: 5)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selected = item
                                        show.toggle()
                                    }
                                }
                        }
                    }
                    .padding(.horizontal,22)
                }
                //半圓形
                .padding(.vertical)
                .background(
                    Color.white.opacity(0.2)
                        .clipShape(CustomCorner(corners: [.topLeft,.topRight], size: 55))
                        .ignoresSafeArea(.all, edges: .bottom)
                        .padding(.top,100)
                )
            }
            if show {
                DetailView(item: $selected, show: $show, animation: animation)
            }
        }
        .background(Color.black.ignoresSafeArea(.all, edges: .all))
        .onAppear {
            UDM.shared.getShopPost(type: "全部") { result in
                var DCshopPosts = try! JSONDecoder().decode(Shops.self, from: shopPosts)
                
                DCshopPosts.shop["全部"] = result
                shopPosts = try! JSONEncoder().encode(DCshopPosts)
            }
        }
        .onChange(of: selectFoodType, perform: { value in
            UDM.shared.getShopPost(type: selectFoodType) { result in
                var DCshopPosts = try! JSONDecoder().decode(Shops.self, from: shopPosts)
                
                DCshopPosts.shop[selectFoodType] = result
                shopPosts = try! JSONEncoder().encode(DCshopPosts)
            }
        })
    }
}




struct shop_Previews: PreviewProvider {
    static var previews: some View {
        shop()
    }
}


struct Shops : Codable, Hashable {
    var shop : [String: [Shop]]
}


