//
//  shopMenu.swift
//  BXTview
//
//  Created by tt Wong on 18/11/2020.
//

import SwiftUI

struct shopMenu: View {
    
    var title : String
    @Binding var selected : String
    
    var body: some View {
       
     
        Button(action: {selected = title}) {
            
            Text(title)
               // .font(.system(size: 15))
                .fontWeight(selected == title ? .bold : .none)
                .foregroundColor(selected == title ? Color(.systemYellow) : Color.white.opacity(0.7))
                .padding(.vertical,10)
                .padding(.horizontal,20)
                .background(Color(.white).opacity(selected == title ? 0.05 : 0))
                .cornerRadius(10)
       }
    }
}


