//
//  FavoriteCell.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/10/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import UIKit

class FavoriteCell : UITableViewCell {
    
    @IBOutlet weak var gameName: UILabel!
    
    func setupCell() {
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gameName.text = nil      
    }
    
}

