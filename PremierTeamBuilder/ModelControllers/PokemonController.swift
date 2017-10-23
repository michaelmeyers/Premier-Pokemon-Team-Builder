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
    init(){
    }
    
    static let shared = PokemonController()
    
    let networkController = NetworkController()
    
    func createPokemon(){
        
    }
    
    func createPokemonImage(withURL url: URL, completion: @escaping (UIImage?) -> Void){
        networkController.fetchImageData(withURL: url) { (data) in
            guard let data = data else {
                completion(nil)
                return}
            let image = UIImage(data: data)
            completion(image)
        }
    }

}
