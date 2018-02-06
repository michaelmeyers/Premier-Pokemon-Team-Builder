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
    
    var moves: [Move] = []
    
    func createMove(fromSearchTerm searchTerm:String, completion: @escaping(Move?) -> Void) {
        fetchMoveData(fromSearchTerm: searchTerm) { (data) in
            guard let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                completion(nil)
                return}
            guard let dictionary = jsonDictionary else {
                print("Nothing in the JsonDictionary for fetching move data")
                completion(nil)
                return}
            let move = Move(dictionary: dictionary)
            completion(move)
        }
    }
   
    func loadMovesFromJSONFile() {
        guard let moveDataURL = Bundle.main.url(forResource: "moveData", withExtension: "json"),
        
        let data = try? Data(contentsOf: moveDataURL),
        
        let jsonDictionary =  (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [[String: Any]] else {return}
        var moves: [Move] = []
        for dictionary in jsonDictionary {
            guard let move = Move(dictionary: dictionary) else {return}
            moves.append(move)
        }
        moves = moves.sorted { $0.id < $1.id }
        self.moves = moves
    }
    
    func createMoveJSON(fromSearchTerm searchTerm:String, completion: @escaping([String: Any]) -> Void) {
        fetchMoveData(fromSearchTerm: searchTerm) { (data) in
            guard let data = data,
                let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                    completion([:])
                    return}
            guard let dictionary = jsonDictionary else {
                print("Nothing in the JsonDictionary for fetching move data")
                completion([:])
                return}
            
            completion(dictionary)
        }
    }
    
    func fetchMoveData(fromSearchTerm searchTerm: String, completion: @escaping (Data?) -> Void) {
        guard let moveURL = URL(string: Keys.baseURLString)?.appendingPathComponent(Keys.moveKey).appendingPathComponent(searchTerm) else {return}
        let dataTask = URLSession.shared.dataTask(with: moveURL) { (data,_, error) in
            if let error = error {
                print("There was an error with the move fetch: \(error.localizedDescription)")
                completion(nil)
                return
            }
            completion(data)
        }
        dataTask.resume()
    }
    
}

