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
    @State var pageNum = 1
    @State var isHeart = false
    @State var selectIndex = 0
    let userId = "shseo"
    
    var body: some View {
        
        ScrollView {
            if viewModel.isRefresh {
                VStack {
                    ProgressView()
                }
                .background(Color.BackgroundColor)
            }
            
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section(header: Header()){
                    
                    ForEach(0..<viewModel.cats.count, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            Color.BackgroundColor
                            
                            ListItem(catURL: viewModel.cats[index].url)
                                .overlay(
                                    ZStack {
                                        if isHeart && index == selectIndex{
                                            Color.clear
                                            
                                            Image(systemName: "heart.fill")
                                                .resizable()
                                                .frame(width: 50, height: 50)
                                                .foregroundColor(.red)
                                        }
                                        
                                    }
                                )
                                .onAppear {
                                    if index == viewModel.cats.count - 1 {
                                        print("loadMore")
                                        pageNum += 1
                                        viewModel.fetchCats(limit: 9, page: pageNum)
                                    }
                                }
                                .onTapGesture(count: 2) {
                                    viewModel.setFavoriteImage(imageId: viewModel.cats[index].id, subId: userId)
                                    selectIndex = index
                                    withAnimation(.linear) {
                                        isHeart = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                                            isHeart = false
                                        }
                                    }
                                }
                        }
                        
                    }
                }
            }
            .background(GeometryReader {
                // detect Pull-to-refresh
                Color.clear.preference(key: ViewOffsetKey.self, value: -$0.frame(in: .global).origin.y)
            })
            .onPreferenceChange(ViewOffsetKey.self) {
                if $0 < -80 && !viewModel.isRefresh {
                    pageNum = 1
                    viewModel.isRefresh = true
                    viewModel.cats = [Cat]()
                    viewModel.fetchCats(limit: 9, page: pageNum)
                }
            }
            
            
        }
        
        .clipped()
        
        .onAppear {
            if viewModel.cats.count == 0 {
                viewModel.fetchCats(limit: 9, page: pageNum)
            }
            
        }
        
    }
}

public struct ViewOffsetKey: PreferenceKey {
    public typealias Value = CGFloat
    public static var defaultValue = CGFloat.zero
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

struct Header: View {
    var body: some View {
        
        VStack(alignment: .leading) {
            Spacer()
            Text("Home")
                .font(.system(size: 30, weight: .bold, design: .default))
                .padding(.horizontal)
            Spacer()
            Divider()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Color.BackgroundColor)
        
        
    }
}

struct ListItem: View {
    
    var catURL: URL
    
    var body: some View {
        
        VStack {
            KFImage(catURL)
                .placeholder{
                    ProgressView()
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            
            
        }
        .padding(.horizontal, 14)
        
    }
}

struct CatsView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
