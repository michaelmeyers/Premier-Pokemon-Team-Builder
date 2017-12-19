//
//  Pokemon+CoreDataClass.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/7/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
//

import Foundation
import CoreData
import CloudKit

@objc(Pokemon)
public class Pokemon: NSManagedObject {

    var imageURL: URL? {
        guard let imageEndpoint = imageEndpoint,
            let url = URL(string: imageEndpoint) else {return nil}
        return url
    }
    
    var type1: Type? {
        return Type(rawValue: type1String)
    }
    
    var type2: Type? {
        if let type2String = type2String {
            return Type(rawValue: type2String)
        } else {
            return nil
        }
    }
    
    var nature: Nature? {
        return Nature(rawValue: natureString)
    }
    
    var recordID: CKRecordID? {
        guard let recordIDString = recordIDString else {return nil}
        return CKRecordID(recordName: recordIDString)
    }
    
    var moveIDs: [Int64] {
        return (try? JSONSerialization.jsonObject(with: moveIDsData as Data, options: .allowFragments)) as? [Int64] ?? []
    }
    
    var abilities: [String] {
        return (try? JSONSerialization.jsonObject(with: abilitiesData as Data, options: .allowFragments)) as? [String] ?? []
    }
    
    var weaknessDictionary: typeDictionary? {
        guard let type1 = type1 else {return nil}
        if let type2 = type2 {
            let type1Dictionary = fetchTypeDictionary(fromType: type1)
            let type2Dictionary = fetchTypeDictionary(fromType: type2)
            guard let weaknessDictionary = add(dictionary1: type1Dictionary, toDictionary: type2Dictionary) else {
                print("Could not create a weakness dictionary from type 1 and type 2 dictionaries")
                return nil
            }
            return weaknessDictionary
        } else {
            return fetchTypeDictionary(fromType: type1)
        }
    }
    
    convenience init(name: String, id: Int64, item: String = "None", natureString: String = Nature.gentle.rawValue, moveIDsData: Data, type1String: String, type2String: String?, abilitiesData: Data, role: String = "None", evHP: Int64 = 0, evAttack: Int64 = 0, evDefense: Int64 = 0, evSpecialDefense: Int64 = 0, evSpecialAttack: Int64 = 0, evSpeed: Int64 = 0, ivHP: Int64 = 31, ivAttack: Int64 = 31, ivDefense: Int64 = 31, ivSpecialDefense: Int64 = 31, ivSpecialAttack: Int64 = 31, ivSpeed: Int64 = 31, hpStat: Int64, attackStat: Int64, defenseStat: Int64, spAttackStat: Int64, spDefenseStat: Int64, speedStat: Int64, imageData: Data? = nil, imageEndpoint: String?, context: NSManagedObjectContext = SystemCoreDataStack.context) {
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
    }
    
    convenience init(pokemon: Pokemon, onPokemonTeam pokemonTeam: PokemonTeam, context: NSManagedObjectContext = UserCoreDataStack.context) {
        self.init(context: context)
        self.name = pokemon.name
        self.id = pokemon.id
        self.item = pokemon.item
        self.natureString = pokemon.natureString
        self.moveIDsData = pokemon.moveIDsData as NSData
        self.type1String = pokemon.type1String
        self.type2String = pokemon.type2String
        self.abilitiesData = pokemon.abilitiesData as NSData
        self.role = pokemon.role
        self.evHP = pokemon.evHP
        self.evAttack = pokemon.evAttack
        self.evDefense = pokemon.evDefense
        self.evSpecialAttack = pokemon.evSpecialAttack
        self.evSpecialDefense = pokemon.evSpecialDefense
        self.evSpeed = pokemon.evSpeed
        self.ivHP = pokemon.ivHP
        self.ivAttack = pokemon.ivAttack
        self.ivDefense = pokemon.ivDefense
        self.ivSpecialAttack = pokemon.ivSpecialAttack
        self.ivSpecialDefense = pokemon.ivSpecialDefense
        self.ivSpeed = pokemon.ivSpeed
        self.hpStat = pokemon.hpStat
        self.attackStat = pokemon.attackStat
        self.defenseStat = pokemon.defenseStat
        self.spAttackStat = pokemon.spAttackStat
        self.spDefenseStat = pokemon.spDefenseStat
        self.speedStat = pokemon.speedStat
        self.imageData = pokemon.imageData as NSData?
        self.chosenAbility = pokemon.chosenAbility
        self.move1 = pokemon.move1
        self.move2 = pokemon.move2
        self.move3 = pokemon.move3
        self.move4 = pokemon.move4
        self.moves = pokemon.moves
        self.pokemonTeam = NSSet(array: [pokemonTeam])
    }
    
}


