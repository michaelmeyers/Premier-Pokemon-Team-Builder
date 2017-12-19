//
//  Move+CoreDataClass.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/8/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Move)
public class Move: NSManagedObject {
    
    var type: Type? {
        guard let typeString = typeString else {return nil}
        return Type(rawValue: typeString)
    }
    
    convenience init(id: Int64, name: String, typeString: String, catagory: String, power: Int64, accuracy: Int64, pp: Int64, moveDescription: String, effectChance: Int64, context: NSManagedObjectContext = SystemCoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.typeString = typeString
        self.catagory = catagory
        self.power = power
        self.accuracy = accuracy
        self.pp = pp
        self.effectChance = effectChance
        //self.methodOfLearning = methodOfLearning
        self.moveDescription = moveDescription
        self.id = id
    }
    
    convenience init?(dictionary: [String: Any], context: NSManagedObjectContext = SystemCoreDataStack.context) {
        self.init(context: context)
        guard let namesArray = dictionary[Keys.namesArrayKey] as? [[String: Any]],
            let id = dictionary[Keys.moveIDKey] as? Int64,
            let typeDictionary = dictionary[Keys.moveTypeDictionaryKey] as? [String: Any],
            let typeString = typeDictionary[Keys.moveTypeKey] as? String,
            let catagoryDictionary = dictionary[Keys.catagoryDictionaryKey] as? [String: Any],
            let catagory = catagoryDictionary[Keys.catagoryNameKey] as? String,
            let pp = dictionary[Keys.movePPKey] as? Int64,
            let effectArray = dictionary[Keys.effectArrayKey] as? [[String: Any]] else {
                return nil
        }
        var power: Int64 = 0
        let powerOptional = dictionary[Keys.movePowerKey] as? Int64
        if powerOptional == nil {
            power = -999
        } else {
            guard let powerOptional = powerOptional else {return}
            power = powerOptional
        }
        
        var accuracy: Int64 = 0
        let accuracyOptional = dictionary[Keys.moveAccuracyKey] as? Int64
        if accuracyOptional == nil {
            accuracy = -999
        } else {
            guard let accuracyOptional = accuracyOptional else {return}
            accuracy = accuracyOptional
        }
        
        var effectChance: Int64 = 0
        let effectChanceOptional = dictionary[Keys.moveEffectChancesKey] as? Int64
        if effectChanceOptional == nil {
            effectChance = -999
        } else {
            guard let effectChanceOptional = effectChanceOptional else {return}
            effectChance = effectChanceOptional
        }
        
        let englishNameDictionary = namesArray[Keys.englishNameDictionaryKey]
        guard let name = englishNameDictionary[Keys.moveNameKey] as? String else {return nil}
        
        let effectDictionary = effectArray[Keys.effectDictionaryKey]
        guard var moveDescription =  effectDictionary[Keys.descriptionKey] as? String else {return nil}
        
        if effectChance != -999 {
            let realDescription = moveDescription.replacingOccurrences(of: "$effect_chance", with: "\(effectChance)")
            moveDescription = realDescription
        }
        
        self.name = name
        self.typeString = typeString
        self.catagory = catagory
        self.power = power
        self.accuracy = accuracy
        self.pp = pp
        self.effectChance = effectChance
        //self.methodOfLearning = methodOfLearning
        self.moveDescription = moveDescription
        self.id = id
    }
}



