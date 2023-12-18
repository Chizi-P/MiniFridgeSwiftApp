//
//  PhotoViewer.swift
//  MiniFridge
//
//  Created by 🐽 on 7/10/2020.
//  Copyright © 2020 chizi. All rights reserved.
//

import SwiftUI

// 照片查看器

struct PhotoViewer: View {
    let image : UIImage = UIImage()
    
    var body: some View {
        Image(uiImage: self.image)
            .resizable()
            .scaledToFit()
    }
}

struct PhotoViewer_Previews: PreviewProvider {
    static var previews: some View {
        PhotoViewer()
    }
}
