//
//  HomeVM.swift
//  cats
//
//  Created by SHSEO on 2022/09/03.
//

import Foundation
import Alamofire
import Combine


class HomeVM: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var cats = [Cat]()
    
    let baseURL =
    "https://api.thecatapi.com/"
    
    
    let param: Parameters = [
        "limit":  10,
        "page": 1,
        "api_key": "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    ]
    
    
    /// get Cats Data
    func fetchCats() {
        AF.request(baseURL + "v1/images/search", method: .get, parameters: param)
            .publishDecodable(type: [Cat].self)
            .compactMap{ $0.value}
            .sink(receiveCompletion: { completion in
                print("completion fetch")
            }, receiveValue: {  receivedValue in
                print(#function)
                print(receivedValue)
                
                self.cats = receivedValue
            })
            .store(in: &cancellables)
        

    }
}
