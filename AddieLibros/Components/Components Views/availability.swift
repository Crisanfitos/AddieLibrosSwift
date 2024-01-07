//
//  availability.swift
//  AddieLibros
//
//  Created by alumno on 28/11/23.
//

import SwiftUI

struct availability: View {
    
    let available: Bool
    let size: CGFloat

    var body: some View {
        ZStack{
            Circle()
                .foregroundStyle(available ? .green : .red)
                .scaledToFill()
            Image(systemName: available ? "checkmark" : "xmark")
                .resizable()
                .frame(width: size-(0.225*size), height: size-(0.225*size))
                .foregroundStyle(Color.black)
        }
        .frame(width: size, height: size)
        
    }
}

#Preview {
    availability(available: false, size: 15)
}
