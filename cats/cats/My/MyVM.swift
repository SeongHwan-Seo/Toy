//
//  MyVM.swift
//  cats
//
//  Created by SHSEO on 2022/09/05.
//

import Foundation
import Alamofire
import Combine

class MyVM: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var favorites = [Favorites]()
    @Published var selectedImage = [Favorites]()
    @Published var selectedImageIndex = 0
    
    
    let baseURL =
    "https://api.thecatapi.com/"
    let APIKey = "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    
    
    struct Param: Encodable {
        var sub_id: String
        var api_key: String = "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    }
    /// 즐겨찾기 들고오기
    /// - Parameters:
    ///   - limit: 가져올 개수
    ///   - page: 가져올 페이지
    func fetchFavorites( sub_id: String ) {
        let param = Param( sub_id: sub_id)
        AF.request(baseURL + "v1/favourites", method: .get, parameters: param)
            .publishDecodable(type: [Favorites].self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in

                print("completion fetch")
            }, receiveValue: {  receivedValue in
                print(#function)
                print(receivedValue)
                
                self.favorites = receivedValue

            })
            .store(in: &cancellables)
        

    }
}
