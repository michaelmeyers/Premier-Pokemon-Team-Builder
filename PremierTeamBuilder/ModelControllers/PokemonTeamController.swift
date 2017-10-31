//
//  PokemonTeamController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

class PokemonTeamController {
    
    static let shared = PokemonTeamController()
    
    var pokemonList: [String: URL] = [:]
    var items: [String] = ["None"]
    var pokemonTypes: [String] = typesKeyArray
    var pokemonTeams: [PokemonTeam]?
    
    
    // MARK: - Crud
    func createTeam(pokemonTeam: PokemonTeam){
        guard let record = pokemonTeam.ckRecord else {return}
        savePokemonTeamRecord(record: record) { (success) in
            if success == true {
                print ("successfully Saved Team")
            } else {
                print ("Team was not Saved")
            }
        }
        PokemonTeamController.shared.pokemonTeams?.append(pokemonTeam)
    }
    
    func updateTeam(pokemonTeam: PokemonTeam, newName: String) {
        pokemonTeam.name = newName
        updatePokemonTeamRecord(newPokemonTeam: pokemonTeam) { (success) in
            if success == true {
                print ("successfully updated Team")
            } else {
                print ("Team was not Updated")
            }
        }
    }
    
    func deleteTeam(pokemonTeam: PokemonTeam) {
        guard let recordID = pokemonTeam.recordID else {return}
        deletePokemonTeamRecord(withID: recordID) { (_, error) in
            if let error = error {
                print("There was an error deleting Pokemon Team: \(error.localizedDescription)")
                return
            }
        }
    }
    
    // MARK: - API Methods
        
    func fetchListOfAllPokemon(completion: @escaping (Bool?) -> Void) {
        guard let url = URL(string: Keys.allPokemonBaseURL) else {return}
            let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let error = error {
                    print("There was an error fetching the pokemonList information : \(error.localizedDescription)")
                    completion(false)
                    return
                }
                guard let data = data else {
                    completion(false)
                    return
                }
                guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                    let dictionary = jsonDictionary,
                    let resultsArray = dictionary[Keys.allPokemonArrayKey] as? [[String: Any]] else {
                        completion(false)
                        return
                }
                for dictionary in resultsArray {
                    guard let name = dictionary[Keys.allPokemonNameKey] as? String else {
                        completion(false)
                        return
                    }
                    guard let urlString = dictionary[Keys.allPokemonURLKey] as? String else {
                        completion(false)
                        return
                    }
                    guard let url = URL(string: urlString) else {
                        completion(false)
                        return
                    }
                    self.pokemonList[name] = url
                }
                completion(true)
            }
        dataTask.resume()
        }
        
    
    //https://pokeapi.co/api/v2/generation/6/
    
    func fetchItems(completion: @escaping (Bool?) -> Void) {
        guard let url = URL(string: Keys.itemBaseURLString) else {return}
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("There was an error fetching the Items info: \(error.localizedDescription)")
                completion(false)
                return
            }
        guard let data = data else {
            print("No Data from Fetch Items")
            completion(false)
            return
        }
        guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
            let dictionary = jsonDictionary,
            let itemsArray = dictionary[Keys.itemsArrayKey] as? [[String: Any]] else {return}
            for itemDictionary in itemsArray {
                guard let item = itemDictionary[Keys.itemNameKey] as? String else {return}
                PokemonTeamController.shared.items.append(item)
            }
            completion(true)
        }
        dataTask.resume()
    }
    //https://pokeapi.co/api/v2/item-attribute/holdable-active/
    
    func fetchPokemonTeamsAndPokemonRecords(completion: @escaping () -> Void){
        
        fetchPokemonTeamRecord(withRecordType: Keys.ckTeamRecordType) { (records, error) in
            
            
            if let error = error {
                print(" : \(error.localizedDescription)")
                completion()
                return
            }
            guard let records = records else {
                completion()
                return}
            var pokemonTeams: [PokemonTeam] = []
            for record in records{
                guard let pokemonTeam = PokemonTeam(ckRecord: record) else {
                    completion()
                    return}
                pokemonTeams.append(pokemonTeam)
                
            }
            
            let group = DispatchGroup()
            for pokemonTeam in pokemonTeams {
                group.enter()
                PokemonController.shared.fetchPokemonRecordFor(pokemonTeam: pokemonTeam, withRecordType: Keys.ckPokemonRecordType, completion: { (records, reference, error)  in
                    if let error = error {
                        print("There was an error fetching the pokemonRecords: \(error.localizedDescription)")
                        group.leave()
                        return
                    }
                    guard let records = records else {
                            group.leave()
                            return}
                    for record in records {
                        guard let pokemon = Pokemon(ckRecord: record, pokemonTeamRef: reference) else {
                            group.leave()
                            return}
                        pokemonTeam.sixPokemon.append(pokemon)
                    }
                    group.leave()
                })
            }
            group.notify(queue: DispatchQueue.main, execute: {
                self.pokemonTeams = pokemonTeams
                completion()
            })
        }
        
    }
    
    // MARK: - CloudKit Func
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    func fetchPokemonTeamRecord(withRecordType type: String, completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: Keys.ckTeamRecordType, predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    func savePokemonTeamRecord(record: CKRecord, completion: @escaping (Bool) -> Void) {
        privateDatabase.save(record) { (_, error) in
            var success: Bool = true
            if let error = error {
                print("There was an error saving Pokemon Team: \(error.localizedDescription)")
                success = false
                completion(success)
                return
            }
            print("No Error")
            completion(success)
        }
    }
    
    func updatePokemonTeamRecord(newPokemonTeam: PokemonTeam, completion: @escaping (Bool) -> Void) {
        var success: Bool = true
        guard let record = newPokemonTeam.ckRecord else {
            success = false
            completion(success)
            return
        }
        savePokemonTeamRecord(record: record) { (success) in
            completion(success)
        }
    }
    
    func deletePokemonTeamRecord(withID recordID: CKRecordID, completion: @escaping (CKRecordID?, Error?) -> Void) {
        privateDatabase.delete(withRecordID: recordID, completionHandler: completion)
    }
    
}
