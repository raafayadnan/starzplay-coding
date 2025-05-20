//
//  SeasonEpisodeModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation

struct SeasonEpisode: Codable {
    let airDate: String?
    let episodeNumber: Int
    let episodeType: String?
    let id: Int
    let name: String
    let overview: String
    let productionCode: String?
    let runtime: Int?
    let seasonNumber: Int
    let showID: Int
    let stillPath: String?
    let voteAverage: Double
    let voteCount: Int
    let crew: [CrewMember]
    let guestStars: [GuestStar]

    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case episodeType = "episode_type"
        case id
        case name
        case overview
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showID = "show_id"
        case stillPath = "still_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case crew
        case guestStars = "guest_stars"
    }
}
