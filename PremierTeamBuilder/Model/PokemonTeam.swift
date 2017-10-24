//
//  PokemonTeam.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

class PokemonTeam{
    var sixPokemon: [Pokemon]?
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
//    convenience init?(ckRecord: CKRecord) {
//        guard let name = ckRecord[Keys.ckPokemonTeamNameKey] as? String else {return}
//        guard let sixPokemon = ckRecord[keys.ckPokemonTeam]
//    }
    
    var ckRecord: CKRecord? {
        let teamRecord = CKRecord(recordType: Keys.ckTeamRecordType)
        
        teamRecord[Keys.ckPokemonTeamNameKey] = name as CKRecordValue
        var ckSixPokemon: [CKRecord] = []
        guard let sixPokemon = sixPokemon else {return nil}
        for pokemon in sixPokemon {
            guard let pokemonRecord = pokemon.ckRecord else {return nil}
            ckSixPokemon.append(pokemonRecord)
        }
        teamRecord[Keys.ckSixPokemonKey] = ckSixPokemon as CKRecordValue
        return teamRecord
    }
}

//convenience init?(record: CKRecord) {
//    guard let name = record[Keys.nameKey] as? String else {return nil}
//
//    let email = record[Keys.emailKey] as? String
//    let phonenumber = record[Keys.phonenumberKey] as? String
//
//    self.init(name: name, email: email, phonenumber: phonenumber)
//    self.recordID = record.recordID
//}
//
//var cloudKitRecord: CKRecord {
//    let record = CKRecord(recordType: Keys.contactTypeKey)
//    record[Keys.nameKey] = name as CKRecordValue
//    record[Keys.emailKey] = email as CKRecordValue?
//    record[Keys.phonenumberKey] = phonenumber as CKRecordValue?
//    return record
//}

