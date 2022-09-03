//
//  CatsView.swift
//  cats
//
//  Created by SHSEO on 2022/09/03.
//

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var viewModel = HomeVM()
    
    var body: some View {
        VStack {
            Text("CatsView")
        }
        .onAppear {
            viewModel.fetchCats()
        }              
    }
}

struct ListItem: View {
    var body: some View {
        VStack {
            KFImage("")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .frame(height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(.black)
                            .opacity(0.5)
        }
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
