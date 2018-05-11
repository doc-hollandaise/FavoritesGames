//
//  GameListCell.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import Foundation
import UIKit

class GameListCell: UITableViewCell {
    var game: Game!
    
    
    @IBOutlet weak var gameName: UILabel!
    @IBOutlet weak var gameImage: UIImageView!
    
    func setupCell() {
         gameName.text = game.name
        gameImage.image = UIImage(imageLiteralResourceName: "placeholder150")
        if let cover = game.cover, let imagePath = cover.imagePath {
           
            if let url = URL(string: imagePath) {
                
                let fetcher = ImageFetcher()                
                fetcher.imageFromUrl(url: url, completionHandler: {(data, error) in
                    guard error == nil else {
                        print("Problem fetching image!")
                        return
                    }
                    
                    if let imageData = data {
                        let image = UIImage(data: imageData)
                        performUIUpdatesOnMain {
                            self.gameImage.image = image
                        }
                    }
                })
                
            }
            
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameName.text = nil
        gameImage.image = nil
    }
    
}
