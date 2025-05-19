//
//  Configurations.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation

struct CONFIGS {
    
    
    static let baseURL = "https://api.themoviedb.org/"
    
    struct Response {
        static let API_CODE_SUCCESS_OK = 200
        static let API_CODE_BAD_REQUEST = 400
        static let API_CODE_NOT_FOUND = 404
    }
    
    private struct API {
        static let GET_TV_SERIES_DETAIL = "3/tv/"
    }
    
    
    //MARK: GET DETAIL
    static var getDetails: String {
        return baseURL + API.GET_TV_SERIES_DETAIL
    }
    
}
