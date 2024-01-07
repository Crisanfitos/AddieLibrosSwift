//
//  AddieLibrosApp.swift
//  AddieLibros
//
//  Created by cristian regina on 17/11/23.
//

import SwiftUI
import Firebase

@main
struct AddieLibrosApp: App {
    
    @StateObject var viewModel = AuthViewModel()
    
    init(){
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(viewModel)
        }
    }
}
