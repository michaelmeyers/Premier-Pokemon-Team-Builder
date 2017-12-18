//
//  PokemonTeamController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

class PokemonTeamController {
    
    static let shared = PokemonTeamController()
    
    var isSyncing: Bool = false
    var pokemonList: [String: URL] = [:]
    var items: [String] = ["None"]
    var pokemonTypes: [String] = typesKeyArray
    var pokemonTeams: [PokemonTeam] {
        return loadPokemonTeams()
    }
    
    // MARK: - Crud
    func createTeam(pokemonTeam: PokemonTeam){
        saveToPersistentStore()
        performFullSync()
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
    
    func deleteTeam(pokemonTeam: PokemonTeam, indexPath: IndexPath) {
        guard let recordID = pokemonTeam.recordID else { return }
        deleteTeamFromContext(pokemonTeam: pokemonTeam)
        deletePokemonTeamRecord(withID: recordID) { (_, error) in
            if let error = error {
                print("There was an error deleting Pokemon Team: \(error.localizedDescription)")
                return
            }
        }
    }
    
    // MARK: - API Methods
    
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
    
    // MARK: - Core Data
    func saveToPersistentStore() {
        
        let moc = CoreDataStack.context
        do{
            try moc.save()
        } catch let error {
            print("Problem Saving to Persistent Store: \(error)")
        }
    }
    
    func loadPokemonTeams() -> [PokemonTeam] {
        let moc = CoreDataStack.context
        let fetchRequest: NSFetchRequest<PokemonTeam> = PokemonTeam.fetchRequest()
        do {
            let fetchedPokemonTeams = try moc.fetch(fetchRequest)
            return fetchedPokemonTeams
        } catch {
            fatalError("Failed to fetch employees: \(error)")
        }
    }
    
    func deleteTeamFromContext(pokemonTeam: PokemonTeam) {
        let moc = CoreDataStack.context
        moc.delete(pokemonTeam)
        saveToPersistentStore()
    }
    
    // MARK: - Syncing CoreData and CloudKit
    func performFullSync(completion: @escaping (() -> Void) = {  }) {
        
        guard !isSyncing else {
            
            // Add Timer to then call the function again
            completion()
            return
        }
        isSyncing = true
        pushChangesToCloudKit { (success)  in
            if success == true {
                print("Pushed Changes To Cloud Kit")
            } else {
                print("Changes were NOT Pushed to Cloud Kit")
            }
            self.fetchNewPokemonTeams(completion: { (pokemonTeams) in
                guard let pokemonTeams = pokemonTeams else {
                    print ("No pokemon Teams")
                    completion()
                    return
                }
                let group = DispatchGroup()
                
                for pokemonTeam in pokemonTeams {
                    group.enter()
                    self.fetchNewPokemon(pokemonTeam: pokemonTeam, completion: {
                        group.leave()
                    })
                }
                
                group.notify(queue: .main, execute: {
                    self.isSyncing = false
                    completion()
                })
            })
        }
    }
    
    func pushChangesToCloudKit(completion: @escaping ((_ success: Bool) -> Void) = { _ in }) {
        
        var successes: [Bool] = []
        
        let unsavedPokemonTeams = unsyncedRecordsOf(type: Keys.ckTeamRecordType) as? [PokemonTeam] ?? []
        let unsavedPokemon = unsyncedRecordsOf(type: Keys.ckPokemonRecordType) as? [Pokemon] ?? []
        let group = DispatchGroup()
        if unsavedPokemonTeams.count != 0 {
            for pokemonTeam in unsavedPokemonTeams {
                group.enter()
                savePokemonTeam(pokemonTeam:pokemonTeam , completion: { (success) in
                    successes.append(success)
                    group.leave()
                })
            }
        }
        
        if unsavedPokemon.count != 0 {
            for pokemon in unsavedPokemon {
                group.enter()
                PokemonController.shared.savePokemonToCloudKit(pokemon: pokemon, completion: { (success) in
                    successes.append(success)
                    group.leave()
                })
            }
        }
        group.notify(queue: DispatchQueue.main) {
            self.saveToPersistentStore()
            
            if successes.contains(false) {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    
    func fetchNewPokemonTeams(completion: @escaping ([PokemonTeam]?) -> Void) {
        let type = Keys.ckTeamRecordType
        var referencesToExclude = [CKReference]()
        var predicate: NSPredicate
        referencesToExclude = syncedRecordsOf(type: type).flatMap { $0.cloudKitReference }
        predicate = NSPredicate(format: "NOT(recordID IN %@)", argumentArray: [referencesToExclude])
        
        if referencesToExclude.isEmpty {
            predicate = NSPredicate(value: true)
        }
        
        fetchPokemonTeamRecord(withRecordType: type, andPredicate: predicate) { (records, error) in
            if let error = error {
                print("Error Fetching Pokemon Team Records : \(error.localizedDescription)")
                completion(nil)
            }
            guard let records = records else {
                print ("no records")
                completion(nil)
                return
            }
            var pokemonTeams: [PokemonTeam] = []
            for record in records {
                guard let pokemonTeam = PokemonTeam(ckRecord: record) else {
                    print ("Could not initialize pokemon team")
                    completion(nil)
                    return
                }
                pokemonTeams.append(pokemonTeam)
                self.saveToPersistentStore()
            }
            completion(pokemonTeams)
        }
    }
    
    func fetchNewPokemon(pokemonTeam: PokemonTeam, completion: @escaping () -> Void) {
        let type = Keys.ckPokemonRecordType
        var referencesToExclude = [CKReference]()
        var predicate: NSPredicate
        referencesToExclude = syncedRecordsOf(type: type).flatMap { $0.cloudKitReference }
        predicate = NSPredicate(format: "NOT(recordID IN %@)", argumentArray: [referencesToExclude])
        
        if referencesToExclude.isEmpty {
            predicate = NSPredicate(value: true)
        }
        
        PokemonController.shared.fetchPokemonRecordFor(pokemonTeam: pokemonTeam, withRecordType: type, andPredicate: predicate) { (records, _, error) in
            if let error = error {
                print("Error Fetching Pokemon Team Records : \(error.localizedDescription)")
                completion()
                return
            }
            guard let records = records else {
                print ("no records")
                completion()
                return
            }
            
            for record in records {
                guard let recordID = pokemonTeam.recordID else {
                    print ("Pokemon Team Reference")
                    continue
                }
                let pokemonTeamRef = CKReference(recordID: recordID, action: .deleteSelf)
                _ = Pokemon(ckRecord: record, pokemonTeamRef: pokemonTeamRef)
            }
            
            self.saveToPersistentStore()
            completion()
        }
    }
    
    func syncedRecordsOf(type: String) -> [CloudKitSyncable] {
        return recordsOf(type: type).filter { $0.isSynced }
    }
    
    func unsyncedRecordsOf(type: String) -> [CloudKitSyncable] {
        return recordsOf(type: type).filter { !$0.isSynced }
    }
    
    func recordsOf(type: String) -> [CloudKitSyncable] {
        switch type {
        case Keys.ckTeamRecordType:
            return PokemonTeamController.shared.pokemonTeams.flatMap { $0 as CloudKitSyncable }
        case Keys.ckPokemonRecordType:
            
            var allPokemon: [CloudKitSyncable] = []
            for pokemonTeam in PokemonTeamController.shared.pokemonTeams {
                guard let sixPokemonArray = pokemonTeam.sixPokemon?.array as? [CloudKitSyncable] else {return []}
                allPokemon.append(contentsOf: sixPokemonArray)
            }
            return allPokemon
        default:
            return []
        }
    }
    
    // MARK: - CloudKit Func
    let privateDatabase = CKContainer.default().privateCloudDatabase
    
    func fetchPokemonTeamRecord(withRecordType type: String, andPredicate predicate: NSPredicate = NSPredicate(value: true), completion: @escaping ([CKRecord]?, Error?) -> Void) {
        let query = CKQuery(recordType: Keys.ckTeamRecordType, predicate: predicate)
        privateDatabase.perform(query, inZoneWith: nil, completionHandler: completion)
    }
    
    private func savePokemonTeam(pokemonTeam: PokemonTeam, completion: @escaping (Bool) -> Void) {
        
        guard let record = pokemonTeam.ckRecord else { completion(false); return }
        
        privateDatabase.save(record) { (_, error) in
            var success: Bool = true
            if let error = error {
                print("There was an error saving Pokemon Team: \(error.localizedDescription)")
                success = false
                completion(success)
                return
            }
            pokemonTeam.recordIDString = record.recordID.recordName
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
        let operation = CKModifyRecordsOperation(recordsToSave: [record], recordIDsToDelete: nil)
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        privateDatabase.add(operation)
        completion(success)
    }
    
    func deletePokemonTeamRecord(withID recordID: CKRecordID, completion: @escaping (CKRecordID?, Error?) -> Void) {
        privateDatabase.delete(withRecordID: recordID, completionHandler: completion)
    }
    
}

// MARK: - Out Data Code

//https://pokeapi.co/api/v2/item-attribute/holdable-active/

//    func fetchPokemonTeamsAndPokemonRecords(completion: @escaping () -> Void){
//
//        fetchPokemonTeamRecord(withRecordType: Keys.ckTeamRecordType) { (records, error) in
//
//
//            if let error = error {
//                print(" : \(error.localizedDescription)")
//                completion()
//                return
//            }
//            guard let records = records else {
//                completion()
//                return}
//            var pokemonTeams: [PokemonTeam] = []
//            for record in records{
//                guard let pokemonTeam = PokemonTeam(ckRecord: record) else {
//                    completion()
//                    return}
//                pokemonTeams.append(pokemonTeam)
//            }
//
//            let group = DispatchGroup()
//            for pokemonTeam in pokemonTeams {
//                group.enter()
//                PokemonController.shared.fetchPokemonRecordFor(pokemonTeam: pokemonTeam, withRecordType: Keys.ckPokemonRecordType, completion: { (records, reference, error)  in
//                    if let error = error {
//                        print("There was an error fetching the pokemonRecords: \(error.localizedDescription)")
//                        group.leave()
//                        return
//                    }
//                    var sixPokemon: [Pokemon] = []
//                    guard let records = records else {
//                        group.leave()
//                        return}
//                    for record in records {
//                        guard let pokemon = Pokemon(ckRecord: record, pokemonTeamRef: reference) else {
//                            group.leave()
//                            return}
//                        sixPokemon.append(pokemon)
//                    }
//                    pokemonTeam.sixPokemon = NSOrderedSet(array: sixPokemon)
//                    group.leave()
//                })
//            }
//            group.notify(queue: DispatchQueue.main, execute: {
//                completion()
//            })
//        }
//
//    }

//    func fetchListOfAllPokemon(completion: @escaping (Bool?) -> Void) {
//        guard let url = URL(string: Keys.allPokemonBaseURL) else {return}
//        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
//            if let error = error {
//                print("There was an error fetching the pokemonList information : \(error.localizedDescription)")
//                completion(false)
//                return
//            }
//            guard let data = data else {
//                completion(false)
//                return
//            }
//            guard let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
//                let dictionary = jsonDictionary,
//                let resultsArray = dictionary[Keys.allPokemonArrayKey] as? [[String: Any]] else {
//                    completion(false)
//                    return
//            }
//            for dictionary in resultsArray {
//                guard let name = dictionary[Keys.allPokemonNameKey] as? String else {
//                    completion(false)
//                    return
//                }
//                guard let urlString = dictionary[Keys.allPokemonURLKey] as? String else {
//                    completion(false)
//                    return
//                }
//                guard let url = URL(string: urlString) else {
//                    completion(false)
//                    return
//                }
//                self.pokemonList[name] = url
//            }
//            completion(true)
//        }
//        dataTask.resume()
//    }

