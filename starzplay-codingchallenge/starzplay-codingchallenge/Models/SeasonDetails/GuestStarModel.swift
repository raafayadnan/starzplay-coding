//
//  GuestStarModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation

struct GuestStar: Codable {
    let id: Int?
    let name: String?
    let creditID: String?
    let character: String?
    let order: Int?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case creditID = "credit_id"
        case character
        case order
        case profilePath = "profile_path"
    }
}
