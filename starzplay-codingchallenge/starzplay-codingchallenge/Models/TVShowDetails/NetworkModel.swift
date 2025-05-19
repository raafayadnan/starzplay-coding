//
//  NetworkModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation

struct Network: Codable {
    let id: Int
    let logoPath: String?
    let name: String
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}
