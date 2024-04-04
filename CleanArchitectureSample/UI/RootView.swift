//
//  RootView.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI

struct RootView: View {
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    
    var body: some View {
        if container.appState.value.userData.isLoggedIn {
            ContentView(container: container)
        } else {
            SignInView()
                .inject(container)
        }
    }
}

