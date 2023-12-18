//
//  Login.swift
//  Login
//
//  Created by tt Wong on 12/11/2020.
//

import SwiftUI
//import LocalAuthentication


struct Login: View {
    
    //    //測試
    //    @AppStorage("stored_User") var Stored_User = ""
    //    @AppStorage("stored_Password") var Stored_Password = ""
    //
    //        @AppStorage("status") var logged = false
    //        @AppStorage("status2") var registered = false
    
    //loading～
    @State var startAnimate = false
    
    @State var email = ""
    @State var password = ""
    @AppStorage("alertSignInMessage") var alertSignInMessage = false
    @AppStorage("signInMessage") var signInMessage = ""
    @State var store_Info = false
    
    @State var user = UDM.shared
    @AppStorage("isSigninLoading") var isSigninLoading = false
    
    @AppStorage("goLogin") var goLogin = false
    
    @AppStorage("registered") var registered = false
//    @AppStorage("registeredFinish") var registeredFinish = false
    
    var body: some View {
        
        ZStack{
            VStack{
                HStack {
                    Button(action:{
                        self.goLogin = false
                    }) {
                        Image(systemName: "chevron.left")
                            .padding(.leading, 25)
                        Text("返回")
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                Spacer(minLength: 0)
                
                Image("t&g")
                    .resizable() //縮放圖片
                    .aspectRatio(contentMode: .fit)
                    //Dynamic Frame
                    .padding(.horizontal, 70)
                // .frame(width: 250) //大小
                //  .padding(.vertical)
                
                
                //            HStack{
                //
                //                VStack(alignment: .leading, spacing: 12, content: {
                //                    Text("登入")
                //                        .font(.title)
                //                        .fontWeight(.bold)
                //                        .foregroundColor(.white)
                //
                //                    Text("登入後可接著操作")
                //                        .foregroundColor(Color.white.opacity(0.12))
                //                })
                //                Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/) //向左
                //
                //            }
                //            .padding(.vertical)
                //        VStack{
                HStack {
                    
                    Image(systemName: "envelope")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    
                    TextField("User Name", text: $email)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(email == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                
                HStack {
                    
                    Image(systemName: "lock")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(width: 35)
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                }
                .padding()
                .background(Color.white.opacity(password == "" ? 0 : 0.12))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top)
                
                HStack(spacing: 15) {
                    
                    //登入按鈕
                    //                LoginModel.verifyUser
                    Button(action: {
                        // 伺服器登錄
                        UDM.shared.signIn(username: email, password: password)
                    }, label: {
                        Text("登入")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 150)
                            .background(Color(.black))
                            .clipShape(Capsule())
                    })
                    .opacity(email != "" && password != "" ? 1 : 0.5)
                    .disabled(email != "" && password != "" ? false : true)
                    .alert(isPresented: $alertSignInMessage) {
                        Alert(title: Text("登入錯誤"),message: Text(signInMessage), dismissButton: .destructive(Text("OK!")))
                    }
                    
                    //                if  LoginModel.getBioMetricStatus() {
                    //
                    //                        Button(action: LoginModel.authenticateUser, label: {
                    //                            //取得生物資訊
                    //                            Image(systemName: LAContext().biometryType ==
                    //                                .faceID ? "faceid" : "touchid")
                    //                                .font(.title)
                    //                                .foregroundColor(.black)
                    //                                .padding()
                    //                                .background(Color(.white))
                    //                                .clipShape(Circle())
                    //                        })
                    //                    }
                }
                .padding(.top)
                
                // 忘記密碼
//                Button(action: {}, label: {
//                    Text("忘記密碼？")
//                        .font(.system(size: 14))
//                        .foregroundColor(.black)
//                })
                .padding(.top,5)
                //                .alert(isPresented: store_Info, content: {
                //                     Alert(title: Text("Message"), message: Text("Store Information For Future Login Using BioMetric Authentication ???"), primaryButton: .default(Text("Accept"), action:{
                //
                //                         //storing Info for BioMetric...
                ////                         Stored_User = email
                ////                         Stored_Password = password
                //
                //                         withAnimation{self.logged = true}
                //                     }), secondaryButton: .cancel({
                //                         //重新回到首頁
                //                         withAnimation{self.logged = true}
                //                     }))
                //                 })
                
                Spacer(minLength: 0) //向上
                // 註冊
//                HStack {
//
//                    Text("還沒有成為會員嗎？")
//                        .font(.system(size: 14))
//                        .foregroundColor(.white)
//                    //                    LoginModel.verifyRegister
//                    Button(action: {
//                        registered = true
//                    }, label: {
//                        Text("註冊")
//                            .font(.system(size: 15))
//                            .foregroundColor(.black)
//
//                    }).fullScreenCover(isPresented: $registered, content: {
//                        Registered()
//                    })
//
//                }
//                .padding(.vertical)
                //            }
                //            .foregroundColor(Color.white.opacity(0.9))
                //            .overlay(Rectangle().stroke(Color.white.opacity(0.03),lineWidth: 2).shadow(radius: 4))
                
            }
            
            .background(Color.white.ignoresSafeArea(.all, edges: .all))
            .animation(startAnimate ? .easeOut : .none)
            
            
            if isSigninLoading {
                LoadingScreen()
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 ){
                self.startAnimate.toggle()
            }
        })
        
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
