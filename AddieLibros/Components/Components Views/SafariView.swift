//
//  SafariView.swift
//  AddieLibros
//
//  Created by alumno on 28/11/23.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    typealias UIViewControllerType = SFSafariViewController
    
    let url: URL
    
    /*func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> some SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }*/
}
