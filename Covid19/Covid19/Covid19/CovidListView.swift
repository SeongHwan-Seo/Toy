//
//  CovidListView.swift
//  Covid19
//
//  Created by SHSEO on 2022/08/06.
//

import SwiftUI

struct CovidListView: View {
    @StateObject var viewModel: CovidViewModel
    
    var body: some View {
        //if viewModel.cityCovidOverviews.count != 0 {
            ForEach(0..<viewModel.cityCovidOverviews.count, id: \.self) { index in
                Text("\(viewModel.cityCovidOverviews[index].countryName)")
            }
        //}
        
        
        
    }
}


