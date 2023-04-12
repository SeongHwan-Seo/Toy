//
//  HomeVM.swift
//  Toy-OpenChat
//
//  Created by SHSEO on 2023/04/12.
//

import Foundation

class HomeVM {
    
    func setName(name: String) {
        UserDefaults.standard.set(name, forKey: "name")
    }
}
