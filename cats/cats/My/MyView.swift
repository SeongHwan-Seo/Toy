//
//  MyView.swift
//  cats
//
//  Created by SHSEO on 2022/09/03.
//

import SwiftUI
import PhotosUI
import Kingfisher

struct MyView: View {
    @StateObject var viewModel = MyVM()
    @State var pageNum = 1
    @State var isShowingPopup = false
    @State var isShowingPicker = false
    var config: PHPickerConfiguration  {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images //videos, livePhotos...
        config.selectionLimit = 1 //0 => any, set 1-2-3 for har limit
        return config
    }
    @State var image: UIImage? = nil
    let userId = "shseo"
    @State var selectType: SelectedType = .favorites
    
    
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
                                selectType = .favorites
                                isShowingPopup.toggle()
                            }, label: {
                                
                                ZStack {
                                    Color.BackgroundColor
                                    
                                    MyItem(catURL: viewModel.favorites[index].image.url)
                                    
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
                        ForEach(0..<viewModel.myUploads.count, id: \.self) {
                            index in
                            ZStack {
                                Color.BackgroundColor
                                
                                MyItem(catURL: viewModel.myUploads[index].url)
                                    .onTapGesture {
                                        viewModel.selectedImageIndex = index
                                        selectType = .upload
                                        isShowingPopup.toggle()
                                    }
                                
                                
                                
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
                            PopupView(viewModel: viewModel, isShowingPopup: $isShowingPopup, selectType: $selectType)
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
                viewModel.fetchMyUpload(sub_id: userId)
            }
            .navigationTitle("My")
            .navigationBarItems(trailing: Button(action: {
                viewModel.isShowingSheet.toggle()
            }, label: {
                Image(systemName: "plus")
                    .foregroundColor(.ForegroundColor)
            }))
        }
        .sheet(isPresented: $viewModel.isShowingSheet, onDismiss: { viewModel.fetchMyUpload(sub_id: userId)}) {
            VStack {
                
                Image(uiImage: self.image ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 300)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding()
                
                HStack {
                    Button(action: {
                        isShowingPicker.toggle()
                    }, label: {
                        Text("사진선택")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .frame(width: 100, height: 50)
                            .background(Color.secondary)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                    .buttonStyle(PlainButtonStyle())
                    Button(action: {
                        if image != nil {
                            viewModel.uploadMyImage(selectedImage: image ?? UIImage(), subID: "shseo")
                        }
                        
                    }, label: {
                        if viewModel.isUpload {
                            ProgressView()
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .frame(width: 100, height: 50)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        } else {
                            Text("업로드")
                                .font(.system(size: 17, weight: .bold, design: .rounded))
                                .frame(width: 100, height: 50)
                                .background(Color.blue)
                                .foregroundColor(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        
                    })
                    .buttonStyle(PlainButtonStyle())
                }
                Spacer()
            }
            .overlay(
                ZStack {
                    if isShowingPicker {
                        PhotoPicker(configuration: self.config,
                                    pickerResult: self.$image,
                                    isShowingPicker: $isShowingPicker)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        
                    }
                    
                }
                
            )
            
        }
        
        
        
    }
    
}


struct MyItem: View {
    
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
