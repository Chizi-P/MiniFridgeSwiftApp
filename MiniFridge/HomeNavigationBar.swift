//
//  HomeNavigationBar.swift
//  weiboDemo2
//
//  Created by tt Wong on 27/10/2020.
//

import SwiftUI

private let kLableWidth: CGFloat = 60
private let kButtonHigh: CGFloat = 24

struct HomeNavigationBar: View {
    
    //綁定
    @Binding var leftPercent: CGFloat // 0 for left, 1 for right
    
    @AppStorage("posting") var posting = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 0){  //左右兩邊的按鈕
            Button(action: {
                print("Click Camera button")
            }) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHigh, height: kButtonHigh)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundColor(.black)
                    
            }
            Spacer()
            
            VStack(spacing: 3) {
                
                HStack(spacing: 0 ) {
                    Text("關注")
                        .bold()
                        .frame(width:kLableWidth,height: kButtonHigh)
                        .padding(.top, 5)
                        .opacity(Double(1 - leftPercent * 0.5)) //透明度
                        .onTapGesture { //點擊手勢
                            withAnimation { //動畫
                                self.leftPercent = 0
                            }
                           
                        }
                    
                    Spacer()
                    
                    Text("推薦")
                        .bold()
                        .frame(width:kLableWidth,height: kButtonHigh)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + leftPercent * 0.5))
                        .onTapGesture { //點擊手勢
                            withAnimation{
                                
                                self.leftPercent = 1
                            }
                            
                        }
                
                }
                .font(.system(size: 20))
                
                //幾何讀取器 --可以獲得整個view的寬高
                GeometryReader { geometry in
                    RoundedRectangle(cornerRadius: 2)
                        .foregroundColor(.orange)
                        .frame(width: 35, height: 4 )
                        .offset(x: geometry.size.width  * (self.leftPercent - 0.08) + kLableWidth * (0.5 - self.leftPercent))
                    
                }
                .frame(height: 6)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.5 )
            
            Spacer()
            
            Button(action: {
                print("Click circle button")
                posting = true
            }) {
                Image(systemName: "square.and.pencil")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kButtonHigh, height: kButtonHigh)
                    .padding(.horizontal, 15)
                    .padding(.top, 5)
                    .foregroundColor(Color("bg"))
            }
            .fullScreenCover(isPresented: $posting, content: {
                PostingPage()
            })
        }
        .frame(width: UIScreen.main.bounds.width)
        
    }
}

struct HomeNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        HomeNavigationBar(leftPercent: .constant(1))
    }
}
