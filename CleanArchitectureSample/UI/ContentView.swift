//
//  ContentView.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.injected) private var container: DIContainer
    
    @Binding var postData: AppState.PostData

    var body: some View {
        VStack {
            switch postData.step {
            case .title:
                AddTitleView(title: $postData.title)
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
    @Binding var title: String
    
    var body: some View {
        TextField("Enter title", text: $title)
            .padding()
        Button(action: {
            diContainer.appState.bulkUpdate { state in
                state.postData.title = title
                state.postData.step = .done
            }
        }) {
            Text("Next")
        }
        .padding()
        }
    }

struct DisplayPostView: View {
    @Environment(\.injected) private var diContainer: DIContainer

    var body: some View {
        VStack {
            Text("Title: \(diContainer.appState[\.postData.title])")
        }
        .padding()
        .navigationTitle("Display Post")
    }
}
