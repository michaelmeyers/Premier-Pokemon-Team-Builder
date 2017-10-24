//
//  PokemonController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/21/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit

class PokemonController {

    static let shared = PokemonController()
    
    
    
    let networkController = NetworkController()
    
    func createPokemon(onTeam pokemonTeam: PokemonTeam, fromSearchTerm searchTerm: String){
        networkController.fetchPokemonData(fromSearchTerm: searchTerm) { (data) in
            guard let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
                let dictionary = jsonDictionary,
            let pokemon = Pokemon(dictionary: dictionary) else {return}
            pokemonTeam.sixPokemon?.append(pokemon)
        }
    }
    
    func getPokemonImageData(withURL url: URL, completion: @escaping (Data?) -> Void){
        networkController.fetchImageData(withURL: url) { (data) in
            guard let data = data else {
                completion(nil)
                return
            }
            completion(data)
        }
    }
}
