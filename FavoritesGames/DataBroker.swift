//
//  DataBroker.swift
//  FavoritesGames
//
//  Created by Derek Justus on 5/9/18.
//  Copyright © 2018 Derek Justus. All rights reserved.
//

import Foundation


class Game : Codable {
    let name: String
    let url: String?
    let id: Int
    let cover: GameCover?
    let summary: String?
}

class GameCover : Codable {
    let url: String?
    var imagePath: String? {
        if var imgURL = url {
            if !imgURL.starts(with: "http:") {
                imgURL = "http:\(imgURL)"
            }
            
            if imgURL.range(of: "t_thumb") != nil {
                imgURL = imgURL.replacingOccurrences(of: "t_thumb", with: "t_cover_small_2x")
            }
            
            return imgURL
        } else {
            return url
        }
    }
}

class DataBroker {
    func getGames(completionHandler: @escaping (_ response: [Game]?, _ error: String?    ) -> Void)  {
        
        let requestString = DataBrokerConstants.Games.url
            + DataBrokerConstants.Games.fieldsParam
            + DataBrokerConstants.Games.fieldsParam
            + DataBrokerConstants.Games.filterParam
            + DataBrokerConstants.Games.orderparam
            + DataBrokerConstants.Games.extraParams
        
        var request = URLRequest(url: URL(string: requestString)!)
        request.addValue(DataBrokerConstants.Headers.userKey, forHTTPHeaderField: "user-key")
        request.addValue(DataBrokerConstants.Headers.acceptType, forHTTPHeaderField: "Accept")
        request.timeoutInterval = 10
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            if let newData = data {
                print(String(data: newData, encoding: .utf8)!)
                
                let decoder = JSONDecoder()
                 let games = try! decoder.decode([Game].self, from: newData)
                completionHandler(games, nil)
             
            } else {
                completionHandler(nil, "Error getting data!")
            }
            
        }
        task.resume()
    }
    
    func search(forGame game: String, completionHandler: @escaping (_ response: [Game]?, _ error: String?    ) -> Void)  {
        
        let requestString = DataBrokerConstants.Games.url
            + DataBrokerConstants.Games.fieldsParam
            + DataBrokerConstants.Games.fieldsParam
            + DataBrokerConstants.Games.filterParam
            + DataBrokerConstants.Games.orderparam
            + DataBrokerConstants.Games.extraParams
            + "&search=\(game)"

        var request = URLRequest(url: URL(string: requestString)!)
        request.addValue(DataBrokerConstants.Headers.userKey, forHTTPHeaderField: "user-key")
        request.addValue(DataBrokerConstants.Headers.acceptType, forHTTPHeaderField: "Accept")
        request.timeoutInterval = 10
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil {
                completionHandler(nil, error?.localizedDescription)
                return
            }
            if let newData = data {
                print(String(data: newData, encoding: .utf8)!)
                
                let decoder = JSONDecoder()
                let games = try! decoder.decode([Game].self, from: newData)
                completionHandler(games, nil)
                
            } else {
                completionHandler(nil, "Error getting data!")
            }
            
        }
        task.resume()
    }
}
