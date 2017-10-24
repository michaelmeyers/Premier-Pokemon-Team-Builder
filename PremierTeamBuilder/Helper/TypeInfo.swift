//
//  TypeInfo.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

//
//  Info.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation


//: Playground - noun: a place where people can play

import UIKit

// Need a Role Enum
// Need an Item Enum
// Method of Learning Enum

enum Role{
    case none
    case specialSweeper
    case physicalSweeper
    case setUpSweeper
    case physicalWall
    case specialWall
    case mixedAttacker
    case mixedWall
    case bulkyPhysicalAttacker
    case bulkySpecialAttack
}

enum Nature: String{
    case attack
    case bashful
    case bold
    case brave
    case calm
    case careful
    case docile
    case gentle
    case hardy
    case hasty
    case impish
    case jolly
    case lax
    case lonely
    case mild
    case modest
    case naive
    case naughty
    case quiet
    case quirky
    case rash
    case relaxed
    case sassy
    case serious
    case timid
}

enum Type: String{
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
}

public let typesKeyArray = [Keys.typeNormalKey,
                            Keys.typeFireKey,
                            Keys.typeWaterKey,
                            Keys.typeElectricKey,
                            Keys.typeGrassKey,
                            Keys.typeIceKey,
                            Keys.typeFightingKey,
                            Keys.typePoisonKey,
                            Keys.typeGroundKey,
                            Keys.typeFlyingKey,
                            Keys.typePsychicKey,
                            Keys.typeBugKey,
                            Keys.typeRockKey,
                            Keys.typeGhostKey,
                            Keys.typeDragonKey,
                            Keys.typeDarkKey,
                            Keys.typeSteelKey,
                            Keys.typeFairyKey]

public typealias typeDictionary = [String: Double]

public func add(dictionary1: typeDictionary, toDictionary dictionary2: typeDictionary) -> typeDictionary? {
    var dictionary: typeDictionary = [:]
    for key in dictionary1.keys {
        let keyString = "\(key)"
        guard let double1 = dictionary1[key],
            let double2 = dictionary2[key] else {return nil}
        dictionary[keyString] = double1 * double2
    }
    return dictionary
}

let typeDictionaries: [String: [String: Double]] = [Keys.typeNormalKey: normalDictionary,
                                                  Keys.typeFireKey: fireDictionary,
                                                  Keys.typeWaterKey: waterDictionary,
                                                  Keys.typeElectricKey: electricDictionary,
                                                  Keys.typeGrassKey: grassDictionary,
                                                  Keys.typeIceKey: iceDictionary,
                                                  Keys.typeFightingKey: fightingDictionary,
                                                  Keys.typePoisonKey: poisonDictionary,
                                                  Keys.typeGroundKey: groundDictionary,
                                                  Keys.typeFlyingKey: flyingDictionary,
                                                  Keys.typePsychicKey: psychicDictionary,
                                                  Keys.typeBugKey: bugDictionary,
                                                  Keys.typeRockKey: rockDictionary,
                                                  Keys.typeGhostKey: ghostDictionary,
                                                  Keys.typeDragonKey: dragonDictionary,
                                                  Keys.typeDarkKey: darkDictionary,
                                                  Keys.typeSteelKey: steelDictionary,
                                                  Keys.typeFairyKey: fairyDictionary]

let normalDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                          Keys.typeFireKey: 1.0,
                                          Keys.typeWaterKey: 1.0,
                                          Keys.typeElectricKey: 1.0,
                                          Keys.typeGrassKey: 1.0,
                                          Keys.typeIceKey: 1.0,
                                          Keys.typeFightingKey: 2.0,
                                          Keys.typePoisonKey: 1.0,
                                          Keys.typeGroundKey: 1.0,
                                          Keys.typeFlyingKey: 1.0,
                                          Keys.typePsychicKey: 1.0,
                                          Keys.typeBugKey: 1.0,
                                          Keys.typeRockKey: 1.0,
                                          Keys.typeGhostKey: 0.0,
                                          Keys.typeDragonKey: 1.0,
                                          Keys.typeDarkKey: 1.0,
                                          Keys.typeSteelKey: 1.0,
                                          Keys.typeFairyKey: 1.0]

let fireDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                        Keys.typeFireKey: 0.5,
                                        Keys.typeWaterKey: 2.0,
                                        Keys.typeElectricKey: 1.0,
                                        Keys.typeGrassKey: 0.5,
                                        Keys.typeIceKey: 0.5,
                                        Keys.typeFightingKey: 1.0,
                                        Keys.typePoisonKey: 1.0,
                                        Keys.typeGroundKey: 2.0,
                                        Keys.typeFlyingKey: 1.0,
                                        Keys.typePsychicKey: 1.0,
                                        Keys.typeBugKey: 0.5,
                                        Keys.typeRockKey: 2.0,
                                        Keys.typeGhostKey: 1.0,
                                        Keys.typeDragonKey: 1.0,
                                        Keys.typeDarkKey: 1.0,
                                        Keys.typeSteelKey: 0.5,
                                        Keys.typeFairyKey: 0.5]

let waterDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                         Keys.typeFireKey: 0.5,
                                         Keys.typeWaterKey: 0.5,
                                         Keys.typeElectricKey: 2.0,
                                         Keys.typeGrassKey: 2.0,
                                         Keys.typeIceKey: 0.5,
                                         Keys.typeFightingKey: 1.0,
                                         Keys.typePoisonKey: 1.0,
                                         Keys.typeGroundKey: 1.0,
                                         Keys.typeFlyingKey: 1.0,
                                         Keys.typePsychicKey: 1.0,
                                         Keys.typeBugKey: 1.0,
                                         Keys.typeRockKey: 1.0,
                                         Keys.typeGhostKey: 0,
                                         Keys.typeDragonKey: 1.0,
                                         Keys.typeDarkKey: 1.0,
                                         Keys.typeSteelKey: 0.5,
                                         Keys.typeFairyKey: 1.0]

let electricDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                            Keys.typeFireKey: 1.0,
                                            Keys.typeWaterKey: 1.0,
                                            Keys.typeElectricKey: 0.5,
                                            Keys.typeGrassKey: 1.0,
                                            Keys.typeIceKey: 1.0,
                                            Keys.typeFightingKey: 1.0,
                                            Keys.typePoisonKey: 1.0,
                                            Keys.typeGroundKey: 2.0,
                                            Keys.typeFlyingKey: 0.5,
                                            Keys.typePsychicKey: 1.0,
                                            Keys.typeBugKey: 1.0,
                                            Keys.typeRockKey: 1.0,
                                            Keys.typeGhostKey: 1.0,
                                            Keys.typeDragonKey: 1.0,
                                            Keys.typeDarkKey: 1.0,
                                            Keys.typeSteelKey: 0.5,
                                            Keys.typeFairyKey: 1.0]

let grassDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                         Keys.typeFireKey: 2.0,
                                         Keys.typeWaterKey: 0.5,
                                         Keys.typeElectricKey: 0.5,
                                         Keys.typeGrassKey: 0.5,
                                         Keys.typeIceKey: 2.0,
                                         Keys.typeFightingKey: 1.0,
                                         Keys.typePoisonKey: 2.0,
                                         Keys.typeGroundKey: 0.5,
                                         Keys.typeFlyingKey: 2.0,
                                         Keys.typePsychicKey: 1.0,
                                         Keys.typeBugKey: 2.0,
                                         Keys.typeRockKey: 1.0,
                                         Keys.typeGhostKey: 1.0,
                                         Keys.typeDragonKey: 1.0,
                                         Keys.typeDarkKey: 1.0,
                                         Keys.typeSteelKey: 1.0,
                                         Keys.typeFairyKey: 1.0]

let iceDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                       Keys.typeFireKey: 2.0,
                                       Keys.typeWaterKey: 1.0,
                                       Keys.typeElectricKey: 1.0,
                                       Keys.typeGrassKey: 1.0,
                                       Keys.typeIceKey: 0.5,
                                       Keys.typeFightingKey: 2.0,
                                       Keys.typePoisonKey: 1.0,
                                       Keys.typeGroundKey: 1.0,
                                       Keys.typeFlyingKey: 1.0,
                                       Keys.typePsychicKey: 1.0,
                                       Keys.typeBugKey: 1.0,
                                       Keys.typeRockKey: 2.0,
                                       Keys.typeGhostKey: 1.0,
                                       Keys.typeDragonKey: 1.0,
                                       Keys.typeDarkKey: 1.0,
                                       Keys.typeSteelKey: 2.0,
                                       Keys.typeFairyKey: 1.0]

let fightingDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                            Keys.typeFireKey: 1.0,
                                            Keys.typeWaterKey: 1.0,
                                            Keys.typeElectricKey: 1.0,
                                            Keys.typeGrassKey: 1.0,
                                            Keys.typeIceKey: 1.0,
                                            Keys.typeFightingKey: 1.0,
                                            Keys.typePoisonKey: 1.0,
                                            Keys.typeGroundKey: 1.0,
                                            Keys.typeFlyingKey: 2.0,
                                            Keys.typePsychicKey: 2.0,
                                            Keys.typeBugKey: 0.5,
                                            Keys.typeRockKey: 0.5,
                                            Keys.typeGhostKey: 1.0,
                                            Keys.typeDragonKey: 1.0,
                                            Keys.typeDarkKey: 0.5,
                                            Keys.typeSteelKey: 1.0,
                                            Keys.typeFairyKey: 2.0]

let poisonDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                          Keys.typeFireKey: 1.0,
                                          Keys.typeWaterKey: 1.0,
                                          Keys.typeElectricKey: 1.0,
                                          Keys.typeGrassKey: 0.5,
                                          Keys.typeIceKey: 1.0,
                                          Keys.typeFightingKey: 0.5,
                                          Keys.typePoisonKey: 0.5,
                                          Keys.typeGroundKey: 2.0,
                                          Keys.typeFlyingKey: 1.0,
                                          Keys.typePsychicKey: 2.0,
                                          Keys.typeBugKey: 0.5,
                                          Keys.typeRockKey: 1.0,
                                          Keys.typeGhostKey: 1.0,
                                          Keys.typeDragonKey: 1.0,
                                          Keys.typeDarkKey: 1.0,
                                          Keys.typeSteelKey: 1.0,
                                          Keys.typeFairyKey: 0.5]

let groundDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                          Keys.typeFireKey: 1.0,
                                          Keys.typeWaterKey: 2.0,
                                          Keys.typeElectricKey: 0.0,
                                          Keys.typeGrassKey: 2.0,
                                          Keys.typeIceKey: 2.0,
                                          Keys.typeFightingKey: 1.0,
                                          Keys.typePoisonKey: 0.5,
                                          Keys.typeGroundKey: 1.0,
                                          Keys.typeFlyingKey: 1.0,
                                          Keys.typePsychicKey: 1.0,
                                          Keys.typeBugKey: 1.0,
                                          Keys.typeRockKey: 0.5,
                                          Keys.typeGhostKey: 1.0,
                                          Keys.typeDragonKey: 1.0,
                                          Keys.typeDarkKey: 1.0,
                                          Keys.typeSteelKey: 1.0,
                                          Keys.typeFairyKey: 1.0]

let flyingDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                          Keys.typeFireKey: 1.0,
                                          Keys.typeWaterKey: 1.0,
                                          Keys.typeElectricKey: 2.0,
                                          Keys.typeGrassKey: 0.5,
                                          Keys.typeIceKey: 2.0,
                                          Keys.typeFightingKey: 0.5,
                                          Keys.typePoisonKey: 1.0,
                                          Keys.typeGroundKey: 0.0,
                                          Keys.typeFlyingKey: 1.0,
                                          Keys.typePsychicKey: 1.0,
                                          Keys.typeBugKey: 0.5,
                                          Keys.typeRockKey: 2.0,
                                          Keys.typeGhostKey: 1.0,
                                          Keys.typeDragonKey: 1.0,
                                          Keys.typeDarkKey: 1.0,
                                          Keys.typeSteelKey: 1.0,
                                          Keys.typeFairyKey: 1.0]

let psychicDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                           Keys.typeFireKey: 1.0,
                                           Keys.typeWaterKey: 1.0,
                                           Keys.typeElectricKey: 1.0,
                                           Keys.typeGrassKey: 1.0,
                                           Keys.typeIceKey: 1.0,
                                           Keys.typeFightingKey: 0.5,
                                           Keys.typePoisonKey: 1.0,
                                           Keys.typeGroundKey: 1.0,
                                           Keys.typeFlyingKey: 1.0,
                                           Keys.typePsychicKey: 0.5,
                                           Keys.typeBugKey: 2.0,
                                           Keys.typeRockKey: 1.0,
                                           Keys.typeGhostKey: 2.0,
                                           Keys.typeDragonKey: 1.0,
                                           Keys.typeDarkKey: 2.0,
                                           Keys.typeSteelKey: 1.0,
                                           Keys.typeFairyKey: 1.0]

let bugDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                       Keys.typeFireKey: 2.0,
                                       Keys.typeWaterKey: 1.0,
                                       Keys.typeElectricKey: 1.0,
                                       Keys.typeGrassKey: 0.5,
                                       Keys.typeIceKey: 1.0,
                                       Keys.typeFightingKey: 0.5,
                                       Keys.typePoisonKey: 1.0,
                                       Keys.typeGroundKey: 0.5,
                                       Keys.typeFlyingKey: 2.0,
                                       Keys.typePsychicKey: 1.0,
                                       Keys.typeBugKey: 1.0,
                                       Keys.typeRockKey: 2.0,
                                       Keys.typeGhostKey: 1.0,
                                       Keys.typeDragonKey: 1.0,
                                       Keys.typeDarkKey: 1.0,
                                       Keys.typeSteelKey: 1.0,
                                       Keys.typeFairyKey: 1.0]

let rockDictionary: [String: Double] = [Keys.typeNormalKey: 0.5,
                                        Keys.typeFireKey: 0.5,
                                        Keys.typeWaterKey: 2.0,
                                        Keys.typeElectricKey: 1.0,
                                        Keys.typeGrassKey: 2.0,
                                        Keys.typeIceKey: 1.0,
                                        Keys.typeFightingKey: 2.0,
                                        Keys.typePoisonKey: 0.5,
                                        Keys.typeGroundKey: 2.0,
                                        Keys.typeFlyingKey: 0.5,
                                        Keys.typePsychicKey: 1.0,
                                        Keys.typeBugKey: 1.0,
                                        Keys.typeRockKey: 1.0,
                                        Keys.typeGhostKey: 1.0,
                                        Keys.typeDragonKey: 1.0,
                                        Keys.typeDarkKey: 1.0,
                                        Keys.typeSteelKey: 2.0,
                                        Keys.typeFairyKey: 1.0]

let ghostDictionary: [String: Double] = [Keys.typeNormalKey: 0.0,
                                         Keys.typeFireKey: 1.0,
                                         Keys.typeWaterKey: 1.0,
                                         Keys.typeElectricKey: 1.0,
                                         Keys.typeGrassKey: 1.0,
                                         Keys.typeIceKey: 1.0,
                                         Keys.typeFightingKey: 0.0,
                                         Keys.typePoisonKey: 0.5,
                                         Keys.typeGroundKey: 1.0,
                                         Keys.typeFlyingKey: 1.0,
                                         Keys.typePsychicKey: 1.0,
                                         Keys.typeBugKey: 0.5,
                                         Keys.typeRockKey: 1.0,
                                         Keys.typeGhostKey: 2.0,
                                         Keys.typeDragonKey: 1.0,
                                         Keys.typeDarkKey: 2.0,
                                         Keys.typeSteelKey: 1.0,
                                         Keys.typeFairyKey: 1.0]

let dragonDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                          Keys.typeFireKey: 0.5,
                                          Keys.typeWaterKey: 0.5,
                                          Keys.typeElectricKey: 0.5,
                                          Keys.typeGrassKey: 0.5,
                                          Keys.typeIceKey: 2.0,
                                          Keys.typeFightingKey: 1.0,
                                          Keys.typePoisonKey: 1.0,
                                          Keys.typeGroundKey: 1.0,
                                          Keys.typeFlyingKey: 1.0,
                                          Keys.typePsychicKey: 1.0,
                                          Keys.typeBugKey: 1.0,
                                          Keys.typeRockKey: 1.0,
                                          Keys.typeGhostKey: 1.0,
                                          Keys.typeDragonKey: 2.0,
                                          Keys.typeDarkKey: 1.0,
                                          Keys.typeSteelKey: 1.0,
                                          Keys.typeFairyKey: 2.0]

let darkDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                        Keys.typeFireKey: 1.0,
                                        Keys.typeWaterKey: 1.0,
                                        Keys.typeElectricKey: 1.0,
                                        Keys.typeGrassKey: 1.0,
                                        Keys.typeIceKey: 1.0,
                                        Keys.typeFightingKey: 2.0,
                                        Keys.typePoisonKey: 1.0,
                                        Keys.typeGroundKey: 1.0,
                                        Keys.typeFlyingKey: 1.0,
                                        Keys.typePsychicKey: 0.0,
                                        Keys.typeBugKey: 2.0,
                                        Keys.typeRockKey: 1.0,
                                        Keys.typeGhostKey: 0.5,
                                        Keys.typeDragonKey: 1.0,
                                        Keys.typeDarkKey: 1.0,
                                        Keys.typeSteelKey: 1.0,
                                        Keys.typeFairyKey: 2.0]

let steelDictionary: [String: Double] = [Keys.typeNormalKey: 0.5,
                                         Keys.typeFireKey: 2.0,
                                         Keys.typeWaterKey: 1.0,
                                         Keys.typeElectricKey: 1.0,
                                         Keys.typeGrassKey: 0.5,
                                         Keys.typeIceKey: 0.5,
                                         Keys.typeFightingKey: 2.0,
                                         Keys.typePoisonKey: 0.0,
                                         Keys.typeGroundKey: 2.0,
                                         Keys.typeFlyingKey: 0.5,
                                         Keys.typePsychicKey: 0.5,
                                         Keys.typeBugKey: 0.5,
                                         Keys.typeRockKey: 0.5,
                                         Keys.typeGhostKey: 1.0,
                                         Keys.typeDragonKey: 0.5,
                                         Keys.typeDarkKey: 1.0,
                                         Keys.typeSteelKey: 0.5,
                                         Keys.typeFairyKey: 0.5]

let fairyDictionary: [String: Double] = [Keys.typeNormalKey: 1.0,
                                         Keys.typeFireKey: 1.0,
                                         Keys.typeWaterKey: 1.0,
                                         Keys.typeElectricKey: 1.0,
                                         Keys.typeGrassKey: 1.0,
                                         Keys.typeIceKey: 1.0,
                                         Keys.typeFightingKey: 0.5,
                                         Keys.typePoisonKey: 2.0,
                                         Keys.typeGroundKey: 1.0,
                                         Keys.typeFlyingKey: 1.0,
                                         Keys.typePsychicKey: 1.0,
                                         Keys.typeBugKey: 0.5,
                                         Keys.typeRockKey: 1.0,
                                         Keys.typeGhostKey: 1.0,
                                         Keys.typeDragonKey: 0.0,
                                         Keys.typeDarkKey: 0.5,
                                         Keys.typeSteelKey: 2.0,
                                         Keys.typeFairyKey: 1.0]













