//
//  Models.swift
//  CleanArchitectureSample
//
//  Created by Nguyen Viet Khoa on 03/04/2024.
//


struct Post: Equatable, Codable {
    let id: String
    let title: String
    let imageURL: String
    let detail: String
    
    init(id: String, title: String, imageURL: String, detail: String) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.detail = detail
    }
}
