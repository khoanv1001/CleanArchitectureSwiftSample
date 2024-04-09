//
//  AppEnvironment.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import Foundation
import Combine

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    
    static func bootstrap() -> AppEnvironment {
        let appState = Store<AppState>(value: AppState())
        let postRepo = PostRepositoryImpl()
        let interactors = configuredInteractors(appState: appState, repo: postRepo)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return AppEnvironment(container: diContainer)
    }

    private static func configuredInteractors(appState: Store<AppState>, repo: PostRepository
    ) -> Interactors {
        
        let postInteractor = PostInteractorImpl(appState: appState, repository: repo)
        let authenInteractor = AuthenticationManager(appState: appState)
        return .init(postInteractor: postInteractor, authenInteractor: authenInteractor)
    }
}
