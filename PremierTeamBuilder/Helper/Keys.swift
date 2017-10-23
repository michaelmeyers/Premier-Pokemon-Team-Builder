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
    static let itemBaseURLString = "https://pokeapi.co/api/v2/item-attribute/holdable-active"
    
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
    
    //Moves Parsing JSON Keys
    static let moveKey = "move"
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
    
    //Pokemon Parsing JSON Keys
    static let pokemonNameKey = "names"
    static let movesArrayKey = "moves"
    static let pokemonMoveNameKey = "name"
    static let typesArrayKey = "types"
    static let type1DictionaryInt = 0
    static let type2DictionaryInt = 1
    static let typeNameKey = "name"
    static let typeDictionaryKey = "type"
    static let pokemonAbilitiesKey = "abilities"
    static let pokemonAbilityKey = "ability"
    static let abilityNameKey = "name"
    static let statsArrayKey = "stats"
    static let speedStatKeyInt = 0
    static let spDefStatKeyInt = 1
    static let spAttStatKeyInt = 2
    static let defStatKeyInt = 3
    static let attStatKeyInt = 4
    static let hpStatKeyInt = 5
    static let baseStatKey = "base_stat"
    static let speedKey = "speed"
    static let spDefKey = "specialDefense"
    static let spAttKey = "specialAttack"
    static let defKey = "defense"
    static let attKey = "attack"
    static let hpKey = "hitPoints"
    static let spriteDictionaryKey = "sprites"
    static let spriteKey = "front_default"
}
