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
    let userId = "shseo"
    
    var body: some View {
        
        ScrollView {
            if viewModel.isRefresh {
                VStack {
                    ProgressView()
                }
            }
            
            LazyVStack(pinnedViews: .sectionHeaders) {
                Section(header: Header()){
                    ForEach(0..<viewModel.cats.count, id: \.self) { index in
                        ZStack(alignment: .topTrailing) {
                            ListItem(catURL: viewModel.cats[index].url)
                                .onAppear {
                                    if index == viewModel.cats.count - 1 {
                                        print("loadMore")
                                        pageNum += 1
                                        viewModel.fetchCats(limit: 9, page: pageNum)
                                    }
                                }
                                .onTapGesture(count: 2) {
                                    print("double tapped!")
                                    print(index)
                                }
//                            VStack {
//                                Button(action: {
//                                    viewModel.setFavoriteImage(imageId: viewModel.cats[index].id, subId: userId)
//                                }, label: {
//                                    Image(systemName: "star")
//                                        .resizable()
//                                        .frame(width: 30, height: 30)
//                                })
//                            }
//                            .padding(.horizontal, 14)
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
            print(#function)
            viewModel.fetchCats(limit: 9, page: pageNum)
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
        VStack {
            Spacer()
            Text("Cats")
                .fontWeight(.bold)
            Spacer()
            Divider()
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 56)
        .background(Rectangle().foregroundColor(.white))
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
