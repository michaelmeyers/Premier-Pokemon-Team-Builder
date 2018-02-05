//
//  Move.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/20/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

class Move {
    let name: String
    let type: Type
    let catagory: String
    let power: Int?
    let accuracy: Int?
    let pp : Int
//    let methodOfLearning: String
    let description: String
    let effectChance: Int?
    
    init(name: String, type: Type, catagory: String, power: Int?, accuracy: Int?, pp: Int, description: String, effectChance: Int?) {
        self.name = name
        self.type = type
        self.catagory = catagory
        self.power = power
        self.accuracy = accuracy
        self.pp = pp
        self.effectChance = effectChance
//        self.methodOfLearning = methodOfLearning
        self.description = description
    }
    
    convenience init?(dictionary: [String: Any]) {
        guard let namesArray = dictionary[Keys.namesArrayKey] as? [[String: Any]],
            let typeDictionary = dictionary[Keys.moveTypeDictionaryKey] as? [String: Any],
            let typeString = typeDictionary[Keys.moveTypeKey] as? String,
            let type = changeStringToType(string: typeString),
            let catagoryDictionary = dictionary[Keys.catagoryDictionaryKey] as? [String: Any],
            let catagory = catagoryDictionary[Keys.catagoryNameKey] as? String,
            let pp = dictionary[Keys.movePPKey] as? Int,
            let effectArray = dictionary[Keys.effectArrayKey] as? [[String: Any]] else {
                return nil
        }
        let power = dictionary[Keys.movePowerKey] as? Int
        let accuracy = dictionary[Keys.moveAccuracyKey] as? Int
        let effectChance = dictionary[Keys.moveEffectChancesKey] as? Int
        
        let englishNameDictionary = namesArray[Keys.englishNameDictionaryKey]
        guard let name = englishNameDictionary[Keys.moveNameKey] as? String else {return nil}
        
        let effectDictionary = effectArray[Keys.effectDictionaryKey]
        guard var description =  effectDictionary[Keys.descriptionKey] as? String else {return nil}

        if let effectChance = effectChance{
            let realDescription = description.replacingOccurrences(of: "$effect_chance", with: "\(effectChance)")
            description = realDescription
        }
        
        self.init(name: name, type: type, catagory: catagory, power: power, accuracy: accuracy, pp: pp, description: description, effectChance: effectChance)
    }
}










