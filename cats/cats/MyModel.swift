//
//  MyModel.swift
//  cats
//
//  Created by SHSEO on 2022/09/05.
//

import Foundation
import SwiftUI


struct Favorites: Codable {
    
    var id: Int
    var image: FvImage
    
    init(id :Int, image: FvImage) {
        self.id = id
        self.image = image
    }
}

struct MyUpload: Codable {
    var id: String
    var url: URL
    var sub_id: String
}


struct FvImage: Codable {
    var id: String
    var url: URL
}

enum SelectedType {
    case favorites
    case upload
}
