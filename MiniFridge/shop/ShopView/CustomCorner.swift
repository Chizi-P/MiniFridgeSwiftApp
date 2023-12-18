//
//  CustomCorner.swift
//  BXTview
//
//  Created by tt Wong on 18/11/2020.
//

import SwiftUI

struct CustomCorner: Shape {
    var corners : UIRectCorner
    var size : CGFloat
   
    func path(in rect: CGRect) -> Path {
        
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: size, height: size))
        
        return Path(path.cgPath)
    }
}


