//
//  Complex.swift
//  Complex
//
//  Created by tt Wong on 21/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComplexHome: View {
    
    var postIt : PostIt = presetPostIt
    @State var width = UIScreen.main.bounds.width
//    @State var modelData = presetModelData
    
    var body: some View {
        
        ZStack(alignment: .top) {
            VStack {
                //topbutton
                HStack {
                    Button(action: {}) {
                        HStack(spacing: 5) {
                            Image(systemName: "chevron.left")
                            //.renderingMode(.original)
                            Text("冰箱貼")
                                .fontWeight(.bold)
                        }
                    }
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "bag")
                        //.renderingMode(.original)
                    }
                }
                .foregroundColor(.blue)
                .padding()
                HStack {
                    WebImage(url: URL(string: minifridgePath + postIt.image))
                        .placeholder { Color(.systemGray5) }
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                        .cornerRadius(20)
                }
                .padding(.top, 40.0)
                //food詳情
                VStack(spacing: 20) {
                    Text(postIt.label)
                        .fontWeight(.bold)
                        .font(.title)
                    Text(postIt.modelData?.type ?? "其他")
                        .fontWeight(.bold)
                        .foregroundColor(.blue)
                    ScrollView(showsIndicators: false){
                        Text(postIt.modelData?.introduction ?? "-")
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                    }
                    Text("營養價值")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                    //營養價值
                    HStack{
                        //卡路里
                        HStack {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .frame(width: 25, height: 35)
                                .foregroundColor(.white)
                            VStack {
                                Text(String(format: "%.1f", postIt.modelData?.calories ?? 0))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Text("卡路里")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                    .padding(.horizontal)
                            }
                            //.padding(.leading,20)
                        }
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                        
                        //碳水化合物
                        HStack {
                            Image(systemName: "flame.fill")
                                .resizable()
                                .frame(width: 25, height: 35)
                                .foregroundColor(.white)
                            VStack {
                                Text(String(format: "%.1f", postIt.modelData?.carbohydrates ?? 0))
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                                Text("碳水化合物")
                                    .foregroundColor(.white)
                                    .fontWeight(.bold)
                            }
                            .padding(.leading,20)
                        }
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(10)
                    }
                    
                    //營養價值2
                    HStack {
                        VStack(alignment: .center,spacing: 10){
                            Text("\(postIt.modelData?.bestBefore ?? "-")天")
                                .fontWeight(.bold)
                            Text("日期")
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        VStack(alignment: .center,spacing: 10){
                            Text(String(format: "%.1fg", postIt.modelData?.fat ?? 0))
                                .fontWeight(.bold)
                            Text("脂肪")
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        VStack(alignment: .center,spacing: 10){
                            Text(String(format: "%.1fg", postIt.modelData?.protein ?? 0))
                                .fontWeight(.bold)
                            Text("蛋白")
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 20.0)
                }
                .padding(.horizontal, 20)
                Spacer()
                //                Button(action : {}) {
                //
                //                    Text("分享")
                //                        .fontWeight(.bold)
                //                        .foregroundColor(.white)
                //                        .padding(.vertical)
                //                        .frame(width: self.width - 50)
                //                        .background(Color.blue)
                //                        .clipShape(Capsule())
                //                }
                //                .padding(.bottom,25)
            }
            .zIndex(1)
            //背景-Circle
            Circle()
                .fill(Color(.black))
                .frame(width: self.width + 150, height: self.width + 200)
                .padding(.horizontal, -100)
                //moving view up...
                .offset(y: -self.width)
            Circle()
                .fill(Color(.black))
                .frame(width: self.width + 150, height: self.width + 200)
                .padding(.horizontal, -100)
                //moving view up...
                .offset(y: self.width + 390)
        }
    }
}

struct Complex_Previews: PreviewProvider {
    static var previews: some View {
        ComplexHome(postIt: presetPostIt)
    }
}
