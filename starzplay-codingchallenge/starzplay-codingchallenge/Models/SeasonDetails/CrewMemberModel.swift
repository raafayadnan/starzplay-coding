//
//  CrewMemberModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation

struct CrewMember: Codable {
    let id: Int?
    let creditID: String?
    let name: String?
    let department: String?
    let job: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case creditID = "credit_id"
        case name
        case department
        case job
        case profilePath = "profile_path"
    }
}
