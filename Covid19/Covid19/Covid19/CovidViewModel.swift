//
//  CovidViewModel.swift
//  Covid19
//
//  Created by SHSEO on 2022/08/07.
//

import Combine
import SwiftUI
import Alamofire

class CovidViewModel: ObservableObject {
    
    private var cancellables = Set<AnyCancellable>()
    
    var baseURL = "https://api.corona-19.kr/korea/country/new/?serviceKey=LwTDV4buhRGBg75orktXyvP39CUMHlxsm"
    
    @Published var cityCovidOverviews = [CovidOverview]()
    @Published var totalCase: String = "0"
    @Published var newCase: String = "0"
    
    init() {
        fetchCovidAPI()
    }
    
    func makeCovidOverviewList(cityCovidOverview: CityCovidOverview) -> [CovidOverview]{
        return [
            cityCovidOverview.seoul,
            cityCovidOverview.busan,
            cityCovidOverview.daegu,
            cityCovidOverview.incheon,
            cityCovidOverview.gwangju,
            cityCovidOverview.daejeon,
            cityCovidOverview.ulsan,
            cityCovidOverview.sejong,
            cityCovidOverview.gyeonggi,
            cityCovidOverview.chungbuk,
            cityCovidOverview.chungnam,
            cityCovidOverview.gyeongbuk,
            cityCovidOverview.gyeongnam,
            cityCovidOverview.jeju
        ]
    }
    
    func fetchCovidAPI() {
        AF.request(baseURL)
            .publishDecodable(type: CityCovidOverview.self)
            .compactMap{ $0.value}
            .sink(receiveCompletion: { completion in
                print("데이트스트림 완료")
            }, receiveValue: { [self] (receivedValue: CityCovidOverview) in
                print("받은 값: \(receivedValue)")
                cityCovidOverviews = self.makeCovidOverviewList(cityCovidOverview: receivedValue)
                totalCase = receivedValue.korea.totalCase
                newCase = receivedValue.korea.newCase
                print(cityCovidOverviews)
            })
            .store(in: &cancellables)
    }
}
