//
//  PokemonTeamController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/23/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation

class PokemonTeamController {
    
    static let shared = PokemonTeamController()
    
    var PokemonTeams: [PokemonTeam]? {
        didSet{
            
        }
    }
    
    func createTeam(withName name: String){
        let pokemonTeam = PokemonTeam(name: name)
        PokemonTeamController.shared.PokemonTeams?.append(pokemonTeam)
    }
    
    
}
