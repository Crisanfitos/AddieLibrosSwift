//
//  HButton.swift
//  AddieLibros
//
//  Created by alumno on 28/11/23.
//

import SwiftUI

struct HButton: View {
    
    let title: String
    let width: CGFloat
    let bColor: Color
    let fColor: Color
    
    var body: some View {
        ZStack{
            bColor
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
                .scaledToFill()
        }
        .scaledToFit()
        .frame(width: width)
        .foregroundStyle(fColor)
        .cornerRadius(5)
    }
}

#Preview {
    HButton(title: "example", width: 100, bColor: .blue, fColor: .white)
}
