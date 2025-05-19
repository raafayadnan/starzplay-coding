//
//  CountryModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation

struct Country: Codable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}
