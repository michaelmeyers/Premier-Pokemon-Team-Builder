//
//  MoveController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CoreData

class MoveController {
    
    static let shared = MoveController()
    
    var moves: [Move] {
        return loadPokemonMoves()
    }
    
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
        saveToPersistentStore()
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
    
    
    // MARK: - Core Data
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.context
        do{
            try moc.save()
        } catch let error {
            print("Problem Saving to Persistent Store: \(error)")
        }
    }
    
    func loadPokemonMoves() -> [Move] {
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<Move> = Move.fetchRequest()
        do {
            var fetchedMoves = try moc.fetch(fetchRequest)
            fetchedMoves = fetchedMoves.sorted(by: {$0.id < $1.id} )
            return fetchedMoves
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
}

