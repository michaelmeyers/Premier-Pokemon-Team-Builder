//
//  Pokemon.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/20/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class Pokemon {
    
    var pokemonTeamRef: CKReference?
    let name: String
    var item: String
    var nature: Nature
    var moves: [String]
    let type1: Type
    let type2: Type?
    var chosenAbility: String?
    let abilities: [String]
    var move1: String?
    var move2: String?
    var move3: String?
    var move4: String?
    var hpStat: Int
    var attackStat: Int
    var defenseStat: Int
    var spAttackStat: Int
    var spDefenseStat: Int
    var speedStat: Int
    var role: String
    var weaknessDictionary: typeDictionary? {
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
    var evHP: Int
    var evAttack: Int
    var evDefense: Int
    var evSpecialAttack: Int
    var evSpecialDefense: Int
    var evSpeed: Int
    var ivHP: Int
    var ivAttack: Int
    var ivDefense: Int
    var ivSpecialAttack: Int
    var ivSpecialDefense: Int
    var ivSpeed: Int
    let imageEndpoint: String
    var imageURL: URL? {
        guard let url = URL(string: Keys.baseURLString)?.appendingPathExtension(imageEndpoint) else {return nil}
        return url
    }
    var imageData: Data? 
    var recordID: CKRecordID?
    
    init(name: String, item: String = "None", nature: Nature = Nature.gentle, moves: [String], type1: Type, type2: Type?, abilities: [String], role: String = "None", evHP: Int = 0, evAttack: Int = 0, evDefense: Int = 0, evSpecialDefense: Int = 0, evSpecialAttack: Int = 0, evSpeed: Int = 0, ivHP: Int = 0, ivAttack: Int = 0, ivDefense: Int = 0, ivSpecialDefense: Int = 0, ivSpecialAttack: Int = 0, ivSpeed: Int = 0, imageEndpoint: String, hpStat: Int, attackStat: Int, defenseStat: Int, spAttackStat: Int, spDefenseStat: Int, speedStat: Int ) {
        self.name = name
        self.item = item
        self.nature = nature
        self.moves = moves
        self.type1 = type1
        self.type2 = type2
        self.abilities = abilities
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
        self.imageEndpoint = imageEndpoint
        self.hpStat = hpStat
        self.attackStat = attackStat
        self.defenseStat = defenseStat
        self.spAttackStat = spAttackStat
        self.spDefenseStat = spDefenseStat
        self.speedStat = speedStat
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let name = dictionary[Keys.pokemonNameKey] as? String,
            let movesArray = dictionary[Keys.movesArrayKey] as? [[String: Any]],
            let typesArray = dictionary[Keys.typesArrayKey] as? [[String: Any]],
            let abilitiesArray = dictionary[Keys.pokemonAbilitiesKey] as? [[String:Any]],
            let statsArray = dictionary[Keys.statsArrayKey] as? [[String:Any]],
            let spritesDictionary = dictionary[Keys.spriteDictionaryKey] as? [String: Any],
            let imageEndpoint = spritesDictionary[Keys.spriteKey] as? String else {return nil}
        var type1: Type
        var type2: Type?
        if typesArray.count == 2 {
        let firstTypeDictionary = typesArray[Keys.type1DictionaryInt]
        guard let type1Dictionary = firstTypeDictionary[Keys.typeDictionaryKey] as? [String: Any],
        let type1String = type1Dictionary[Keys.typeNameKey] as? String,
            let type = changeStringToType(string: type1String) else {return nil}
            type1 = type
        
        let secondTypeDictionary = typesArray[Keys.type2DictionaryInt]
        let type2Dictionary = secondTypeDictionary[Keys.typeDictionaryKey] as? [String: Any] ?? nil
        let type2String = type2Dictionary?[Keys.typeNameKey] as? String ?? nil
        if let type2String = type2String {
            guard let type = changeStringToType(string: type2String) else {return nil}
            type2 = type
        } else {
            type2 = nil
        }
        } else {
            let firstTypeDictionary = typesArray[Keys.type1DictionaryInt]
            guard let type1Dictionary = firstTypeDictionary[Keys.typeDictionaryKey] as? [String: Any],
                let type1String = type1Dictionary[Keys.typeNameKey] as? String,
                let type = changeStringToType(string: type1String) else {return nil}
            type1 = type
        }
        var moves: [String] = []
        for dictionary in movesArray {
            guard let moveDictionary = dictionary[Keys.moveKey] as? [String: Any],
                let moveString = moveDictionary[Keys.pokemonMoveNameKey] as? String else {return nil}
            moves.append(moveString)
        }
        var abilities: [String] = []
        for everyDictionary in abilitiesArray {
            guard let abilityDictionary = everyDictionary[Keys.pokemonAbilityKey] as? [String: Any],
                let ability = abilityDictionary[Keys.abilityNameKey] as? String else {return nil}
            abilities.append(ability)
        }
        
        let statDictionary = statsArray[Keys.speedStatKeyInt]
        guard let speedStat = statDictionary[Keys.baseStatKey] as? Int else {return nil}
        
        let spDefStatDictionary = statsArray[Keys.spDefStatKeyInt]
        guard let spDefStat = spDefStatDictionary[Keys.baseStatKey] as? Int else {return nil}
        
        let spAttStatDictionary = statsArray[Keys.spAttStatKeyInt]
        guard let spAttStat = spAttStatDictionary[Keys.baseStatKey] as? Int else {return nil}
        
        let defStatDictionary = statsArray[Keys.defStatKeyInt]
        guard let defStat = defStatDictionary[Keys.baseStatKey] as? Int else {return nil}
        
        let attStatDictionary = statsArray[Keys.attStatKeyInt]
        guard let attStat = attStatDictionary[Keys.baseStatKey] as? Int else {return nil}
        
        let hpStatDictionary = statsArray[Keys.hpStatKeyInt]
        guard let hpStat = hpStatDictionary[Keys.baseStatKey] as? Int else {return nil}

        
        self.init(name: name, moves: moves, type1: type1, type2: type2, abilities: abilities, imageEndpoint: imageEndpoint, hpStat: hpStat, attackStat: attStat, defenseStat: defStat, spAttackStat: spAttStat, spDefenseStat: spDefStat, speedStat: speedStat)
    }
}






























