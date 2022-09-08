//
//  ImagePickerView.swift
//  cats
//
//  Created by SHSEO on 2022/09/08.
//

import SwiftUI

struct ImagePickerView: View {
    @State var selectedImage: UIImage
    var body: some View {
        VStack{
            Image(uiImage: selectedImage)
            
        }
    }
}

//struct ImagePickerView_Previews: PreviewProvider {
//    static var previews: some View {
//            ImagePickerView()
//    }
//}
