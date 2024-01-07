//
//  BookSample.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import SwiftUI

struct BookSample: View {
    
    let book: Book
    
    var body: some View {
            VStack(alignment: .center, spacing: 5) {
                coverRemoteImage(urlString: book.cover_url)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 90)
                    .cornerRadius(8)
                Text("\(book.title)")
                    .font(.caption)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
            }
            .frame(width: 140, height: 130)
            .background(Color.white)
            .cornerRadius(20)
            .frame(width: 160, height: 160)
            .background(Color.brown)
            .cornerRadius(20)
        
    }
}
