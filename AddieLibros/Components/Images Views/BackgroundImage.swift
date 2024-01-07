//
//  BackgroundImage.swift
//  AdaLibros
//
//  Created by cristian regina on 1/11/23.
//

import SwiftUI

struct BackgroundImage: View {
    var body: some View{
            Image("Background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
    }
}

#Preview {
    BackgroundImage()
}
