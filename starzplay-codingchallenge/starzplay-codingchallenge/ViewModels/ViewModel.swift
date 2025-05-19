//
//  ViewModel.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import Foundation
import Combine

final class ViewModel {
    
    @Published var isLoading = false
    
    let successResult = PassthroughSubject<Bool, Error>()
    let seasonSuccessResult = PassthroughSubject<Bool, Error>()
    let errorResult = PassthroughSubject<String, Error>()
        
    private let seasonId: Int = 62852
    let baseImageURL = "https://image.tmdb.org/t/p/w500"
    
    var tvShow: TVShow?
    
    var selectedSeasonDetail: SeasonDetailResponse?
    
    private let viewModel: ViewModelProtocol
    
    init(viewModel: ViewModelProtocol = VMValidator()) {
        self.viewModel = viewModel
    }
    
    func getTVSeriesDetails() {
        isLoading = true
        viewModel.getTVShowDetail(seasonID: seasonId) { [weak self] result, message in
            self?.isLoading = false
            switch result {
            case let .success((success, response)):
                self?.tvShow = response
                self?.successResult.send(success)
                break
            case .failure(let failure):
                self?.errorResult.send(failure.localizedDescription)
                break
            }
        }
    }
    
    func getSeasonDetails(seasonNumber: Int) {
        self.selectedSeasonDetail = nil
        self.seasonSuccessResult.send(true)
//        isLoading = true
        viewModel.getSeasonDetails(seriesID: seasonId, seasonNumber: seasonNumber) { [weak self] result, message in
//            self?.isLoading = false
            switch result {
            case let .success((success, response)):
                self?.selectedSeasonDetail = response
                self?.seasonSuccessResult.send(success)
                break
            case .failure(let failure):
                self?.errorResult.send(failure.localizedDescription)
                break
            }
        }
    }
    
}

// MARK: - ViewModelProtocol
protocol ViewModelProtocol {
    func getTVShowDetail(seasonID: Int, completionHandler:@escaping ((Result<(Bool, TVShow), Error>, String)->()))
    func getSeasonDetails(seriesID: Int, seasonNumber: Int, completionHandler:@escaping ((Result<(Bool, SeasonDetailResponse), Error>, String)->()))
}

final class VMValidator: ViewModelProtocol {
    
    func getTVShowDetail(seasonID: Int, completionHandler:@escaping ((Result<(Bool, TVShow), Error>, String)->())) {
        APIWrapper.shared?.getDetails(seriesID: seasonID) { status, data, message in
            if status, let show = data {
                completionHandler(.success((status, show)), message)
            } else {
                let error = NSError(domain: "", code: CONFIGS.Response.API_CODE_BAD_REQUEST, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch TV Show"])
                completionHandler(.failure(error), message)
            }
        }
    }
    
    func getSeasonDetails(seriesID: Int, seasonNumber: Int, completionHandler:@escaping ((Result<(Bool, SeasonDetailResponse), Error>, String)->())) {
        APIWrapper.shared?.getSeasonDetails(seriesID: seriesID, seasonNumber: seasonNumber) { status, data, message in
            if status, let season = data {
                completionHandler(.success((status, season)), message)
            } else {
                let error = NSError(domain: "", code: CONFIGS.Response.API_CODE_BAD_REQUEST, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch Season Details"])
                completionHandler(.failure(error), message)
            }
        }
    }
    
}
