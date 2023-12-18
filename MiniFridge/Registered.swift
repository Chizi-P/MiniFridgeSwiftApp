//
//  Register.swift
//  Login
//
//  Created by tt Wong on 13/11/2020.
//

import SwiftUI
//import LocalAuthentication

struct Registered: View {
    
    //    @StateObject var RegisteredModel = RegisteredViewModel()
    
    @State var user = UDM.shared
    
    //    @AppStorage("registeredFinish") var registeredFinish = false
    
    @State var username = ""
    @State var password = ""
    @State var confirmPassword = ""
    @State var email = ""
    @State var introduction = ""
    @State var avatar = UIImage()
    @State var showPhotoLibrary = false
    
    @AppStorage("registered") var registered = false
    @AppStorage("isregisteredLoading") var isregisteredLoading = false
    @AppStorage("alertregisteredMessage") var alertregisteredMessage = false
    @AppStorage("registeredMessage") var registeredMessage = ""
    
    @State var selectedIndex = ""
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            ZStack{
                
                
                VStack {
                    HStack(){
                        //退出按鈕
                        Button(action: {registered = false}) {
                            Image(systemName: "chevron.left")
                                .padding(.leading, 25)
                            Text("登入")
                                .bold()
                                .font(.system(size: 17.0))
                        }
                        .foregroundColor(.white)
                        Spacer()
                    }
                    
                    //頭像
                    ZStack {
                        if avatar == UIImage() {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 65))
                                .foregroundColor(.black)
                                .frame(width: 115, height: 115)
                                .background(Color.white)
                                .clipShape(Circle())
                            
                        }
                        else{
                            Image(uiImage: avatar)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 115, height: 115)
                                .clipShape(Circle())
                        }
                    }
                    //Dynamic Frame
                    .padding(.horizontal,150)
                    .onTapGesture(perform: {
                        showPhotoLibrary = true
                    })
                    
                    //用戶名稱
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        TextField("用戶名稱", text: $username)
                            .autocapitalization(.none)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(username == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    //Email
                    HStack {
                        Image(systemName: "envelope.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        TextField("Email", text: $email)
                            .autocapitalization(.none)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(email == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    //密碼
                    HStack {
                        Image(systemName: "lock")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        TextField("密碼", text: $password)
                            .autocapitalization(.none)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(password == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    //確認密碼
                    HStack {
                        Image(systemName: "lock.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        
                        TextField("確認密碼", text: $confirmPassword)
                            .autocapitalization(.none)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(confirmPassword == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    
                    //簡介
                    HStack {
                        Image(systemName: "person.fill")
                            .font(.title)
                            .foregroundColor(.white)
                            .frame(width: 35)
                        TextField("自介", text: $introduction)
                            .autocapitalization(.none)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .background(Color.black.opacity(introduction == "" ? 0.02 : 0.12))
                    .cornerRadius(15)
                    .padding(.horizontal)
                    .padding(.top)
                    Group {
                        Text("選擇你的個性標籤")
                        Picker(selection: $selectedIndex, label: Text("選擇個人標籤")) {
                            Text("家庭主婦").tag("家庭主婦")
                            Text("單身貴族").tag("單身貴族")
                            Text("廚神達人").tag("廚神達人")
                            Text("萌廚新手").tag("萌廚新手")
                            Text("網紅博主").tag("網紅博主")
                            Text("神秘莫測").tag("神秘莫測")
                        }
    //                    .pickerStyle(SegmentedPickerStyle())
                        .foregroundColor(Color.white)
                        .frame(width: 300, height: 150)
                        .clipped()
                        .padding()
                        .background(Color(.systemGray6).cornerRadius(20))
                        
                        Divider()
                    }
                    
                    //註冊按鈕
                    HStack(spacing: 15) {
                        //註冊按鈕
                        Button(action: {
                            if  confirmPassword != password {
                                registeredMessage = "密碼和確認密碼不相同"
                                alertregisteredMessage = true
                                return
                            }
                            // ！沒加入 intriduction
                            user.signUp(username: username, password: password, email: email, avatar: avatar, userType: selectedIndex)
                        }) {
                            Text("註冊")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 150)
                                .background(Color(.white))
                                .clipShape(Capsule())
                        }
                        .opacity(email != "" && password != "" && confirmPassword != ""  ? 1 : 0.5)
                        .disabled(email != "" && password != "" && confirmPassword != "" && password != "" ? false : true)
                        .alert(isPresented: $alertregisteredMessage) {
                            Alert(title: Text("註冊錯誤"), message: Text(registeredMessage), dismissButton: .destructive(Text("OK!")))
                        }
                    }
                    Spacer(minLength: 0)
                }
                .background(Color.black.opacity(0.4).ignoresSafeArea(.all, edges: .all))
                .sheet(isPresented: $showPhotoLibrary, content: {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $avatar)
                })
            }
            .preferredColorScheme(.dark)
        }
    }
}


struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Registered()
    }
}
