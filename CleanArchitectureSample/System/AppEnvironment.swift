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
        let appState = Store<AppState>(AppState())
        let session = configuredURLSession()
        let am = AuthenticationManager(appState: appState)
        let interactors = configuredInteractors(appState: appState)
        let diContainer = DIContainer(appState: appState, interactors: interactors)
        return AppEnvironment(container: diContainer)
    }
    
    private static func configuredURLSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }

    
    private static func configuredInteractors(appState: Store<AppState>
    ) -> Interactors {
        
        let postInteractor = PostInteractorImpl(appState: appState)
        let authenInteractor = AuthenticationManager(appState: appState)
        return .init(postInteractor: postInteractor, authenInteractor: authenInteractor)
    }
}
