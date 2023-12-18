//
//  PostItPage.swift
//  MiniFridge
//
//  Created by 🐽 on 6/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct PostItPage: View {
    
    init() {
        UITableView.appearance().separatorStyle = .none
        
        //隱藏按鍵後灰色效果
        UITableViewCell.appearance().selectionStyle = .none
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        
        // 背景通透 讓 background color 呈現
        UITableView.appearance().backgroundColor = .clear
        
        // To remove only extra separators below the list:
        UITableView.appearance().tableFooterView = UIView()
        
        // To remove all separators including the actual ones:
        UITableView.appearance().separatorStyle = .none
    }
    
    //    @AppStorage("PostIts") var postIts : Data = encodedPostIt(postItDatas)
    
    @State private var isShowOptions = false
    @State private var isShowPhotoLibraryOrCameraSheet = false
    @State private var isShowPhotoLibrary = false
    @State var edit = false
    @State var isShowShare = false
    @State var isSetting = false
    @State private var image = UIImage()
    @State private var oldImage = UIImage()
    @State private var classificationLabel : String = ""
    
    //    @State var getUserPostResult : [UserPost] = [UserPost(postID : 0, username : "0", images: "0", text: "0", create_time : "0")]
    //    @State var getAllPostIt: [PostIt] = [presetPostIt]
    
    @AppStorage("postIt") var postIt : Data = encodedPostIt([presetPostIt])
    @AppStorage("modelDatas") var modelDatas : Data = try! JSONEncoder().encode([presetModelData])
    @AppStorage("calories") var calories : Double = 0
    
    @State var DCpostIt : [PostIt] = []
    
    @AppStorage("isCreatingPostIt") var isCreatingPostIt = false
    
    // 更新畫面用
    @AppStorage("postItUpdateView") var postItUpdateView = false
    
    @State var alertFailedToSyncData = false
    
    var body: some View {
        // 列表
        NavigationView {
            //            ScrollView {
            //                LazyVStack {
            //
            //                }
            //            }
            ScrollView(showsIndicators: false) {
                LazyVStack {
//                    RoundedRectangle(cornerRadius: 40)
//                        .foregroundColor(Color("m1"))
//                        .padding(-16)
//                        .frame(height: 180)
//                        .offset(y: -50)
//                        .overlay(
//                            VStack {
//                                HStack {
//                                    postItToolButton(text: "飲食分析")
//                                    postItToolButton(text: "共享代購")
//                                    Spacer()
//
//                                }
//                                Spacer()
//                            }
//                        )
                    // 冰箱貼容量 收費解鎖
                    BoxCalculateCapacity(count: calories, maxCount: 2500)
                    
                    // 設定
                    HStack {
                        Spacer()
                        Button(action: {self.isSetting = true}) {
                            Image(systemName: "list.dash")
                        }
                        Button(action: {self.edit.toggle()}) {
                            Text(edit ? "done" : "Edit")
                        }
                    }
                    Spacer()
                        .frame(height: 20)
                    if isCreatingPostIt {
                        PostItCellLoading()
                    }
                    ForEach(DCpostIt, id: \.self) { item in
                        NavigationLink(destination: ComplexHome(postIt: item)) {
                            PostItCell(postItItem: item)
                                .overlay(   // 編輯功能
                                    Group {
                                        if edit {
                                            Button(action: {
//                                                let dp : [PostIt] = decodedPostIt(self.postIt)
                                                let index = DCpostIt.firstIndex(of: item)!
                                                let postItID = DCpostIt[index].postItID
                                                if let index = DCpostIt.firstIndex(of: item) {
                                                    DCpostIt.remove(at: index)
                                                }
                                                NetworkAPI.deletePostIt(postItID: postItID) { result in
                                                    switch result {
                                                    case .success(_):
                                                        postItUpdateView = true
                                                    case let .failure(error):
                                                        print(error)
                                                    }
                                                }
                                            }) {
                                                Image(systemName: "xmark.circle.fill")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: 23, height: 23)
                                                    .foregroundColor(.red)
                                                    .shadow(color: .gray, radius: 20)
                                            }.offset(x: UIScreen.main.bounds.width/2 - 20, y: -40)
                                        }
                                    }
                                ).animation(.easeInOut)
                            //                                VStack(alignment: .leading) {
                            //                                    Text("\(item.label)")
                            //                                        .font(.headline)
                            //                                    Text("\(item.count)")
                            //                                        .font(.subheadline)
                            //                                    Text(item.create_time)
                            //                                        .font(.caption)
                            //                                        .foregroundColor(.gray)
                            //                                }
                        }
                    }
                    //                        .onDelete { index in
                    //                            let dp : [PostIt] = decodedPostIt(postIt)
                    //                            //                                dp.remove(at: index.first!)
                    //                            NetworkAPI.deletePostIt(postItID: dp[index.first!].postItID) { result in
                    //                                switch result {
                    //                                case .success(_):
                    //                                    NetworkAPI.getAllPostIt() { result in
                    //                                        switch result {
                    //                                        case let .success(data):
                    //                                            postIt = encodedPostIt(data)
                    //                                        case let .failure(error):
                    //                                            print(error)
                    //                                        }
                    //                                    }
                    //                                case let .failure(error):
                    //                                    print(error)
                    //                                }
                    //                            }
                    //                        }
                    //                        .onMove { source, destination in
                    //                            // ！從數據庫獲取排列數據之方法
                    //                            var dp = decodedPostIt(self.postIts)
                    //                            dp.swapAt(source.first!, destination)
                    //                            self.postIts = encodedPostIt(dp)
                    //                        }
                }
                .padding()
                .listStyle(PlainListStyle()) // 貼齊
                .navigationBarTitle("冰箱貼", displayMode: .inline)
                .navigationBarHidden(true)
                //                    .navigationBarItems(trailing: EditButton())
                // 背景顏色
                .background(Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            isCreatingPostIt = false
            //            resetDefaults()
            NetworkAPI.getAllPostIt() { result in
                switch result {
                case let .success(data):
                    calories = 0
                    for item in data {
                        calories = calories + (item.modelData?.calories ?? 0.0)
                    }
                    DCpostIt = data
                    self.postIt = encodedPostIt(data)
                case let .failure(error):
                    print(error)
                    self.alertFailedToSyncData = true
                }
            }
            // ！ 做熱量加減 在這畫面獲取
            //            UDM.shared.getModelData(label: decodedPostIt(postIt)) { result in
            //                modelData = result
            //            }
        }
        .onChange(of: postItUpdateView, perform: { value in
            if value == true {
                NetworkAPI.getAllPostIt() { result in
                    switch result {
                    case let .success(data):
                        isCreatingPostIt = false
                        calories = 0
                        for item in data {
                            calories = calories + (item.modelData?.calories ?? 0.0)
                        }
                        DCpostIt = data
                        self.postIt = encodedPostIt(data)
                        postItUpdateView = false
                    case let .failure(error):
                        print(error)
                        self.alertFailedToSyncData = true
                        postItUpdateView = false
                    }
                }
            }
        })
        .alert(isPresented: $alertFailedToSyncData) {
            return Alert(title: Text("出現問題"), message: Text("無法進行資料同步"))
        }
    }
}

