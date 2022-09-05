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
    
    
}

struct FvImage: Codable {
    var id: String
    var url: URL
}
