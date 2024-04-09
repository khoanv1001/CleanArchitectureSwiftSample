//
//  SignIn.swift
//  demo
//
//  Created by Nguyen Viet Khoa on 29/03/2024.
//

import SwiftUI
import RxSwift
import RxCocoa
import GoogleSignIn
import GoogleSignInSwift


struct SignInView: View {
    
    @Environment(\.injected) private var container: DIContainer
    
    @Binding var userName: String
    
    @State var post: Post = Post(id: "", title: "", imageURL: "", detail: "")
    
    let disposeBag = DisposeBag()
    
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
    }
}

