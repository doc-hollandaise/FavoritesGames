//
//  DataBrokerConstants.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/12/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import Foundation

struct DataBrokerConstants {
    
    struct Headers {
        static let userKey = "1631cd9547933145c916e1d78fd2f437"
        static let acceptType = "application/json"
    }
    
    struct Games {
        static let url = "https://api-endpoint.igdb.com/games/?"
        static let fieldsParam = "&fields=name,summary,cover,url"
        static let filterParam = "&filter[release_dates.date]&filter[rating][gt]=75"
        static let orderparam = "&order=release_dates.date:desc"
        static let extraParams = "&limit=50"
    }
    
    struct Search {
        static let url = "https://api-endpoint.igdb.com/games/?"
        static let fieldsParam = "&fields=name,summary,cover,url"
        static let filterParam = "&filter[release_dates.date]&filter[rating][gt]=75"
        static let orderparam = "&order=release_dates.date:desc"
        static let extraParams = "&limit=25&expand=game"
    }
    
}
