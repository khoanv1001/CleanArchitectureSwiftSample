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
//            Text(userName)
//                .padding()
            Button(action: {
                container.interactors.postInteractor.getPosts()
                    .subscribe(onNext: { post in
                        print("\(post)")
                        self.post = post
                    }, onError: { error in
                        print("Error fetching post:", error.localizedDescription)
                    })
                    .disposed(by: self.disposeBag)
            }, label: {
                Text("Test API")
            })
            .padding()
        }
        VStack {
            Text(post.title)
                .font(.title)
            
            // Check if the image URL is valid
            if let imageURL = URL(string: post.imageURL) {
                // Asynchronously load the image using AsyncImage
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let loadedImage):
                        loadedImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100) // Adjust size as needed
                    case .failure:
                        // Show placeholder or error message if image loading fails
                        Image(systemName: "photo") // Placeholder image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100) // Adjust size as needed
                            .foregroundColor(.gray)
                    case .empty:
                        // Show loading indicator while image is being fetched
                        ProgressView()
                            .frame(width: 100, height: 100) // Adjust size as needed
                    @unknown default:
                        // Handle unknown cases
                        Text("Unknown state")
                            .foregroundColor(.red)
                    }
                }
            } else {
                // Show placeholder or error message for invalid URL
                Text("Invalid image URL")
                    .foregroundColor(.red)
            }

            Text(post.detail)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
        }
        .padding()
    }
}

