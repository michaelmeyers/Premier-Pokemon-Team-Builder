//
//  Helper Functions.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

func fetchTypeDictionary(fromType type: Type) -> typeDictionary {
    switch type{
    case .normal: return normalDictionary
    case .fire: return fireDictionary
    case .water: return waterDictionary
    case .electric: return electricDictionary
    case .grass: return grassDictionary
    case .ice: return iceDictionary
    case .poison: return poisonDictionary
    case .ground: return groundDictionary
    case .flying: return flyingDictionary
    case .psychic: return psychicDictionary
    case .bug: return bugDictionary
    case .rock: return rockDictionary
    case .ghost: return ghostDictionary
    case .dragon: return dragonDictionary
    case .dark: return darkDictionary
    case .steel: return steelDictionary
    case .fairy: return fairyDictionary
    }
}

func changeStringToType(string: String) ->Type? {
    switch string {
    case Type.normal.rawValue: return Type.normal
    case Type.fire.rawValue: return Type.fire
    case Type.water.rawValue: return Type.water
    case Type.electric.rawValue: return Type.electric
    case Type.grass.rawValue: return Type.grass
    case Type.ice.rawValue: return Type.ice
    case Type.poison.rawValue: return Type.poison
    case Type.ground.rawValue: return Type.ground
    case Type.flying.rawValue: return Type.flying
    case Type.psychic.rawValue: return Type.psychic
    case Type.bug.rawValue: return Type.bug
    case Type.rock.rawValue: return Type.rock
    case Type.ghost.rawValue: return Type.ghost
    case Type.dragon.rawValue: return Type.dragon
    case Type.dark.rawValue: return Type.dark
    case Type.steel.rawValue: return Type.steel
    case Type.fairy.rawValue: return Type.fairy
    default: print("Error return string for type is not one of the type enum values")
    return nil
    }
}
