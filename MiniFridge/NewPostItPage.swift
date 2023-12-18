//
//  NewPostItPage.swift
//  MiniFridge
//
//  Created by 🐽 on 31/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

struct NewPostItPage: View {
    @AppStorage("postIt") var postIt : Data = encodedPostIt([presetPostIt])
//    var postIts = postItDatas
    
    var body: some View {
        VStack() {
            NavigationView {
                List {
                    ForEach(decodedPostIt(postIt), id: \.self) { postIt in
                        NavigationLink(destination: PostItDetail(postItItem: postIt)) {
                            VStack(alignment: .leading) {
                                Text(postIt.label)
                                    .font(.headline)
                                Text("\(postIt.count)")
                                    .font(.subheadline)
                                Text(postIt.create_time)
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
//                    .onDelete { index in
//                        var dp : [PostItData] = decodedPostIt(postIts)
//                        dp.remove(at: index.first!)
//                        self.postIts = encodedPostIt(dp)
//                    }
//                    .onMove { source, destination in
//                        var dp = decodedPostIt(self.postIts)
//                        dp.swapAt(source.first!, destination)
//                        self.postIts = encodedPostIt(dp)
//                    }
                }
                .listStyle(PlainListStyle()) // 貼齊
                .navigationTitle("冰箱貼")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
}

struct NewPostItPage_Previews: PreviewProvider {
    static var previews: some View {
        NewPostItPage()
    }
}

func objToJson(value : [PostItData]) -> Data {
    return try! JSONEncoder().encode(value)
}
func dataToObj(data: Data) -> [PostItData] {
    return try! JSONDecoder().decode([PostItData].self, from: data)
}
