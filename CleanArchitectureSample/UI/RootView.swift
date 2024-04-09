//
//  RootView.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI
import RxSwift
import RxCocoa

struct RootView: View {
    private let container: DIContainer
    private var disposeBag = DisposeBag()
    
    @State private var userData: AppState.UserData = AppState.UserData()
    
    @State private var postData: AppState.PostData = AppState.PostData(step: AddPostStep.title, title: "", imageURL: [], detail: "")
    
    init(container: DIContainer) {
        self.container = container
    }
    
    private func observeAppState() {
        container.appState
            .updates(for: \.userData)
            .map { $0 } // Map the Bool value
            .subscribe(onNext: { user in
                self.userData = user
            })
            .disposed(by: disposeBag)
        
        container.appState
            .updates(for: \.postData)
            .map { $0 } // Map the Bool value
            .subscribe(onNext: { post in
                self.postData = post
            })
            .disposed(by: disposeBag)
    }
    
    var body: some View {
        Group {
            if userData.isLoggedIn {
                ContentView(postData: $postData)
                    .inject(container)
            } else {
                SignInView(userName: $userData.givenName)
                    .inject(container)
            }
        }
        .onAppear {
            observeAppState()
        }
        VStack {
//            Button("Debug") {
//                print("debug: \(userData.isLoggedIn)")
//            }
            Button("logout") {
                container.interactors.authenInteractor!.signOut()
            }
        }
        
    }
}
