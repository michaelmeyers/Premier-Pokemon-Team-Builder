//
//  Helper Functions.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit

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
    case .fighting: return fightingDictionary
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
    case Type.fighting.rawValue: return Type.fighting
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
    case Nature.adamant.rawValue: return Nature.adamant
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

func changeNatureEnumToArray() -> [Nature] {
    var array: [Nature] = []
    array.append(.adamant)
    array.append(.bashful)
    array.append(.bold)
    array.append(.brave)
    array.append(.calm)
    array.append(.careful)
    array.append(.docile)
    array.append(.gentle)
    array.append(.hardy)
    array.append(.hasty)
    array.append(.impish)
    array.append(.jolly)
    array.append(.lax)
    array.append(.lonely)
    array.append(.mild)
    array.append(.modest)
    array.append(.naive)
    array.append(.naughty)
    array.append(.quiet)
    array.append(.quirky)
    array.append(.rash)
    array.append(.relaxed)
    array.append(.sassy)
    array.append(.serious)
    array.append(.timid)
    return array
}

func getNumberIDFromHTTPString(string: String) -> Int {
    var mutatableString = string
    mutatableString = mutatableString.substring(to: mutatableString.index(before: mutatableString.endIndex))
    let stringArray = mutatableString.components(separatedBy: "/")
    guard let numberString = stringArray.last,
        let id = Int(numberString) else {return 0}
    return id
}

// MARK: - Alert function
func presentSimpleAlert(controllerToPresentAlert vc: UIViewController, title: String, message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    alert.addAction(dismissAction)
    
    vc.present(alert, animated: true, completion: nil)
}
