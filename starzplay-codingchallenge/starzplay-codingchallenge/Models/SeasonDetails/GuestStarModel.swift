//
//  GuestStarModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation

//struct GuestStar: Codable {
//    let id: Int?
//    let name: String?
//    let creditID: String?
//    let character: String?
//    let order: Int?
//    let profilePath: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case name
//        case creditID = "credit_id"
//        case character
//        case order
//        case profilePath = "profile_path"
//    }
//}

struct GuestStar: Codable {
    let character: String?
    let creditID: String?
    let order: Int?
    let adult: Bool
    let gender: Int?
    let id: Int?
    let knownForDepartment: String
    let name: String?
    let originalName: String
    let popularity: Double
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case character
        case creditID = "credit_id"
        case order, adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
    }
}
