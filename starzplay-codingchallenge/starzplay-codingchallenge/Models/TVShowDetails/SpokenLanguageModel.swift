//
//  SpokenLanguageModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation

struct SpokenLanguage: Codable {
    let englishName: String
    let iso639_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
