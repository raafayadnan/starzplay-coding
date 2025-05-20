//
//  VideoPlayerVC.swift
//  starzplay-codingchallenge
//
//  Created by Raafay Adnan on 20/05/2025.
//

import Foundation
import AVKit
import AVFoundation

class VideoPlayerViewController: AVPlayerViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let videoURL = URL(string: "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4") else {
            print("Invalid URL")
            return
        }

        let player = AVPlayer(url: videoURL)
        self.player = player
        self.showsPlaybackControls = true

        // Optional: Auto-play when the view appears
        player.play()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

