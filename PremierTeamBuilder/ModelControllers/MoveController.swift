//
//  MoveController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

class MoveController {
    
    static let shared = MoveController()
    
    let networkController = NetworkController()
    
    func createMove(fromSearchTerm searchTerm:String, completion: @escaping(Move?) -> Void) {
        networkController.fetchMoveData(fromSearchTerm: searchTerm) { (data) in
            guard let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                completion(nil)
                return}
            guard let dictionary = jsonDictionary else {
                print("Nothing in the JsonDictionary for fetching move data")
                completion(nil)
                return}
            let move = Move(dicitionary: dictionary)
            completion(move)
        }
    }
    
}

