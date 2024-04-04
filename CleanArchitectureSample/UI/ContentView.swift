//
//  ContentView.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    private let container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }

    var body: some View {
        VStack {
            switch container.appState[\.post.step] {
            case .title:
                AddTitleView()
                    .inject(container)
            case .done:
                DisplayPostView()
                    .inject(container)
            }
        }
        .navigationTitle("Add Post")
    }
}

struct AddTitleView: View {
    @Environment(\.injected) private var diContainer: DIContainer
    @State private var title = ""
    
    var body: some View {
        TextField("Enter title", text: $title)
            .padding()
        Button(action: {
            diContainer.appState.bulkUpdate { state in
                state.post.title = title
                state.post.step = .done
            }
            print("\(diContainer.appState[\.post.title])")
            print("\(diContainer.appState[\.post.step])")
        }) {
            Text("Next")
        }
        .padding()
        .disabled(title.isEmpty) // Disable the button if title is empty
        .background(
            NavigationLink(destination: DisplayPostView(), // Provide the destination view
                           isActive: Binding<Bool>(get: { diContainer.appState[\.post.step] == .done }, // Activate the link when step is done
                                                   set: { _ in })) {
                                                       EmptyView() // NavigationLink needs a visible view, so we use EmptyView
                                                   }
                .hidden() // Hide the empty view
            )
        }
    }

struct DisplayPostView: View {
    @Environment(\.injected) private var diContainer: DIContainer

    var body: some View {
        VStack {
            Text("Title: \(diContainer.appState[\.post.detail])")
        }
        .padding()
        .navigationTitle("Display Post")
    }
}

enum AddPostStep {
    case title
//    case imageURL
//    case detail
//    case status
    case done
}

//#Preview {
//    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//}
