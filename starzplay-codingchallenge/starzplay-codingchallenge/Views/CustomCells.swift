//
//  CustomCells.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation
import UIKit

class SeasonTitle: UICollectionViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var highlight: UIImageView!
    @IBOutlet weak var separator: UIImageView!
    
    func updateView(_ item: Season, isSelected: Bool, isLast: Bool) {
        titleLbl.text = item.name.capitalized
        
        // Highlight visibility
        highlight.isHidden = !isSelected
        
        // Bold font if selected
        titleLbl.font = isSelected ? UIFont.boldSystemFont(ofSize: 20) : UIFont.systemFont(ofSize: 20)
        titleLbl.textColor = isSelected ? .white : .lightGray
        
        // Hide separator if last
        separator.isHidden = isLast
        
    }
}


class EpisodeCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var download: UIButton!
    
    func updateView(_ item: SeasonEpisode, viewModel: ViewModel) {
        thumbnail.sd_setImage(with: URL(string: viewModel.baseImageURL + (item.stillPath ?? "")),
                              placeholderImage: UIImage(named: "thumbnail"), options: .continueInBackground)
        
        titleLbl.text = item.name
        download.isHidden = true
    }
    
}
