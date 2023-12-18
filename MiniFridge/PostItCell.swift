//
//  PostItCell.swift
//  MiniFridge
//
//  Created by 🐽 on 14/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostItCell: View {
    var postItItem : PostIt
    
    var expiring : Bool {
        
        func date2String(_ date:Date, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> String {
            let formatter = DateFormatter()
            formatter.locale = Locale.init(identifier: "en_US")
            formatter.dateFormat = dateFormat
            let date = formatter.string(from: date)
            return date
        }
        
        func string2Date(_ string:String, dateFormat:String = "yyyy-MM-dd HH:mm:ss") -> Date? {
            let formatter = DateFormatter()
            formatter.locale = Locale.init(identifier: "en_US")
            formatter.dateFormat = dateFormat
            let date = formatter.date(from: string)
            return date
        }
        
//        let dateFormatter = DateFormatter.init()
//        dateFormatter.dateFormat = "yyyy-MM-dd"
        
//        let date = dateFormatter.date(from: postItItem.create_time)
//        let date = string2Date(postItItem.create_time, dateFormat: "yyyy-MM-dd")
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: postItItem.create_time)
        
        let now = Date()
        print("now: ", now)
        print("create_time: ", date)
//        let nInterval = now.timeIntervalSince(date)
        print("date: ", now.daysBetweenDate(toDate: date ?? Date()))
        let b = Int(postItItem.modelData?.bestBefore ?? "0") ?? 0
        if date?.daysBetweenDate(toDate: now) ?? 0 <= -b {
            return true
        }
        return false
//        postItItem.create_time
    }
    @State var onAppear : Bool = false
    
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 80)
            .foregroundColor(.white)
            .shadow(color: Color(red: 230 / 256, green: 230 / 256, blue: 230 / 256), radius: 60, x: 0, y: 0)
            .overlay(
                HStack {
                    WebImage(url: URL(string: minifridgePath + postItItem.image + "?token=eyJhbGciOiJIUzI1NiJ9.eyJ1c2VybmFtZSI6ImNoaXppIiwiZW1haWwiOiJzdDA1MTEwNTZAZ21haWwuY29tIiwiY3JlYXRlX3RpbWUiOiIyMDIwLTExLTA5VDE0OjE0OjI0LjAwMFoiLCJhdmF0YXIiOm51bGwsImludHJvZHVjdGlvbiI6bnVsbH0.0vBmzpmimxcRA7FRMt6AYM6F7Y0lfjsEkJNQksok0DI"))
                        .placeholder { Color.gray }
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        HStack() {
                            Text(postItItem.label)
                                .font(.headline)
                            Text("\(postItItem.count)")
                                .font(.subheadline)
                        }
                        Text(postItItem.create_time)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .foregroundColor(.black)
                    Spacer()
                }
                .padding()
                .overlay(
                    Group {
                        if expiring {
                            Text("即將到期 !")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(height: 25)
                                        .foregroundColor(.red)
                                )
                                .offset(x: UIScreen.main.bounds.width/2-80, y: -40)
                        }
                    }
                )
            )
            .padding(.vertical, 5)
//            .offset(x: onAppear ? 0 : -UIScreen.main.bounds.width)
//            .opacity(onAppear ? 1 : 0)
//            .animation(.easeInOut)
//            .onAppear{
//                onAppear = true
//            }
    }
}

struct PostItCell_Previews: PreviewProvider {
    static var previews: some View {
        PostItCell(postItItem: presetPostIt)
        PostItCellLoading()
    }
}

struct PostItCellLoading: View {
    @State var animate = false
    
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .frame(height: 80)
            .foregroundColor(.white)
            .shadow(color: Color(red: 230 / 256, green: 230 / 256, blue: 230 / 256), radius: 60, x: 0, y: 0)
            .transition(AnyTransition.offset(x: animate ? 250 : 0, y: 0).animation(.easeInOut(duration: 1.0)))
            .overlay(
                Text("加載中...")
                    .foregroundColor(Color(.systemGray))
            )
//            .mask(
//                RoundedRectangle(cornerRadius: 20)
//                    .frame(height: 80)
//                    .foregroundColor(.white)
//            )
//            .transformEffect(.init(translationX: animate ? 200: 0, y: 0))
//            .shadow(color: Color(red: 230 / 256, green: 230 / 256, blue: 230 / 256), radius: 60, x: 0, y: 0)
            .animation(.easeInOut)
    }
}
