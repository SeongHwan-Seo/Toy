//
//  Cat.swift
//  cats
//
//  Created by SHSEO on 2022/09/03.
//

import Foundation
import SwiftUI

struct Cat: Codable {
    
    var id: String
    var url: URL
    var width: Int
    var height: Int
    
}

struct FavoriteParam: Codable {
    var image_id: String
    var sub_id: String
    
    func serialize() -> [String : Any] {
        return [
            "image_id" : self.image_id,
            "sub_id" : self.sub_id,
            
       ]
    }
}




//[{
//"id":"ebv",
//"url":"https://cdn2.thecatapi.com/images/ebv.jpg",
//"width":176,"height":540,
//"breeds":[],
//"favourite":{}
//}]

//[{
//"id":100038507,
//"image_id":"E8dL1Pqpz",
//"sub_id":null,
//"created_at":"2022-07-10T12:24:39.000Z",
//"image":{
//    "id":"E8dL1Pqpz",
//    "url":"https://cdn2.thecatapi.com/images/E8dL1Pqpz.jpg"
//    }
//},
//{ ... }]
