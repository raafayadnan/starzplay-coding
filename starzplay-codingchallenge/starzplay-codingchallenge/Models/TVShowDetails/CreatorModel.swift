//
//  CreatorModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation

struct Creator: Codable {
    let id: Int
    let creditID: String
    let name: String
    let originalName: String
    let gender: Int
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name
        case originalName = "original_name"
        case gender
        case profilePath = "profile_path"
    }
}
