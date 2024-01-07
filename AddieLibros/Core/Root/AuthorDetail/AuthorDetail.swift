//
//  AuthorDetail.swift
//  AddieLibros
//
//  Created by cristian regina on 6/1/24.
//

import SwiftUI

struct AuthorDetail: View {
    @Binding var isShowingAuthorDetail: Bool
    @Binding var isShowingSafariView: Bool
    @Binding var urlString: String
    @Binding var authorDetailData: AuthorDetailData
    
    var body: some View {
        LazyVStack{
            ScrollView(.vertical, showsIndicators: false){
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack(alignment: .center){
                        if let photosList = authorDetailData.photos{
                            ForEach(photosList, id:  \.self){val in
                                let coverUrl = "https://covers.openlibrary.org/b/id/\(val)-L.jpg"
                                coverRemoteImage(urlString: coverUrl)
                                    .aspectRatio(contentMode: .fit)
                                    .border(Color.brown, width: 5)
                                    .frame(width: 200, height: 230)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
                VStack(alignment: .center, spacing: 2){
                    Text("Author Name: " + (authorDetailData.name ?? "no"))
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("Author Personal Name: " + (authorDetailData.personalName ?? ""))
                        .font(.headline)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text(authorDetailData.title ?? "")
                    Text("Birthdate: " + (authorDetailData.birthDate ?? ""))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("DeathDate: " + (authorDetailData.deathDate ?? ""))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                    Text("Bio: " + (authorDetailData.bio ?? ""))
                        .font(.caption)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.black)
                        .frame(width: 300, height: 100, alignment: .center)
                    
                    Link(authorDetailData.wikipedia ?? "" , destination: URL(string: authorDetailData.wikipedia ?? "google.com")!)
                    
                    LazyVStack{
                        if let linkList = authorDetailData.links{
                            ForEach(0..<linkList.count, id: \.self){i in
                                let link = linkList[i]
                                Link(link.title ?? "" , destination: URL(string: link.url ?? "google.com")!)
                            }
                        }
                    }
                }
            }
        }
        .frame(width: 325, height: 650)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 40)
        .overlay(
            Button {
                isShowingAuthorDetail = false
            } label: {
                XDismissButton()
            }, alignment: .topTrailing)
    }
}

