//
//  ViewController.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 19/05/2025.
//

import UIKit
import Combine
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topThumbnail: UIImageView!
    @IBOutlet weak var shadowImageView: CustomShadowImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var yearLbl: UILabel!
    @IBOutlet weak var totalSeasonSeparator: UILabel!
    @IBOutlet weak var totalSeasonsLbl: UILabel!
    @IBOutlet weak var ratedSeparator: UILabel!
    @IBOutlet weak var ratedLbl: UILabel!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var readMoreBtn: UIButton!
    
    @IBOutlet weak var watchlistControl: CustomControl!
    @IBOutlet weak var likeControl: CustomControl!
    @IBOutlet weak var dislikeControl: CustomControl!
    
    @IBOutlet weak var seasonTitleCollectionView: UICollectionView!
    
    @IBOutlet weak var episodesTableView: UITableView!
    @IBOutlet weak var tableHeight: NSLayoutConstraint!
    
    
    lazy var activityIndicator = ActivityIndicatorView(style: .medium)
    var isLoading: Bool = false {
        didSet { isLoading ? startLoading(activityIndicator) : finishLoading(activityIndicator) }
    }
    
    private let viewModel: ViewModel = ViewModel()
    private var bindings = Set<AnyCancellable>()
    
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpBindings()
        setUpConstraints(activityIndicator)
        
        self.viewModel.getTVSeriesDetails()
        
        self.seasonTitleCollectionView.delegate = self
        self.seasonTitleCollectionView.dataSource = self
        
        self.episodesTableView.delegate = self
        self.episodesTableView.dataSource = self
        self.episodesTableView.sizeToFit()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableHeight.constant = self.episodesTableView.contentSize.height
    }

    private func setUpBindings() {
        
        viewModel.$isLoading
            .assign(to: \.isLoading, on: self)
            .store(in: &bindings)
        
        viewModel.successResult
            .sink { completion in
                switch completion {
                case .failure:
                    return
                case .finished:
                    return
                }
            } receiveValue: { [unowned self] result in
                self.populateData()
            }
            .store(in: &bindings)
        
        viewModel.seasonSuccessResult
            .sink { completion in
                switch completion {
                case .failure:
                    return
                case .finished:
                    return
                }
            } receiveValue: { [unowned self] result in
                self.loadEpisodes()
            }
            .store(in: &bindings)
        
        viewModel.errorResult
            .sink { completion in
                switch completion {
                case .failure:
                    return
                case .finished:
                    return
                }
            } receiveValue: { [unowned self] result in
                DispatchQueue.main.async {
                    self.showMessage(message: result)
                }
            }
            .store(in: &bindings)
        
    }
    
    private func populateData() {
        DispatchQueue.main.async {
            guard let tvShow = self.viewModel.tvShow else { return }
            
            self.topThumbnail.sd_setImage(with: URL(string: self.viewModel.baseImageURL + (tvShow.backdropPath ?? "")), placeholderImage: UIImage(named: "thumbnail"), options: .continueInBackground)
            self.titleLbl.text = tvShow.name
            
            self.yearLbl.text = "\(tvShow.firstAirDate.split(separator: "-")[0])"
            self.totalSeasonsLbl.text = "\(tvShow.numberOfSeasons) Seasons"
            self.ratedSeparator.isHidden = !tvShow.adult
            self.ratedLbl.isHidden = !tvShow.adult
            
            self.descriptionLbl.text = tvShow.overview
            
            self.seasonTitleCollectionView.reloadData()
            
//            let firstIndexPath = IndexPath(item: 0, section: 0)
//            self.seasonTitleCollectionView.selectItem(at: firstIndexPath, animated: false, scrollPosition: .centeredHorizontally)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if let firstSeason = self.viewModel.tvShow?.seasons.first {
                    self.viewModel.getSeasonDetails(seasonNumber: firstSeason.seasonNumber)
                }
            }
        }
    }
    
    private func loadEpisodes() {
        DispatchQueue.main.async {
            self.tableHeight.constant = CGFloat.greatestFiniteMagnitude
            self.episodesTableView.reloadData()
            self.episodesTableView.layoutIfNeeded()
            self.tableHeight.constant = self.episodesTableView.contentSize.height
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func toggleDescriptionTapped(_ sender: Any) {
        
        guard let tag = (sender as? UIButton)?.tag else { return }
        
        UIView.animate(withDuration: 0.3) {
            self.descriptionLbl.numberOfLines = tag == 0 ? 3 : 0
            self.readMoreBtn.setTitle(tag == 0 ? "Read More" : "Read Less", for: .normal)
            self.readMoreBtn.tag = self.descriptionLbl.numberOfLines
            
        }
    }
    
    @IBAction func playControlTapped(_ sender: Any) {
        
        DispatchQueue.main.async {
            let playerVC = VideoPlayerViewController()
            playerVC.modalPresentationStyle = .fullScreen
            self.present(playerVC, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func trailerControlTapped(_ sender: Any) {
        
    }
    
    
}
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.tvShow?.seasons.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "seasonTitleCell", for: indexPath) as? SeasonTitle {
            
            if let season = self.viewModel.tvShow?.seasons[indexPath.item] {
                let isSelected = indexPath.item == selectedIndex
                let isLast = indexPath.item == (self.viewModel.tvShow?.seasons.count ?? 1) - 1
                cell.updateView(season, isSelected: isSelected, isLast: isLast)
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.item
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            if let season = self.viewModel.tvShow?.seasons[indexPath.item] {
                self.viewModel.getSeasonDetails(seasonNumber: season.seasonNumber)
            }
        })
    }
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.selectedSeasonDetail?.episodes.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "customEpisodeCell", for: indexPath) as? EpisodeCell {
            
            if let episode = self.viewModel.selectedSeasonDetail?.episodes[indexPath.item] {
                cell.updateView(episode, viewModel: self.viewModel)
            }
            
            return cell
        }
        return UITableViewCell()
    }
}
