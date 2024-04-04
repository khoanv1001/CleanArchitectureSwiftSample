//
//  Models.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//

import Foundation

struct Post: Equatable, Codable {
    let title: String
    let imageURL: [String]
    let detail: String
    let status: Status

    enum Status: String, Codable {
        case Public
        case Private
    }
    
    init(title: String, imageURL: [String], detail: String, status: Status) {
        self.title = title
        self.imageURL = imageURL
        self.detail = detail
        self.status = status
    }
}
