//
//  CovidDetailView.swift
//  Covid19
//
//  Created by SHSEO on 2022/08/06.
//

import SwiftUI

struct CovidDetailView: View {
    var covidOverview: CovidOverview
    
    init(_ covidOverview: CovidOverview) {
        self.covidOverview = covidOverview
    }
    
    var body: some View {
        
            
        ZStack {
                Color.background
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    ZStack {
                        Color.background
                        
                        VStack {
                            
                            Group {
                                HStack {
                                    Text("신규확진자")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.newCase)명")
                                } //HStack
                                
                                HStack {
                                    Text("확진자")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.totalCase)명")
                                } //HStack
                                
                                HStack {
                                    Text("완치자")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.recovered)명")
                                } //HStack
                                
                                HStack {
                                    Text("사망자")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.death)명")
                                } //HStack
                                
                                
                                HStack {
                                    Text("발생률")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.percentage)명")
                                } //HStack
                                
                                HStack {
                                    Text("해외유입 신규확진자")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.newFcase)명")
                                } //HStack
                                
                                HStack {
                                    Text("지역발생 신규확진자")
                                    
                                    Spacer()
                                    
                                    Text("\(covidOverview.newCcase)명")
                                } //HStack
                            }
                            .padding()
                            
                            Spacer()
                        } // VStack
                        
                        .background(.white)
                        .cornerRadius(20)
                        
                        .modifier(CardModifier())
                        .padding()
                    }// ZStack
                    
                }// VStack
                
            } //ZStack
            
            .navigationTitle("\(covidOverview.countryName)")
            .navigationBarTitleDisplayMode(.inline)
            
        
        
    }
}

struct CovidDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CovidDetailView(CovidOverview(countryName: "부산", newCase: "100", totalCase: "100", recovered: "0", death: "100", percentage: "1000", newCcase: "10", newFcase: "10"))
    }
}
