//
//  MyVM.swift
//  cats
//
//  Created by SHSEO on 2022/09/05.
//

import Foundation
import Alamofire
import Combine
import UIKit

class MyVM: ObservableObject {
    private var cancellables = Set<AnyCancellable>()
    
    @Published var favorites = [Favorites]()
    @Published var myUploads = [MyUpload]()
    @Published var selectedImage = [Favorites]()
    @Published var selectedImageIndex = 0
    @Published var isShowingSheet = false
    @Published var isUpload = false
    
    
    let baseURL =
    "https://api.thecatapi.com/"
    let APIKey = "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    
    
    struct Param: Encodable {
        var sub_id: String
        var api_key: String = "live_0o7NzvNZWpj2wNOEB7E9bBcATToLEoyxiTIfUGFsgnKtF3AQ78nR0RAc4ERvqMQ6"
    }
    
    struct uploadParam: Encodable {
        var sub_id: String
        var limit: Int = 10
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

                print("fetchFavorites Completion")
            }, receiveValue: {  receivedValue in
                print(#function)
                print(receivedValue)
                
                self.favorites = receivedValue

            })
            .store(in: &cancellables)
        
    }
    
    
    /// 즐겨찾기 삭제
    /// - Parameter fvId: 즐겨찾기 ID
    func deleteFavorites(fvId: Int) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "x-api-key": "\(APIKey)",
        ]
        
        
        AF.request(baseURL + "v1/favourites/\(fvId)", method: .delete,  encoding: JSONEncoding.default, headers: header)
            .publishData()
            .sink(receiveCompletion: { completion in
                self.favorites.remove(at: self.selectedImageIndex)
            }, receiveValue: { _ in
                
            })
            .store(in: &cancellables)
    }
    
    
    /// 이미지 업로드
    /// - Parameters:
    ///   - selectedImage: 선택한 이미지
    ///   - subID: 유저아이디
    func uploadMyImage(selectedImage: UIImage, subID: String) {
        
        self.isUpload = true
        
        let header : HTTPHeaders = [
            "Content-Type": "multipart/form-data",
            "x-api-key": "\(APIKey)",
        ]
        
        let data = selectedImage.jpegData(compressionQuality: 0.1)
        
        AF.upload(multipartFormData: { multipart in
            
            multipart.append(subID.data(using: .utf8)!, withName: "sub_id")
            
            multipart.append(data!, withName: "file", fileName: "\(String(describing: data)).jpg" ,mimeType: "image/jpeg")
            
            
        }, to: baseURL + "v1/images/upload", headers: header).uploadProgress(queue: .main, closure: { progress in
            
        }).response(completionHandler: { data in
            switch data.result {
            case .success(_):
                do {
                    self.isUpload = false
                    self.isShowingSheet = false
                    print("upload success")
                }
            case .failure(let error):
                self.isUpload = false
                print("upload fail: \(error.localizedDescription)")
            }
            
        })
    }
    
    
    /// 나의 업로드 사진 불러오기
    /// - Parameter sub_id: 유저아이디
    func fetchMyUpload(sub_id: String) {
        let param = uploadParam( sub_id: sub_id)
        AF.request(baseURL + "v1/images", method: .get, parameters: param)
            .publishDecodable(type: [MyUpload].self)
            .compactMap{ $0.value }
            .sink(receiveCompletion: { completion in

                print("fetchMyUpload Completion")
            }, receiveValue: {  receivedValue in
                print(#function)
                print(receivedValue)
                
                self.myUploads = receivedValue

            })
            .store(in: &cancellables)
    }
    
    func deleteMyUpload(imageID: String) {
        let header : HTTPHeaders = [
            "Content-Type": "application/json",
            "x-api-key": "\(APIKey)",
        ]
        
        
        AF.request(baseURL + "v1/images/\(imageID)", method: .delete,  encoding: JSONEncoding.default, headers: header)
            .publishData()
            .sink(receiveCompletion: { completion in
                self.myUploads.remove(at: self.selectedImageIndex)
            }, receiveValue: { _ in
                
            })
            .store(in: &cancellables)
    }
}
