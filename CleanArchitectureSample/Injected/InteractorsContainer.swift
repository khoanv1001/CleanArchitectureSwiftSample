//
//  InteractorsContainer.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//


struct Interactors {
    let postInteractor: PostInteractor
    let authenInteractor: AuthenticationManager?

    init(postInteractor: PostInteractor, authenInteractor: AuthenticationManager? = nil) {
        self.postInteractor = postInteractor
        self.authenInteractor = authenInteractor
    }
    
    static var stub: Self {
        .init(postInteractor: StubPostInteractorImpl())
    }
}
