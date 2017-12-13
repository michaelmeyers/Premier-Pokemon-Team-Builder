//
//  Pokemon+CoreDataProperties.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/13/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
//

import Foundation
import CoreData


extension Pokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pokemon> {
        return NSFetchRequest<Pokemon>(entityName: "Pokemon")
    }

    @NSManaged public var abilitiesData: NSData
    @NSManaged public var attackStat: Int64
    @NSManaged public var chosenAbility: String?
    @NSManaged public var defenseStat: Int64
    @NSManaged public var evAttack: Int64
    @NSManaged public var evDefense: Int64
    @NSManaged public var evHP: Int64
    @NSManaged public var evSpecialAttack: Int64
    @NSManaged public var evSpecialDefense: Int64
    @NSManaged public var evSpeed: Int64
    @NSManaged public var hpStat: Int64
    @NSManaged public var imageData: NSData?
    @NSManaged public var imageEndpoint: String?
    @NSManaged public var item: String
    @NSManaged public var ivAttack: Int64
    @NSManaged public var ivDefense: Int64
    @NSManaged public var ivHP: Int64
    @NSManaged public var ivSpecialAttack: Int64
    @NSManaged public var ivSpecialDefense: Int64
    @NSManaged public var ivSpeed: Int64
    @NSManaged public var move1: String?
    @NSManaged public var move2: String?
    @NSManaged public var move3: String?
    @NSManaged public var move4: String?
    @NSManaged public var moveIDsData: NSData
    @NSManaged public var name: String
    @NSManaged public var natureString: String
    @NSManaged public var pokemonTeamRefString: String?
    @NSManaged public var recordIDString: String?
    @NSManaged public var role: String
    @NSManaged public var spAttackStat: Int64
    @NSManaged public var spDefenseStat: Int64
    @NSManaged public var speedStat: Int64
    @NSManaged public var type1String: String
    @NSManaged public var type2String: String?
    @NSManaged public var id: Int64
    @NSManaged public var moves: NSOrderedSet?
    @NSManaged public var pokemonTeam: NSSet?

}

// MARK: Generated accessors for moves
extension Pokemon {

    @objc(insertObject:inMovesAtIndex:)
    @NSManaged public func insertIntoMoves(_ value: Move, at idx: Int)

    @objc(removeObjectFromMovesAtIndex:)
    @NSManaged public func removeFromMoves(at idx: Int)

    @objc(insertMoves:atIndexes:)
    @NSManaged public func insertIntoMoves(_ values: [Move], at indexes: NSIndexSet)

    @objc(removeMovesAtIndexes:)
    @NSManaged public func removeFromMoves(at indexes: NSIndexSet)

    @objc(replaceObjectInMovesAtIndex:withObject:)
    @NSManaged public func replaceMoves(at idx: Int, with value: Move)

    @objc(replaceMovesAtIndexes:withMoves:)
    @NSManaged public func replaceMoves(at indexes: NSIndexSet, with values: [Move])

    @objc(addMovesObject:)
    @NSManaged public func addToMoves(_ value: Move)

    @objc(removeMovesObject:)
    @NSManaged public func removeFromMoves(_ value: Move)

    @objc(addMoves:)
    @NSManaged public func addToMoves(_ values: NSOrderedSet)

    @objc(removeMoves:)
    @NSManaged public func removeFromMoves(_ values: NSOrderedSet)

}

// MARK: Generated accessors for pokemonTeam
extension Pokemon {

    @objc(addPokemonTeamObject:)
    @NSManaged public func addToPokemonTeam(_ value: PokemonTeam)

    @objc(removePokemonTeamObject:)
    @NSManaged public func removeFromPokemonTeam(_ value: PokemonTeam)

    @objc(addPokemonTeam:)
    @NSManaged public func addToPokemonTeam(_ values: NSSet)

    @objc(removePokemonTeam:)
    @NSManaged public func removeFromPokemonTeam(_ values: NSSet)

}
