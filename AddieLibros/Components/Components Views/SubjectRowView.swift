//
//  SubjectRowView.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import SwiftUI

struct SubjectRowView: View {
    
    var subject: Subject
    @StateObject var viewModel = MainBooksViewModel()
    
    var body: some View {
        VStack{
            NavigationLink(destination: MainSubjectDetail(subjectName: subject.name)){
                Text(subject.name)
            }
            Divider()
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{
                        ForEach(subject.works){ book in
                            NavigationLink(destination: BookDetail(book: book)){
                                    BookSample(book: book)
                                }
                        }
                    }
            }
        }
        .frame(height: 200)
    }
}

#Preview {
    SubjectRowView(subject: MockData.subject)
}
