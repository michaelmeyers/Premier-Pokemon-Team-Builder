//
//  Move.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/20/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit


//extension Move {
//    //    let id: Int
//    //    let name: String
//    //    let typeString: String
//    //    let catagory: String
//    //    let power: Int?
//    //    let accuracy: Int?
//    //    let pp : Int
//    ////    let methodOfLearning: String
//    //    let description: String
//    //    let effectChance: Int?
//    var type: Type? {
//        return Type(rawValue: typeString)
//    }
//    
//    convenience init(id: Int, name: String, typeString: String, catagory: String, power: Int?, accuracy: Int?, pp: Int, description: String, effectChance: Int?) {
//        self.name = name
//        self.typeString = typeString
//        self.catagory = catagory
//        self.power = power
//        self.accuracy = accuracy
//        self.pp = pp
//        self.effectChance = effectChance
//        //        self.methodOfLearning = methodOfLearning
//        self.description = description
//        self.id = id
//    }
//    
//    convenience init?(dictionary: [String: Any]) {
//        guard let namesArray = dictionary[Keys.namesArrayKey] as? [[String: Any]],
//            let id = dictionary[Keys.moveIDKey] as? Int,
//            let typeDictionary = dictionary[Keys.moveTypeDictionaryKey] as? [String: Any],
//            let typeString = typeDictionary[Keys.moveTypeKey] as? String,
//            let catagoryDictionary = dictionary[Keys.catagoryDictionaryKey] as? [String: Any],
//            let catagory = catagoryDictionary[Keys.catagoryNameKey] as? String,
//            let pp = dictionary[Keys.movePPKey] as? Int,
//            let effectArray = dictionary[Keys.effectArrayKey] as? [[String: Any]] else {
//                return nil
//        }
//        let power = dictionary[Keys.movePowerKey] as? Int
//        let accuracy = dictionary[Keys.moveAccuracyKey] as? Int
//        let effectChance = dictionary[Keys.moveEffectChancesKey] as? Int
//        
//        let englishNameDictionary = namesArray[Keys.englishNameDictionaryKey]
//        guard let name = englishNameDictionary[Keys.moveNameKey] as? String else {return nil}
//        
//        let effectDictionary = effectArray[Keys.effectDictionaryKey]
//        guard var moveDescription =  effectDictionary[Keys.descriptionKey] as? String else {return nil}
//        
//        if let effectChance = effectChance{
//            let realDescription = description.replacingOccurrences(of: "$effect_chance", with: "\(effectChance)")
//            moveDescription = realDescription
//        }
//        self.id = id
//        self.name = name
//        self.typeString = typeString
//        self.catagory = catagory
//        self.power = power
//        self.accuracy = accuracy
//        self.pp = pp
//        self.moveDescription = moveDescription
//        self.effectChance = effectChance
//    }
//}










