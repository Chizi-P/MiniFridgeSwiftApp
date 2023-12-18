//
//  Extensions.swift
//  MiniFridge
//
//  Created by 🐽 on 26/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

func endEditing() {
    UIApplication.shared.endEditing()
}

extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    /// ```
    /// Text("Label")
    ///     .isHidden(true)
    /// ```
    ///
    /// Example for complete removal:
    /// ```
    /// Text("Label")
    ///     .isHidden(true, remove: true)
    /// ```
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

// 天數差
extension Date {
   func daysBetweenDate(toDate: Date) -> Int {
       let components = Calendar.current.dateComponents([.day], from: self, to: toDate)
       return components.day ?? 0
   }
}

