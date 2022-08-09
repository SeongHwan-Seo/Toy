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
        
        ScrollView {
            ForEach(0..<viewModel.cityCovidOverviews.count, id: \.self) { index in
                
                NavigationLink(destination: {
                    CovidDetailView(viewModel.cityCovidOverviews[index])
                }, label: {
                    ZStack {
                        Color.white
                            .cornerRadius(20)
                        
                        
                        HStack {
                            
                            VStack(alignment: .leading) {
                                Text("\(viewModel.cityCovidOverviews[index].countryName)")
                                    .font(.title2)
                                
                                
                            } //VStack
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("\(viewModel.cityCovidOverviews[index].totalCase)명")
                                    .font(.title3)
                                HStack(spacing: 0) {
                                    Image(systemName: "arrowtriangle.up.fill")
                                        .foregroundColor(.red)
                                    Text("\(viewModel.cityCovidOverviews[index].newCase)명")
                                }
                                
                            } //VStack
                        } // HStack
                        .padding()
                        .modifier(CardModifier())
                        
                    }// ZStack
                    .padding(.horizontal)
                    .foregroundColor(.black)
                })
                
                
                
                
            }// ForEach
        }// ScrollView
        
        
    }
}



