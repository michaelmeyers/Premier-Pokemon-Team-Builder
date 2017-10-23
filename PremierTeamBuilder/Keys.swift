//
//  Keys.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

struct Keys {
    
    static let baseURLString = "https://pokeapi.co/api/v2"
    
    // Type Keys
    static let typeNormalKey = "normal"
    static let typeFireKey = "fire"
    static let typeWaterKey = "water"
    static let typeElectricKey = "electric"
    static let typeGrassKey = "grass"
    static let typeIceKey = "ice"
    static let typeFightingKey = "fighting"
    static let typePoisonKey = "poison"
    static let typeGroundKey = "ground"
    static let typeFlyingKey = "flying"
    static let typePsychicKey = "psychic"
    static let typeBugKey = "bug"
    static let typeRockKey = "rock"
    static let typeGhostKey = "ghost"
    static let typeDragonKey = "dragon"
    static let typeDarkKey = "dark"
    static let typeSteelKey = "steel"
    static let typeFairyKey = "fairy"
    
    //Moves Parsing Json Keys
    static let namesArrayKey = "names"
    static let englishNameDictionaryKey = 0
    static let moveNameKey = "name"
    static let moveTypeDictionaryKey = "type"
    static let moveTypeKey = "name"
    static let catagoryDictionaryKey = "damage_class"
    static let catagoryNameKey = "name"
    static let movePowerKey = "power"
    static let moveAccuracyKey = "accuracy"
    static let movePPKey = "pp"
    static let effectArrayKey = "effect_entries"
    static let effectDictionaryKey = 0
    static let descriptionKey = "short_effect"
}
