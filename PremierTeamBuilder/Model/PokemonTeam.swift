//
//  PokemonTeam.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import CloudKit

class PokemonTeam{
    var sixPokemon: [Pokemon]?
    var name: String
    var recordID: CKRecordID?
    
    init(name: String, sixPokemon: [Pokemon] = []) {
        self.name = name
        self.sixPokemon = sixPokemon
    }
}

