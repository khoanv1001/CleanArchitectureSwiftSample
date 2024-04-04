//
//  PostInteractors.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import Combine
import SwiftUI

protocol PostInteractor {
    func getPosts() -> AnyPublisher<Void, Error>
}

struct PostInteractorImpl: PostInteractor {
    let appState: Store<AppState>
    
    init(appState: Store<AppState>) {
        self.appState = appState
    }
    
    func getPosts() -> AnyPublisher<Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
            
        // Simulate some behavior
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Emit a completion event after 1 second
            subject.send(completion: .finished)
        }
        
        // Return the subject as AnyPublisher
        return subject.eraseToAnyPublisher()
    }
    
}

struct StubPostInteractorImpl: PostInteractor {
    func getPosts() -> AnyPublisher<Void, Error> {
        let subject = PassthroughSubject<Void, Error>()
            
        // Simulate some behavior
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            // Emit a completion event after 1 second
            subject.send(completion: .finished)
        }
        
        // Return the subject as AnyPublisher
        return subject.eraseToAnyPublisher()
    }
}