// MARK: - OutDated Code
//    convenience init?(dictionary: [String: Any]) {
//        guard let name = dictionary[Keys.pokemonNameKey] as? String,
//            let id = dictionary[Keys.pokemonIDKey] as? Int64,
//            let movesArray = dictionary[Keys.movesArrayKey] as? [[String: Any]],
//            let typesArray = dictionary[Keys.typesArrayKey] as? [[String: Any]],
//            let abilitiesArray = dictionary[Keys.pokemonAbilitiesKey] as? [[String:Any]],
//            let statsArray = dictionary[Keys.statsArrayKey] as? [[String:Any]],
//            let spritesDictionary = dictionary[Keys.spriteDictionaryKey] as? [String: Any] else {return nil}
//        var type1String: String
//        var type2String: String?
//        if typesArray.count == 2 {
//            let firstTypeDictionary = typesArray[Keys.type1DictionaryInt]
//            guard let type1Dictionary = firstTypeDictionary[Keys.typeDictionaryKey] as? [String: Any],
//                let typeString1 = type1Dictionary[Keys.typeNameKey] as? String else {return nil}
//            type1String = typeString1
//            let secondTypeDictionary = typesArray[Keys.type2DictionaryInt]
//            let type2Dictionary = secondTypeDictionary[Keys.typeDictionaryKey] as? [String: Any] ?? nil
//            let typeString2 = type2Dictionary?[Keys.typeNameKey] as? String ?? nil
//            type2String = typeString2
//        } else {
//            let firstTypeDictionary = typesArray[Keys.type1DictionaryInt]
//            guard let type1Dictionary = firstTypeDictionary[Keys.typeDictionaryKey] as? [String: Any],
//                let typeString1 = type1Dictionary[Keys.typeNameKey] as? String else {return nil}
//            type1String = typeString1
//        }
//        var moveIDs: [Int] = []
//        for dictionary in movesArray {
//            guard let moveDictionary = dictionary[Keys.moveKey] as? [String: Any],
//                let moveString = moveDictionary[Keys.pokemonMoveURL] as? String else {return nil}
//            let id = getNumberIDFromHTTPString(string: moveString)
//            moveIDs.append(id)
//        }
//        guard let moveIDsData = try? JSONSerialization.data(withJSONObject: moveIDs, options: .prettyPrinted) else {return nil}
//        var abilities: [String] = []
//        for everyDictionary in abilitiesArray {
//            guard let abilityDictionary = everyDictionary[Keys.pokemonAbilityKey] as? [String: Any],
//                let ability = abilityDictionary[Keys.abilityNameKey] as? String else {return nil}
//            abilities.append(ability)
//        }
//        guard let abilitiesData = try? JSONSerialization.data(withJSONObject: abilities, options: .prettyPrinted) else {return nil}
//
//        let imageEndpoint = spritesDictionary[Keys.spriteKey] as? String
//
//        let statDictionary = statsArray[Keys.speedStatKeyInt]
//        guard let speedStat = statDictionary[Keys.baseStatKey] as? Int64 else {return nil}
//
//        let spDefStatDictionary = statsArray[Keys.spDefStatKeyInt]
//        guard let spDefStat = spDefStatDictionary[Keys.baseStatKey] as? Int64 else {return nil}
//
//        let spAttStatDictionary = statsArray[Keys.spAttStatKeyInt]
//        guard let spAttStat = spAttStatDictionary[Keys.baseStatKey] as? Int64 else {return nil}
//
//        let defStatDictionary = statsArray[Keys.defStatKeyInt]
//        guard let defStat = defStatDictionary[Keys.baseStatKey] as? Int64 else {return nil}
//
//        let attStatDictionary = statsArray[Keys.attStatKeyInt]
//        guard let attStat = attStatDictionary[Keys.baseStatKey] as? Int64 else {return nil}
//
//        let hpStatDictionary = statsArray[Keys.hpStatKeyInt]
//        guard let hpStat = hpStatDictionary[Keys.baseStatKey] as? Int64 else {return nil}
//
//        self.init(name: name, id: id, moveIDsData: moveIDsData, type1String: type1String, type2String: type2String, abilitiesData: abilitiesData, hpStat: hpStat, attackStat: attStat, defenseStat: defStat, spAttackStat: spAttStat, spDefenseStat: spDefStat, speedStat: speedStat, imageEndpoint: imageEndpoint)
//    }

