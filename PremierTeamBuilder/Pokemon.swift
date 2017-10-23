//
//  Pokemon.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/20/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit

class Pokemon {
    let name: String
    var item: String
    // Want to make a nature ENUM
    var nature: Nature
    var moves: [Move]
    let type1: Type
    let type2: Type?
    var chosenAbility: String?
    let abilities: [String]
    var move1: String?
    var move2: String?
    var move3: String?
    var move4: String?
    var baseStatsDictionary: [String: Any]
    var role: String
//    var weaknessDictioanry: typeDictionary? {
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
    var image: UIImage?
    
    init(name: String, item: String = "None", nature: Nature = Nature.gentle, moves: [Move], type1: Type, type2: Type?, abilities: [String], role: String = "None", baseStatsDictionary: [String: Any], evHP: Int = 0, evAttack: Int = 0, evDefense: Int = 0, evSpecialAttack: Int = 0, evSpecialDefense: Int = 0, evSpeed: Int = 0, ivHP: Int = 0, ivAttack: Int = 0, ivDefense: Int = 0, ivSpecialAttack: Int = 0, ivSpecialDefense: Int = 0, ivSpeed: Int = 0, imageEndpoint: String) {
        self.name = name
        self.item = item
        self.nature = nature
        self.moves = moves
        self.type1 = type1
        self.type2 = type2
        self.abilities = abilities
        self.role = role
        self.baseStatsDictionary = baseStatsDictionary
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
    }
    
    
    
    
    
}
