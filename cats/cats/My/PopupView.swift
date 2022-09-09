//
//  PopupView.swift
//  cats
//
//  Created by SHSEO on 2022/09/07.
//

import SwiftUI

struct PopupView: View {
    @StateObject var viewModel: MyVM
    @Binding var isShowingPopup: Bool
    
    
    @Binding var selectType: SelectedType
    
    //let selectedID: Int
    var body: some View {
        

            VStack {
                Text("삭제 하시겠습니까?")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .frame(width: 200)
                    .foregroundColor(Color.ForegroundColor)
                HStack {
                    Button(action: {
                        if selectType == .favorites {
                            viewModel.deleteFavorites(fvId: viewModel.favorites[viewModel.selectedImageIndex].id)
                        } else {
                            viewModel.deleteMyUpload(imageID: viewModel.myUploads[viewModel.selectedImageIndex].id)
                        }
                        
                        isShowingPopup.toggle()
                    }, label: {
                        Text("삭제")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .frame(width: 100, height: 50)
                            .background(Color.red)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }).buttonStyle(PlainButtonStyle())
                    
                    
                    Button(action: {
                        isShowingPopup.toggle()
                    }, label: {
                        Text("취소")
                            .font(.system(size: 17, weight: .bold, design: .rounded))
                            .frame(width: 100, height: 50)
                            .background(Color.secondary)
                            .foregroundColor(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    })
                }
            }
            .padding()
            .background(Color.BackgroundColor)
            .cornerRadius(12)
    }
}


