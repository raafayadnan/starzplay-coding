//
//  APIWrapper.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation
import Alamofire

class APIWrapper {
    
    var basicHeaders : [String:String] = ["Content-Type": "application/json"]
    
    private let apiKey = "ecef14eac236a5d4ec6ac3a4a4761e8f"
    
    private static var _shared : APIWrapper? = nil
    public static var shared : APIWrapper? {
        get {
            if _shared == nil {
                _shared = APIWrapper()
            }
            
            return _shared
        }
    }
    
    func getDetails(seriesID: Int, completionHandler:@escaping (Bool,TVShow?,String)->()) {
        if let url = URL(string: "\(CONFIGS.getDetails)\(seriesID)?api_key=\(apiKey)") {
            callAPI(url: url, method: .get, headers: basicHeaders) { success, data, errorMessage in
                if success, let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let show = try decoder.decode(TVShow.self, from: data)
                        completionHandler(true, show, "")
                    } catch {
                        completionHandler(false, nil, "Decoding error: \(error.localizedDescription)")
                    }
                } else {
                    completionHandler(false, nil, errorMessage)
                }
            }
        } else {
            completionHandler(false, nil, "Invalid URL")
        }
    }
    
    func getSeasonDetails(seriesID: Int, seasonNumber: Int, completionHandler:@escaping (Bool,SeasonDetailResponse?,String)->()) {
        if let url = URL(string: "\(CONFIGS.getDetails)\(seriesID)/season/\(seasonNumber)?api_key=\(apiKey)") {
            callAPI(url: url, method: .get, headers: basicHeaders) { success, data, errorMessage in
                if success, let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        let show = try decoder.decode(SeasonDetailResponse.self, from: data)
                        completionHandler(true, show, "")
                    } catch {
                        completionHandler(false, nil, "Decoding error: \(error.localizedDescription)")
                    }
                } else {
                    completionHandler(false, nil, errorMessage)
                }
            }
        } else {
            completionHandler(false, nil, "Invalid URL")
        }
    }
    
    //MARK: Private Generic Methods
    private func callAPI(url:URL,
                            method:HTTPMethod = .post,
                            parameters:[String:Any]?=nil,
                            headers:[String:Any]?=nil,
                            completionHandler:@escaping (Bool,Data?,String)->()) {
        
        sendRequest(url: url,
                    method: method,
                    parameters: parameters,
                    encoding: JSONEncoding.default)
        { (result, status, data, errorMessage)  in
            completionHandler(result, data, errorMessage)
        }
    }
    
    private func sendRequest(url : URL,
                            method : HTTPMethod,
                            parameters:[String:Any]? = [:],
                            encoding : ParameterEncoding,
                            completionHandler: @escaping(Bool,Int,Data,String)->()) {

//        var urlRequest = URLRequest(url: url)
//        urlRequest.timeoutInterval = 120
        
        AF.request(url, method: method, parameters: parameters, encoding: encoding).validate().responseData { response in
            completionHandler(response.response?.statusCode == CONFIGS.Response.API_CODE_SUCCESS_OK,
                              response.response?.statusCode ?? -999,
                              response.data ?? Data(),
                              response.error?.localizedDescription ?? "")
            
        }

    }

}
