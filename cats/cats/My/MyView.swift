//
//  MyView.swift
//  cats
//
//  Created by SHSEO on 2022/09/03.
//

import SwiftUI
import Kingfisher

struct MyView: View {
    @StateObject var viewModel = MyVM()
    @State var pageNum = 1
    @State var isShowingPopup = false
    let userId = "shseo"
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Favorites")
                        .font(.title2)
                    Spacer()
                }
                .padding()
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<viewModel.favorites.count, id: \.self) {
                            index in
                            Button(action: {
                                viewModel.selectedImage = viewModel.favorites
                                viewModel.selectedImageIndex = index
                                isShowingPopup.toggle()
                            }, label: {
                                //                                NavigationLink(destination: ImageView(viewModel: viewModel, index: index), label: {
                                //
                                //                                })
                                ZStack {
                                    Color.BackgroundColor
                                    
                                    FavoritesItem(catURL: viewModel.favorites[index].image.url)
                                    
                                }
                                
                            })
                            
                            
                        }
                        
                    }
                    
                }
                .frame(maxHeight: 150)
                
                HStack {
                    Text("Upload")
                        .font(.title2)
                    Spacer()
                }
                .padding()
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        ForEach(0..<viewModel.favorites.count, id: \.self) {
                            index in
                            ZStack {
                                Color.BackgroundColor
                                
                                FavoritesItem(catURL: viewModel.favorites[index].image.url)
                                
                                
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }
                .frame(maxHeight: 150)
                
                Spacer()
            }
            .overlay(
                ZStack{
                    if isShowingPopup {
                        GeometryReader { geometry in
                            PopupView(viewModel: viewModel, isShowingPopup: $isShowingPopup)
                                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }
                        .background(
                            Color.black.opacity(0.65)
                                .edgesIgnoringSafeArea(.all)
                        )
                        
                    }
                }
            )
            
            .onAppear{
                viewModel.fetchFavorites(sub_id: userId)
            }
            .navigationTitle("My")
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.ForegroundColor)
            }))
        }
        
        
    }
    
}


struct FavoritesItem: View {
    
    var catURL: URL
    
    var body: some View {
        
        HStack {
            KFImage(catURL)
                .placeholder{
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
        }
        .padding(.horizontal, 14)
        
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        MyView()
    }
}
