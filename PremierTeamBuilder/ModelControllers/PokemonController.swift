//
//  PokemonController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/21/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class PokemonController {

    static let shared = PokemonController()
    
    
    //TODO:  Get rid of Network Controller
    //TODO:  Add my image fetch data on to my create pokemon func
    
    let networkController = NetworkController()
    
    func createPokemon(onTeam pokemonTeam: PokemonTeam, fromSearchTerm searchTerm: String){
        networkController.fetchPokemonData(fromSearchTerm: searchTerm) { (data) in
            guard let recordID = pokemonTeam.recordID else {return}
            let pokemonTeamRef = CKReference(recordID: recordID, action: .deleteSelf)
            guard let data = data,
            let jsonDictionary = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any],
                let dictionary = jsonDictionary,
                let pokemon = Pokemon(dictionary: dictionary, pokemonTeamRef: pokemonTeamRef)  else {return}
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
    
//    {
//    var theData: Data?
//    let group = DispatchGroup()
//    guard let url = self.imageURL else {return nil}
//    group.enter()
//    PokemonController.shared.getPokemonImageData(withURL: url) { (data) in
//    guard let data = data else {return}
//    theData = data
//    }
//    group.wait()
//    return theData
//    }
}
