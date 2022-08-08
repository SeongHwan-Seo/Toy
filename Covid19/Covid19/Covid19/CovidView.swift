//
//  CovidView.swift
//  Covid19
//
//  Created by SHSEO on 2022/08/06.
//

import SwiftUI
import SwiftPieChart


struct CovidView: View {
    let colors: [Color] = [.green, .red, .indigo, .orange, .blue, .gray, .purple, .mint, .cyan, .brown, .pink, .primary]
    
    @StateObject var viewModel = CovidViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        
                        VStack {
                            Text("국내 확진자")
                                .font(.title2)
                            
                            Text("\(viewModel.totalCase)명")
                                .fontWeight(.bold)
                        } //VStack
                        
                        Spacer()
                        
                        VStack {
                            Text("신규 확진자")
                                .font(.title2)
                            
                            Text("\(viewModel.newCase)명")
                                .fontWeight(.bold)
                        } //VStack
                        
                        Spacer()
                        
                    } //HStack
                    .padding()
                    
                    
                    VStack {
                        CovidListView(viewModel: viewModel)
                        
                    } //VStack
                    
                }
                
            }//ZStack
            
            .navigationBarHidden(true)
        }// NavigationView
        
        
        
    }
}

struct CityView : View {
    let viewModel: CovidViewModel
    var body: some View {
        VStack {
            
            //                List(viewModel.cityCovidOverviews) { CityCovidOverview in
            //                    CovidListView(viewModel: viewModel)
            //                }
            
            //CovidListView(viewModel: viewModel)
            
            
            
        }
    }
}

struct CovidView_Previews: PreviewProvider {
    static var previews: some View {
        CovidView()
    }
}
