//
//  AppState.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import Foundation

import SwiftUI

struct AppState: Equatable {
    var userData = UserData()
    var postData = PostData(step: .title, title: "", imageURL: [""], detail: "")
}

extension AppState {
    struct UserData: Equatable {
        var givenName: String = ""
        var isLoggedIn: Bool = false
        var userEmail: String = ""
        var profilePicUrl: String = ""
        var accessToken: String = ""
        var refreshToken: String = ""
    }
}

extension AppState {
    struct PostData: Equatable{
        var step: AddPostStep
        var title: String
        var imageURL: [String]
        var detail: String
    }
}

func == (lhs: AppState, rhs: AppState) -> Bool {
    return lhs.userData == rhs.userData &&
        lhs.postData == rhs.postData
}

enum AddPostStep {
    case title
    case imageURL
//    case detail
//    case status
    case done
}
