//
//  CardModifier.swift
//  Covid19
//
//  Created by SHSEO on 2022/08/08.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 1, x: 1, y: 1)
                    .opacity(0.3)
            )
    }
}
