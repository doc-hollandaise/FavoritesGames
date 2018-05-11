//
//  VideoGame+Extensions.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import Foundation
import CoreData

extension VideoGame {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        addedDate = Date()
    }
}
