//
//  ContentView.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI
import CoreData
import RxSwift

struct ContentView: View {
    @Environment(\.injected) private var container: DIContainer
    
    @Binding var postData: AppState.PostData
    
    var body: some View {
        VStack {
            switch postData.step {
            case .title:
                AddTitleView(title: $postData.title, detail: $postData.detail)
                    .inject(container)
            case .done:
                DisplayPostView()
                    .inject(container)
            case .imageURL:
                testAPIView()
                    .inject(container)
            }
        }
        .navigationTitle("Add Post")
    }
}



struct AddTitleView: View {
    @Environment(\.injected) private var diContainer: DIContainer
    @Binding var title: String
    
    @Binding var detail: String
    
    var body: some View {
        TextField("Enter title", text: $title)
            .padding()
        TextField("Enter detail", text: $detail)
            .padding()
        Button(action: {
            diContainer.appState.bulkUpdate { state in
                state.postData.title = title
                state.postData.detail = detail
                state.postData.step = .imageURL
            }
        }) {
            Text("Next")
        }
        .padding()
    }
}

struct testAPIView: View {
    @Environment(\.injected) private var container: DIContainer
    let disposeBag = DisposeBag()
    @State var post: Post = Post(id: "", title: "", imageURL: "", detail: "")
    
    var body: some View {
        VStack {
            Button(action: {
                container.interactors.postInteractor.getPosts()
                    .subscribe(onNext: { post in
                        print("\(post)")
                        self.post = post
                        container.appState.bulkUpdate { state in
                            state.postData.imageURL = [self.post.imageURL]
                        }
                    }, onError: { error in
                        print("Error fetching post:", error.localizedDescription)
                    })
                    .disposed(by: self.disposeBag)
            }, label: {
                Text("Test API")
            })
            .padding()
            Button(action: {
                container.appState.bulkUpdate { state in
                    state.postData.step = .done
                }
            }) {
                Text("Next")
            }
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
        }
        .padding()
    }
}

struct DisplayPostView: View {
    @Environment(\.injected) private var diContainer: DIContainer
    
    var body: some View {
        VStack {
            Text("User: \(diContainer.appState[\.userData.givenName])")
            Text("Email: \(diContainer.appState[\.userData.userEmail])")
            Text("Title: \(diContainer.appState[\.postData.title])")
            Text("Detail: \(diContainer.appState[\.postData.detail])")
            if let imageURL = URL(string: diContainer.appState[\.postData.imageURL][0]) {
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
        }
        .padding()
        .navigationTitle("Display Post")
    }
}
