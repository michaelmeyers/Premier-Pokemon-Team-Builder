//
//  PokemonTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonTableViewCell: UITableViewCell {
    
    // MARK: - Propeties
    var pokemon: Pokemon?
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    @IBOutlet weak var pokemonType1Label: UILabel!
    @IBOutlet weak var pokemonType2Label: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updatePokemonCell() {
        
        guard let pokemon = pokemon,
        let data = pokemon.imageData else {return}
        let pokemonImage = UIImage(data: data)
        pokemonImageView.image = pokemonImage
        pokemonNameLabel.text = pokemon.name
        pokemonType1Label.text = "\(pokemon.type1)"
        if let type2 = pokemon.type2 {
            pokemonType2Label.text = "\(type2)"
        } else {
            pokemonType2Label.isHidden = true
        }
        
    }

}