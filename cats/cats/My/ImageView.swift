//
//  ImageView.swift
//  cats
//
//  Created by SHSEO on 2022/09/06.
//

import SwiftUI
import Kingfisher
import CoreAudio

struct ImageView: View {
    @StateObject var viewModel: MyVM
    let index: Int
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
//            TabView(selection: $viewModel.favorites[index].id, content: {
//                
//            })
            
            KFImage(viewModel.favorites[index].image.url)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
