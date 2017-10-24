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

func changeStringToNature(string: String) -> Nature? {
    switch string {
    case Nature.attack.rawValue: return Nature.attack
    case Nature.bashful.rawValue: return Nature.bashful
    case Nature.bold.rawValue: return Nature.bold
    case Nature.brave.rawValue: return Nature.brave
    case Nature.calm.rawValue: return Nature.calm
    case Nature.careful.rawValue: return Nature.careful
    case Nature.docile.rawValue: return Nature.docile
    case Nature.gentle.rawValue: return Nature.gentle
    case Nature.hardy.rawValue: return Nature.hardy
    case Nature.hasty.rawValue: return Nature.hasty
    case Nature.impish.rawValue: return Nature.impish
    case Nature.jolly.rawValue: return Nature.jolly
    case Nature.lax.rawValue: return Nature.lax
    case Nature.lonely.rawValue: return Nature.lonely
    case Nature.mild.rawValue: return Nature.mild
    case Nature.modest.rawValue: return Nature.modest
    case Nature.naive.rawValue: return Nature.naive
    case Nature.naughty.rawValue: return Nature.naughty
    case Nature.quiet.rawValue: return Nature.quiet
    case Nature.quirky.rawValue: return Nature.quirky
    case Nature.rash.rawValue: return Nature.rash
    case Nature.relaxed.rawValue: return Nature.relaxed
    case Nature.sassy.rawValue: return Nature.sassy
    case Nature.serious.rawValue: return Nature.serious
    case Nature.timid.rawValue: return Nature.timid
    default: print("Error returning Nature: String is not one of the Nature enum values")
    return nil
    }
}
