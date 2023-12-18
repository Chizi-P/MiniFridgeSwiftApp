//
//  UpdatePostIt.swift
//  MiniFridge
//
//  Created by 🐽 on 28/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI
import Combine

class UpdatePostIt : ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    
    @Published var postIts: [PostItData] {
        didSet {
            didChange.send()
        }
    }
    
    init(postIts: [PostItData] = []) {
        self.postIts = postIts
    }
}
