////
////  Pokemon.swift
////  PremierTeamBuilder
////
////  Created by Michael Meyers on 10/20/17.
////  Copyright © 2017 Michael Meyers. All rights reserved.
////
//
//import Foundation
//import UIKit
//import CloudKit
//
//extension Pokemon {
//    var pokemonTeamRef: CKReference?  // WHAT TO DO WITH THIS???
//    //    let name: String
//    //    var item: String
//    //    var nature: Nature
//    //    var moveIDs: [Int]  // Store as JSON adn then use jsonserialization to format it back as an Array
//    //    let type1String: String
//    //    let type2String: String?
//    //    var chosenAbility: String?
//    //    let abilities: [String]
//    //    var move1: String?
//    //    var move2: String?
//    //    var move3: String?
//    //    var move4: String?
//    //    var hpStat: Int
//    //    var attackStat: Int
//    //    var defenseStat: Int
//    //    var spAttackStat: Int
//    //    var spDefenseStat: Int
//    //    var speedStat: Int
//    //    var role: String
//    //    var evHP: Int
//    //    var evAttack: Int
//    //    var evDefense: Int
//    //    var evSpecialAttack: Int
//    //    var evSpecialDefense: Int
//    //    var evSpeed: Int
//    //    var ivHP: Int
//    //    var ivAttack: Int
//    //    var ivDefense: Int
//    //    var ivSpecialAttack: Int
//    //    var ivSpecialDefense: Int
//    //    var ivSpeed: Int
//    //    let imageEndpoint: String?
//    //    var imageData: Data?
//    //    var recordID: CKRecordID?
//    //    var moves: [Move]?
//    
//    
//    var imageURL: URL? {
//        guard let imageEndpoint = imageEndpoint,
//            let url = URL(string: imageEndpoint) else {return nil}
//        return url
//    }
//    
//    var type1: Type? {
//        return Type(rawValue: type1String)  // THIS SHOULD NOT BE OPTIONAL
//    }
//    
//    var type2: Type? {
//        if let type2String = type2String {
//            return Type(rawValue: type2String)
//        }
//    }
//    var nature: Nature {
//        return Nature(rawValue: natureString)
//    }
//    
//    var pokemonTeamRef: CKReference {
//        return pokemonTeamRefString as? CKReference
//    }
//    
//    var recordID: CKRecordID {
//        return recordIDString as? CKRecordID
//    }
//    
//    var moveIDs: [Move]? {
//        return try? JSONSerialization.jsonObject(with: moveIDsData, options: .allowFragments) as? [Move]
//    }
//    
//    var abilities: [String] {
//        return try? JSONSerialization.jsonObject(with: abilitiesData, options: .allowFragments) as? [String]
//    }
//    
//    var weaknessDictionary: typeDictionary? {
//        guard let type1 = type1 else {return nil}
//        if let type2 = type2 {
//            let type1Dictionary = fetchTypeDictionary(fromType: type1)
//            let type2Dictionary = fetchTypeDictionary(fromType: type2)
//            guard let weaknessDictionary = add(dictionary1: type1Dictionary, toDictionary: type2Dictionary) else {
//                print("Could not create a weakness dictionary from type 1 and type 2 dictionaries")
//                return nil
//            }
//            return weaknessDictionary
//        } else {
//            return fetchTypeDictionary(fromType: type1)
//        }
//    }
//    
//    convenience  init(name: String, item: String = "None", natureString: String = Nature.gentle.rawValue, moveIDs: [Int], type1String: String, type2String: String, abilities: [String], role: String = "None", evHP: Int = 0, evAttack: Int = 0, evDefense: Int = 0, evSpecialDefense: Int64 = 0, evSpecialAttack: Int64 = 0, evSpeed: Int64 = 0, ivHP: Int64 = 31, ivAttack: Int64 = 31, ivDefense: Int64 = 31, ivSpecialDefense: Int64 = 31, ivSpecialAttack: Int64 = 31, ivSpeed: Int64 = 31, hpStat: Int64, attackStat: Int64, defenseStat: Int64, spAttackStat: Int64, spDefenseStat: Int64, speedStat: Int64, imageData: Data? = nil, imageEndpoint: String? ) {
//        self.name = name
//        self.item = item
//        self.natureString = natureString
//        self.moveIDs = moveIDs
//        self.type1String = type1String
//        self.type2String = type2String
//        self.abilities = abilities
//        self.role = role
//        self.evHP = evHP
//        self.evAttack = evAttack
//        self.evDefense = evDefense
//        self.evSpecialAttack = evSpecialAttack
//        self.evSpecialDefense = evSpecialDefense
//        self.evSpeed = evSpeed
//        self.ivHP = ivHP
//        self.ivAttack = ivAttack
//        self.ivDefense = ivDefense
//        self.ivSpecialAttack = ivSpecialAttack
//        self.ivSpecialDefense = ivSpecialDefense
//        self.ivSpeed = ivSpeed
//        self.hpStat = hpStat
//        self.attackStat = attackStat
//        self.defenseStat = defenseStat
//        self.spAttackStat = spAttackStat
//        self.spDefenseStat = spDefenseStat
//        self.speedStat = speedStat
//        self.imageData = imageData
//        self.imageEndpoint = imageEndpoint
//    }
//    
//    convenience init?(dictionary: [String: Any]) {
//        guard let name = dictionary[Keys.pokemonNameKey] as? String,
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
//        let moveIDsData = try? JSONSerialization.data(withJSONObject: moveIDs, options: .prettyPrinted)
//        var abilities: [String] = []
//        for everyDictionary in abilitiesArray {
//            guard let abilityDictionary = everyDictionary[Keys.pokemonAbilityKey] as? [String: Any],
//                let ability = abilityDictionary[Keys.abilityNameKey] as? String else {return nil}
//            abilities.append(ability)
//        }
//        let abilitiesData = try? JSONSerialization.data(withJSONObject: abilities, options: .prettyPrinted)
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
//        
//    }
//    
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
