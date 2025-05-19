//
//  EpisodeModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let name: String
    let overview: String
    let voteAverage: Double
    let voteCount: Int
    let airDate: String
    let episodeNumber: Int
    let episodeType: String
    let productionCode: String
    let runtime: Int?
    let seasonNumber: Int
    let showID: Int
    let stillPath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
    }
}
