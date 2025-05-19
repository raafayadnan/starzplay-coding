//
//  SeasonDetailModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation

struct SeasonDetailResponse: Codable {
    let id: String
    let airDate: String?
    let episodes: [Episode]
    let name: String
    let overview: String
    let seasonID: Int
    let posterPath: String?
    let seasonNumber: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case airDate = "air_date"
        case episodes
        case name
        case overview
        case seasonID = "id"
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
        case voteAverage = "vote_average"
    }
}
