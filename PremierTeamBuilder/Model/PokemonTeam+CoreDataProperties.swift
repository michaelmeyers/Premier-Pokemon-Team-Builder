//
//  PokemonTeam+CoreDataProperties.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/8/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
//

import Foundation
import CoreData


extension PokemonTeam {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PokemonTeam> {
        return NSFetchRequest<PokemonTeam>(entityName: "PokemonTeam")
    }

    @NSManaged public var name: String
    @NSManaged public var recordIDString: String?
    @NSManaged public var sixPokemon: NSOrderedSet?

}

// MARK: Generated accessors for sixPokemon
extension PokemonTeam {

    @objc(insertObject:inSixPokemonAtIndex:)
    @NSManaged public func insertIntoSixPokemon(_ value: Pokemon, at idx: Int)

    @objc(removeObjectFromSixPokemonAtIndex:)
    @NSManaged public func removeFromSixPokemon(at idx: Int)

    @objc(insertSixPokemon:atIndexes:)
    @NSManaged public func insertIntoSixPokemon(_ values: [Pokemon], at indexes: NSIndexSet)

    @objc(removeSixPokemonAtIndexes:)
    @NSManaged public func removeFromSixPokemon(at indexes: NSIndexSet)

    @objc(replaceObjectInSixPokemonAtIndex:withObject:)
    @NSManaged public func replaceSixPokemon(at idx: Int, with value: Pokemon)

    @objc(replaceSixPokemonAtIndexes:withSixPokemon:)
    @NSManaged public func replaceSixPokemon(at indexes: NSIndexSet, with values: [Pokemon])

    @objc(addSixPokemonObject:)
    @NSManaged public func addToSixPokemon(_ value: Pokemon)

    @objc(removeSixPokemonObject:)
    @NSManaged public func removeFromSixPokemon(_ value: Pokemon)

    @objc(addSixPokemon:)
    @NSManaged public func addToSixPokemon(_ values: NSOrderedSet)

    @objc(removeSixPokemon:)
    @NSManaged public func removeFromSixPokemon(_ values: NSOrderedSet)

}
