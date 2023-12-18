//
//  DetailView.swift
//  BXTview
//
//  Created by tt Wong on 18/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
    @Binding var item : Shop
    @Binding var show : Bool
    //for hero animation
    var animation : Namespace.ID

    var body: some View {
        
        VStack {
            
            VStack{
                HStack {
                    Button(action: {
                        withAnimation(.spring()){show.toggle()}
                    }) {
                        HStack(spacing: 10) {
                            
                            Image(systemName: "arrow.left")
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                            
                            Text("商城")
                                .foregroundColor(.black)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {}) {
                        ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)){
                            Image(systemName: "bag")
                                .font(.system(size: 25))
                                .foregroundColor(Color(.black))
                            
                        //如果有野就顯示
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 8, height: 11)
                                .offset(x: -5, y: -5)
                        }
                    }
                }
                .padding()
                ScrollView(.vertical, showsIndicators: false) {
                    VStack{
                        WebImage(url: URL(string: minifridgePath + item.images))
                            .placeholder { Color(.systemGray5) }
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.horizontal,45)
                            .background(Color.white)
                            .matchedGeometryEffect(id: item.images, in: animation)
                            .padding(.top,10)
                    
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text(item.title)
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            
                            Text(String(format: "%.2f", Float(item.cost)))
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(Color("bg"))
                                .padding(.top,8)
                            
                            Text(item.introduction)
                            
                            Text("安全提示：")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .multilineTextAlignment(.leading)
                                
                            Text("请勿随意接收任何来源不明的文件，请勿随意点击任何来源不明的链接。涉及资金往来的事项请务必仔细核对资金往来信息。 天猫不会以订单有问题，让您提供任何银行卡、密码、手机验证码！遇到可疑情况可在钱盾“诈骗举报”中进行举报, 安全推荐")
                                //.multilineTextAlignment(.leading)
                                .foregroundColor(.gray)
                    }
                  }
               }
                .padding()
            }

            .background(Color(.white).clipShape(CustomCorner(corners: [.bottomLeft,.bottomRight], size: 45)).ignoresSafeArea(.all, edges: .top))
        
        Button(action : {}) {
            
            Text("加入購物車")
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.vertical)
                .frame(width: UIScreen.main.bounds.width - 45)
                .background(Color.orange)
                .clipShape(Capsule())
                .padding(.vertical)
        }
    }
        
        .background(Color("bg"))
        .ignoresSafeArea(.all, edges: .bottom)
        
    }
}

