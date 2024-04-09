//
//  PostInteractors.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import RxSwift
import RxCocoa
import Combine
import SwiftUI

protocol PostInteractor {
    func getPosts() -> Observable<Post>
}

struct PostInteractorImpl: PostInteractor {
    let appState: Store<AppState>
    
    let postRepository: PostRepository
    
    init(appState: Store<AppState>, repository: PostRepository) {
        self.appState = appState
        self.postRepository = repository
    }
    
    func getPosts() -> Observable<Post> {
        return self.postRepository.getPost(id: "1")
    }
}

struct StubPostInteractorImpl: PostInteractor {
    func getPosts() -> Observable<Post> {
        let subject = PublishSubject<Post>()
        return subject.asObservable()
    }
}
