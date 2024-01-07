//
//  SplashCreenView.swift
//  AdaLibros
//
//  Created by cristian regina on 1/11/23.
//

import SwiftUI

struct SplashScreenView: View {
    
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var splashScreenActive = false
    @State private var size = 1.5
    @State private var opacity = 0.5
    
    var body: some View {
        if splashScreenActive {
            if viewModel.userSession != nil {
                HomeTabView()
            }else {
                LoginView()
            }
        }else{
            VStack{
                ZStack{
                    BackgroundImage()
                    AdaImage()
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.2)){
                        self.size = 1.0
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.splashScreenActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}

