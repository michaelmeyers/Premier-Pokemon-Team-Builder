//
//  Pokemon+CloudKit.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/24/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

extension Pokemon {
    convenience init?(ckRecord: CKRecord, pokemonTeamRef: CKReference) {
        guard let name = ckRecord[Keys.ckPokemonNameKey] as? String,
            let item = ckRecord[Keys.ckPokemonItemKey] as? String,
            let natureString = ckRecord[Keys.ckPokemonNatureKey] as? String,
            let nature = changeStringToNature(string: natureString),
            let type1String = ckRecord[Keys.ckPokemonType1Key] as? String,
            let type1 = changeStringToType(string: type1String),
            let role = ckRecord[Keys.ckPokemonRoleKey] as? String,
            let evHP = ckRecord[Keys.ckEVHP] as? Int,
            let evAttack = ckRecord[Keys.ckEVAttack] as? Int,
            let evDefense = ckRecord[Keys.ckEVDefense] as? Int,
            let evSpecialAttack = ckRecord[Keys.ckEVSpAttack] as? Int,
            let evSpecialDefense = ckRecord[Keys.ckEVSpDefense] as? Int,
            let evSpeed = ckRecord[Keys.ckEVSpeed] as? Int,
            let ivHP = ckRecord[Keys.ckIVHP] as? Int,
            let ivAttack = ckRecord[Keys.ckIVAttack] as? Int,
            let ivDefense = ckRecord[Keys.ckIVDefense] as? Int,
            let ivSpecialAttack = ckRecord[Keys.ckIVSpAttack] as? Int,
            let ivSpecialDefense = ckRecord[Keys.ckIVSpDefense] as? Int,
            let ivSpeed = ckRecord[Keys.ckIVSpeed] as? Int,
            let imageEndpoint = ckRecord[Keys.ckPokemonImageEndpoint] as? String,
            let moves = ckRecord[Keys.ckPokemonMovesKey] as? [String],
            let abilities = ckRecord[Keys.ckPokemonAbilitiesKey] as? [String] else {return nil}
        let recordID = ckRecord.recordID
        let type2String = ckRecord[Keys.ckPokemonType2Key] as? String
        var type2: Type?
        if let type2String = type2String {
            type2 = changeStringToType(string: type2String)
        } else {
            type2 = nil
        }
        let chosenAbility = ckRecord[Keys.pokemonAbilityKey] as? String
        let move1 = ckRecord[Keys.ckPokemonMove1Key] as? String
        let move2 = ckRecord[Keys.ckPokemonMove2Key] as? String
        let move3 = ckRecord[Keys.ckPokemonMove3Key] as? String
        let move4 = ckRecord[Keys.ckPokemonMove4Key] as? String
        
        self.init(name: name, item: item, nature: nature, moves: moves, type1: type1, type2: type2, abilities: abilities, role: role, evHP: evHP, evAttack: evAttack, evDefense: evDefense, evSpecialDefense: evSpecialDefense, evSpecialAttack: evSpecialAttack, evSpeed: evSpeed, ivHP: ivHP, ivAttack: ivAttack, ivDefense: ivDefense, ivSpecialDefense: ivSpecialDefense, ivSpecialAttack: ivSpecialAttack, ivSpeed: ivSpeed, imageEndpoint: imageEndpoint, pokemonTeamRef: pokemonTeamRef)
        self.chosenAbility = chosenAbility
        self.move1 = move1
        self.move2 = move2
        self.move3 = move3
        self.move4 = move4
        self.recordID = recordID
        self.pokemonTeamRef = pokemonTeamRef
    }
    

//    var baseStatsDictionary: [String: Int]



    
    var ckRecord: CKRecord? {
        let recordID = self.recordID ?? CKRecordID(recordName: UUID().uuidString)
        let pokemonRecord = CKRecord(recordType: Keys.ckPokemonRecordType, recordID: recordID)
        pokemonRecord[Keys.ckReferenceKey] = pokemonTeamRef
        pokemonRecord[Keys.ckPokemonNameKey] = name as CKRecordValue
        pokemonRecord[Keys.ckPokemonItemKey] = item as CKRecordValue
        pokemonRecord[Keys.ckPokemonNatureKey] = nature.rawValue as CKRecordValue
        pokemonRecord[Keys.ckPokemonType1Key] = type1.rawValue as CKRecordValue
        pokemonRecord[Keys.ckPokemonRoleKey] = role as CKRecordValue
        pokemonRecord[Keys.ckEVHP] = evHP as CKRecordValue
        pokemonRecord[Keys.ckEVAttack] = evAttack as CKRecordValue
        pokemonRecord[Keys.ckEVDefense] = evDefense as CKRecordValue
        pokemonRecord[Keys.ckEVSpAttack] = evSpecialAttack as CKRecordValue
        pokemonRecord[Keys.ckEVSpDefense] = evSpecialDefense as CKRecordValue
        pokemonRecord[Keys.ckEVSpeed] = evSpeed as CKRecordValue
        pokemonRecord[Keys.ckIVHP] = ivHP as CKRecordValue
        pokemonRecord[Keys.ckIVAttack] = ivAttack as CKRecordValue
        pokemonRecord[Keys.ckIVDefense] = ivDefense as CKRecordValue
        pokemonRecord[Keys.ckIVSpAttack] = ivSpecialAttack as CKRecordValue
        pokemonRecord[Keys.ckIVSpDefense] = ivSpecialDefense as CKRecordValue
        pokemonRecord[Keys.ckIVSpeed] = ivSpeed as CKRecordValue
        pokemonRecord[Keys.ckPokemonImageEndpoint] = imageEndpoint as CKRecordValue
        pokemonRecord[Keys.ckPokemonMovesKey] = moves as CKRecordValue
        pokemonRecord[Keys.ckPokemonAbilitiesKey] = abilities as CKRecordValue
        if let hpStat = hpStat {
            pokemonRecord[Keys.ckHPStat] = hpStat as CKRecordValue
        }
        if let attackStat = attackStat {
            pokemonRecord[Keys.ckAttStat] = attackStat as CKRecordValue
        }
        if let defenseStat = defenseStat {
            pokemonRecord[Keys.ckDefStat] = defenseStat as CKRecordValue
        }
        if let spAttackStat = spAttackStat {
            pokemonRecord[Keys.ckSpAtkStat] = spAttackStat as CKRecordValue
        }
        if let spDefenseStat = spDefenseStat {
            pokemonRecord[Keys.ckSpDefStat] = spDefenseStat as CKRecordValue
        }
        if let speedStat = speedStat {
            pokemonRecord[Keys.ckSpeedStat] = speedStat as CKRecordValue
        }
        if let type2  = type2 {
            pokemonRecord[Keys.ckPokemonType2Key] = type2.rawValue as CKRecordValue
        }
        if let chosenAbility = chosenAbility {
            pokemonRecord[Keys.ckPokemonAbilityKey] = chosenAbility as CKRecordValue
        }
        if let move1 = move1 {
            pokemonRecord[Keys.ckPokemonMove1Key] = move1 as CKRecordValue
        }
        if let move2 = move2 {
            pokemonRecord[Keys.ckPokemonMove2Key] = move2 as CKRecordValue
        }
        if let move3 = move3 {
            pokemonRecord[Keys.ckPokemonMove3Key] = move3 as CKRecordValue
        }
        if let move4 = move4 {
            pokemonRecord[Keys.ckPokemonMove4Key] = move4 as CKRecordValue
        }
        return pokemonRecord
    }
}