struct PostItPage_Previews: PreviewProvider {
    static var previews: some View {
        PostItPage()
    }
}

// 數據結構
struct PostItData: Identifiable, Codable {
    var id = UUID()
    var label : String
    var count : Int
    var date : String = getDate()
    var content : String
}

let postItDatas = [
    PostItData(label: "可口可樂", count: 6, date: "2020-01-01", content: """
每100毫升 原味可口可樂
能量    42千卡
蛋白質    　0克
總脂肪    0克
飽和脂肪    0克
反式脂肪    0克
碳水化合物    10點6克
糖    10點6克
鈉    4毫克
"""),
    PostItData(label: "百事可樂", count: 2, content: "這是一瓶可樂"),
    PostItData(label: "西蘭花", count: 1, content: "這是一瓶可樂"),
    PostItData(label: "麥香", count: 1, content: "這是一瓶可樂"),
    PostItData(label: "雞蛋", count: 12, content: "這是一瓶可樂"),
]



struct BoxCalculateCapacity: View {
    var count : Double
    var maxCount : Float
    var ratio : Float {
        Float(count) / maxCount < 0 ? 0 : Float(count) / maxCount > 1 ? 1 : Float(count) / maxCount
    }
    
    var body: some View {
        BoxView(
            width: .infinity,
            height: 100,
            color: Color.white,
            cornerRadius: 20,
            shadowColor: Color(red: 230 / 256, green: 230 / 256, blue: 230 / 256),
            shadowRadius: 60,
            shadowX: 0,
            shadowY: 0
        )
        .padding(.vertical, 30)
        .overlay(
            VStack {
                Spacer()
                Text("熱量")
                    .font(.system(size: 16))
                    .font(.system(size: 13))
                DataBarView(text: "\(count)", textSize: 10, textColor: Color.black, barColor: ratio >= 1 ? Color.red : Color.green, barBackgroundColor: Color(.systemGray5), barHeigth: 10, percent: CGFloat(ratio))
                if ratio >= 1 {
                    Text("「每日建議攝取熱量2000大卡，請注意控管」")
                        .font(.system(size: 14))
                }
                Text("更多功能需要付費解鎖")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
        )
    }
}



// 模型
let model = FoodModel41()

func performImageClassification(image: UIImage) -> String {
    if image == UIImage() {
        return "沒變"
    }
    guard let buffer = image.resizeTo(size: CGSize(width: 299, height: 299)).toBuffer() else {
        return "圖像無法轉換大小" 
    }
    let output = try? model.prediction(image: buffer)
    //        if let output = output {
    //            let results = output.classLabelProbs.sorted{$0.1 > $1.1}
    //
    //            let result = results.map { (key, value) in // 全部結果變成一個String
    //                return "\(key) = \(value * 100)%"
    //            }.joined(separator: "\n")
    //
    //            classificationLabel = result
    //        }
    if let output = output {
        //            self.postItList.append(output.classLabel.components(separatedBy: ",")[0])
        //        oldImage = image
        return output.classLabel.components(separatedBy: ",")[0]
    }
    return "模型出現問題"
}

struct postItToolButton: View {
    let text : String
    var body: some View {
        RoundedRectangle(cornerRadius: 18)
            .foregroundColor(.white)
            .opacity(0.8)
            .frame(width: 60, height: 60)
            .shadow(radius: 45)
            .padding()
            .overlay(
                ZStack {
                    Text(text)
                        .foregroundColor(.white)
                        .font(.system(size: 12))
                        .offset(y: 50)
                    
                }
            )
    }
}
