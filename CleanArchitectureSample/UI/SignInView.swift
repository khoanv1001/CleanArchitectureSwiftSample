//
//  SignIn.swift
//  demo
//
//  Created by Nguyen Viet Khoa on 29/03/2024.
//

import SwiftUI
import Combine
import GoogleSignIn
import GoogleSignInSwift


struct SignInView: View {
    
    @Environment(\.injected) private var container: DIContainer
    
    @State private var userData: String = ""
    private var userBinding: Binding<String> {
        $userData.dispatched(to: container.appState, \.userData.givenName)
    }

    var body: some View {
        VStack {
            GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .dark, style: .wide, state: .normal)) {
                Task {
                    do {
                        container.interactors.authenInteractor!.signIn()
                    }
                }
            }
        }
        .onReceive(nameUpdate) {userData = $0}
    }
}


extension SignInView {
    fileprivate var nameUpdate: AnyPublisher<String, Never> {
        container.appState.updates(for: \.userData.givenName)
    }
}

