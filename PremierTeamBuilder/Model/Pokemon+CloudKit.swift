//
//  Pokemon+CloudKit.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/24/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit
import CoreData

extension Pokemon: CloudKitSyncable {
    
    convenience init?(ckRecord: CKRecord, pokemonTeamRef: CKReference, context: NSManagedObjectContext = CoreDataStack.context) {
        guard let name = ckRecord[Keys.ckPokemonNameKey] as? String,
            let id = ckRecord[Keys.ckPokemonIDKey] as? Int64,
            let item = ckRecord[Keys.ckPokemonItemKey] as? String,
            let natureString = ckRecord[Keys.ckPokemonNatureKey] as? String,
            let type1String = ckRecord[Keys.ckPokemonType1Key] as? String,
            let role = ckRecord[Keys.ckPokemonRoleKey] as? String,
            let evHP = ckRecord[Keys.ckEVHP] as? Int64,
            let evAttack = ckRecord[Keys.ckEVAttack] as? Int64,
            let evDefense = ckRecord[Keys.ckEVDefense] as? Int64,
            let evSpecialAttack = ckRecord[Keys.ckEVSpAttack] as? Int64,
            let evSpecialDefense = ckRecord[Keys.ckEVSpDefense] as? Int64,
            let evSpeed = ckRecord[Keys.ckEVSpeed] as? Int64,
            let ivHP = ckRecord[Keys.ckIVHP] as? Int64,
            let ivAttack = ckRecord[Keys.ckIVAttack] as? Int64,
            let ivDefense = ckRecord[Keys.ckIVDefense] as? Int64,
            let ivSpecialAttack = ckRecord[Keys.ckIVSpAttack] as? Int64,
            let ivSpecialDefense = ckRecord[Keys.ckIVSpDefense] as? Int64,
            let ivSpeed = ckRecord[Keys.ckIVSpeed] as? Int64,
            let moveIDsData = ckRecord[Keys.ckPokemonMovesKey] as? NSData,
            let abilitiesData = ckRecord[Keys.ckPokemonAbilitiesKey] as? NSData,
            let hpStat = ckRecord[Keys.ckHPStat] as? Int64,
            let attackStat = ckRecord[Keys.ckAttStat] as? Int64,
            let defenseStat = ckRecord[Keys.ckDefStat] as? Int64,
            let spAttackStat = ckRecord[Keys.ckSpAtkStat] as? Int64,
            let spDefenseStat = ckRecord[Keys.ckSpDefStat] as? Int64,
            let speedStat = ckRecord[Keys.ckSpeedStat] as? Int64,
            let imageData = ckRecord[Keys.ckPokemonImageData] as? Data? else {
                return nil
        }
        let pokemonTeamRefString = ckRecord[Keys.ckReferenceKey] as? String
        let imageEndpoint = ckRecord[Keys.ckPokemonImageEndpoint] as? String
        let type2String = ckRecord[Keys.ckPokemonType2Key] as? String
        let chosenAbility = ckRecord[Keys.pokemonAbilityKey] as? String
        let move1 = ckRecord[Keys.ckPokemonMove1Key] as? String
        let move2 = ckRecord[Keys.ckPokemonMove2Key] as? String
        let move3 = ckRecord[Keys.ckPokemonMove3Key] as? String
        let move4 = ckRecord[Keys.ckPokemonMove4Key] as? String
        
        self.init(context: context)
        
        self.name = name
        self.id = id
        self.item = item
        self.natureString = natureString
        self.moveIDsData = moveIDsData as NSData
        self.type1String = type1String
        self.type2String = type2String
        self.abilitiesData = abilitiesData as NSData
        self.role = role
        self.evHP = evHP
        self.evAttack = evAttack
        self.evDefense = evDefense
        self.evSpecialAttack = evSpecialAttack
        self.evSpecialDefense = evSpecialDefense
        self.evSpeed = evSpeed
        self.ivHP = ivHP
        self.ivAttack = ivAttack
        self.ivDefense = ivDefense
        self.ivSpecialAttack = ivSpecialAttack
        self.ivSpecialDefense = ivSpecialDefense
        self.ivSpeed = ivSpeed
        self.hpStat = hpStat
        self.attackStat = attackStat
        self.defenseStat = defenseStat
        self.spAttackStat = spAttackStat
        self.spDefenseStat = spDefenseStat
        self.speedStat = speedStat
        self.imageData = imageData as NSData?
        self.imageEndpoint = imageEndpoint
        self.chosenAbility = chosenAbility
        self.move1 = move1
        self.move2 = move2
        self.move3 = move3
        self.move4 = move4
        self.pokemonTeamRefString = pokemonTeamRefString
    }
    
    var ckRecord: CKRecord? {
        let recordID = self.recordID ?? CKRecordID(recordName: UUID().uuidString)
        let pokemonRecord = CKRecord(recordType: Keys.ckPokemonRecordType, recordID: recordID)
        pokemonRecord[Keys.ckPokemonNameKey] = name as CKRecordValue
        pokemonRecord[Keys.ckPokemonIDKey] = id as CKRecordValue
        pokemonRecord[Keys.ckPokemonItemKey] = item as CKRecordValue
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
        pokemonRecord[Keys.ckHPStat] = hpStat as CKRecordValue
        pokemonRecord[Keys.ckAttStat] = attackStat as CKRecordValue
        pokemonRecord[Keys.ckDefStat] = defenseStat as CKRecordValue
        pokemonRecord[Keys.ckSpAtkStat] = spAttackStat as CKRecordValue
        pokemonRecord[Keys.ckSpDefStat] = spDefenseStat as CKRecordValue
        pokemonRecord[Keys.ckSpeedStat] = speedStat as CKRecordValue
        pokemonRecord[Keys.ckPokemonMovesKey] = moveIDsData as CKRecordValue
        pokemonRecord[Keys.ckPokemonAbilitiesKey] = abilitiesData as CKRecordValue
        
        if let nature = nature {
            pokemonRecord[Keys.ckPokemonNatureKey] = nature.rawValue as CKRecordValue
        }
        if let type1 = type1 {
            pokemonRecord[Keys.ckPokemonType1Key] = type1.rawValue as CKRecordValue
        }
        if let imageEndpoint = imageEndpoint {
            pokemonRecord[Keys.ckPokemonImageEndpoint] = imageEndpoint as CKRecordValue
        }
        if let imageData = imageData{
            pokemonRecord[Keys.ckPokemonImageData] = imageData as CKRecordValue
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
        if let pokemonTeamRefString = pokemonTeamRefString {
            pokemonRecord[Keys.ckReferenceKey] = pokemonTeamRefString as CKRecordValue
        }
        return pokemonRecord
    }
    
    // MARK: - CloudKitSyncable
    var recordType: String {
        return Keys.ckPokemonRecordType
    }
}
