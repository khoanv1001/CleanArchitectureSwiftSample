//
//  SignIn.swift
//  demo
//
//  Created by Nguyen Viet Khoa on 29/03/2024.
//

import SwiftUI
import GoogleSignIn
import GoogleSignInSwift


struct SignInView: View {
    
    @Environment(\.injected) private var container: DIContainer

    var body: some View {
        VStack {
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        container.interactors.authenInteractor!.signIn()
                    }
                }
            }
            Button("Sign Out") {
                container.interactors.authenInteractor!.signOut()
            }
            .padding()
        }
    }
}

