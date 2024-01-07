//
//  RemoteImage.swift
//  AddieLibros
//
//  Created by cristian regina on 23/11/23.
//

import SwiftUI

final class ImageLoader: ObservableObject {
    
    @Published var image: Image? = nil
    func load(urlString: String){
        Task{
            do{
                let uiImage = try await NetworkManager.shared.downloadImage(fromURLString: urlString)
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
            } catch {
                print("Error while downloading image: \(urlString)")
            }
        }
    }
}

struct RemoteImage: View {
    
    var image: Image?
    
    var body: some View {
        image?.resizable() ?? Image("images").resizable()
    }
}

struct coverRemoteImage: View {
    @StateObject var imageLoader = ImageLoader()
    let urlString: String
    
    var body: some View{
        RemoteImage(image: imageLoader.image)
            .onAppear { imageLoader.load(urlString: urlString)}
    }
}

