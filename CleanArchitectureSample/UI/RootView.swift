//
//  RootView.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI
import Combine

struct RootView: View {
    private let container: DIContainer
    
    @State private var isLoggin: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    private var userBinding: Binding<Bool> {
        $isLoggin.dispatched(to: container.appState, \.userData.isLoggedIn)
    }

    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        Group {
            if isLoggin {
                ContentView(container: container)
            } else {
                SignInView()
                    .inject(container)
            }
        }
        .onReceive(loginStatusUpdate) {isLoggin = $0}
        VStack {
            Button("Debug") {
                print("debug: \(isLoggin)")
                print("debug1: \(container.appState.value.userData.isLoggedIn)")
            }
            Button("logout") {
                container.interactors.authenInteractor!.signOut()
            }
        }
        
    }
}

extension RootView {
    fileprivate var loginStatusUpdate: AnyPublisher<Bool, Never> {
        container.appState.updates(for: \.userData.isLoggedIn)
    }
}

