//
//  PokemonTeam+CoreDataClass.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/8/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
//

import Foundation
import CoreData
import CloudKit

@objc(PokemonTeam)
public class PokemonTeam: NSManagedObject {
    
    convenience init(name: String, sixPokemon: NSOrderedSet = [], context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.sixPokemon = sixPokemon
    }
}
