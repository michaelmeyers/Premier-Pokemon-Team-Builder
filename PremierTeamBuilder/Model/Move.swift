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
    let power: Int
    let accuracy: Int
    let pp : Int
//    let methodOfLearning: String
    let description: String
//    let effectChanges: String?
    
    init(name: String, type: Type, catagory: String, power: Int, accuracy: Int, pp: Int, description: String) {
        self.name = name
        self.type = type
        self.catagory = catagory
        self.power = power
        self.accuracy = accuracy
        self.pp = pp
//        self.methodOfLearning = methodOfLearning
        self.description = description
    }
    
    convenience init?(dicitionary: [String: Any]) {
        guard let namesArray = dicitionary[Keys.namesArrayKey] as? [[String: Any]],
            
            let typeDictionary = dicitionary[Keys.moveTypeDictionaryKey] as? [String: Any],
            let type = typeDictionary[Keys.moveTypeKey] as? Type,
            let catagoryDictionary = dicitionary[Keys.catagoryDictionaryKey] as? [String: Any],
            let catagory = catagoryDictionary[Keys.catagoryNameKey] as? String,
            let power = dicitionary[Keys.movePowerKey] as? Int,
            let accuracy = dicitionary[Keys.moveAccuracyKey] as? Int,
            let pp = dicitionary[Keys.movePPKey] as? Int,
            let effectArray = dicitionary[Keys.effectArrayKey] as? [[String: Any]] else {return nil}
            
        
        let englishNameDictionary = namesArray[Keys.englishNameDictionaryKey]
        guard let name = englishNameDictionary[Keys.moveNameKey] as? String else {return nil}
        
        let effectDictionary = effectArray[Keys.effectDictionaryKey]
        guard let description =  effectDictionary[Keys.descriptionKey] as? String else {return nil}

        self.init(name: name, type: type, catagory: catagory, power: power, accuracy: accuracy, pp: pp, description: description)
    }
}
