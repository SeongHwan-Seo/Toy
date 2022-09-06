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
    @Published var isRefresh = false
    
    let baseURL =
    "https://api.thecatapi.com/"
    let APIKey = "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    
    struct Param: Encodable {
        var limit: Int
        var page: Int
        var api_key: String = "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    }
    
    
    /// get Cats Data
    func fetchCats(limit: Int, page: Int ) {
        let param = Param(limit: limit, page: page)
        AF.request(baseURL + "v1/images/search", method: .get, parameters: param)
            .publishDecodable(type: [Cat].self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in
                
                print("completion fetch")
            }, receiveValue: {  receivedValue in
                
                
                self.cats += receivedValue
                self.isRefresh = false
            })
            .store(in: &cancellables)
    }
    
    
    func setFavoriteImage(imageId: String, subId: String ) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "x-api-key": "\(APIKey)",
        ]
        
        
        AF.request(baseURL + "v1/favourites", method: .post, parameters: FavoriteParam(image_id: imageId, sub_id: subId).serialize(), encoding: JSONEncoding.default, headers: header)
            .publishData()
            .sink(receiveCompletion: { completion in
                
            }, receiveValue: { receivedValue in
                if receivedValue.response?.statusCode == 200 {
                    print(receivedValue.data!)
                } else {
                    print("error")
                }
            })
            .store(in: &cancellables)
    }
}
