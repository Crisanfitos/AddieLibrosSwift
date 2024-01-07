//
//  AdaImage.swift
//  AdaLibros
//
//  Created by cristian regina on 1/11/23.
//

import SwiftUI

struct AdaImage: View {
    var body: some View {
        Image("AddieLibros")
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 170)
            .cornerRadius(15)
            .padding(.vertical, 32)
    }
}

#Preview {
    AdaImage()
}
