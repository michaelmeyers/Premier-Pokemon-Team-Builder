//
//  PokemonTeamTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonTeamTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    
    // MARK: - Outlets
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var pokemon1ImageView: UIImageView!
    @IBOutlet weak var pokemon2ImageView: UIImageView!
    @IBOutlet weak var pokemon3ImageView: UIImageView!
    @IBOutlet weak var pokemon4ImageView: UIImageView!
    @IBOutlet weak var pokemon5ImageView: UIImageView!
    @IBOutlet weak var pokemon6ImageView: UIImageView!
    @IBOutlet var pokemonImages: [UIImageView]!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updatePokemonTeamCell() {
        for imageView in pokemonImages {
            imageView.image = UIImage()
        }
        
        guard let pokemonTeam = pokemonTeam else {return}
        let sixPokemon = pokemonTeam.sixPokemon
        teamNameLabel.text = pokemonTeam.name
        
        guard sixPokemon.count != 0 else {return}
        var count = 0
        
        while count < sixPokemon.count {
            guard let pokemon = sixPokemon[count] else {return}
            if let data = pokemon.imageData {
                let image = UIImage(data: data)
                pokemonImages[count].image = image
            } else {
                pokemonImages[count].image = #imageLiteral(resourceName: "defaultPokemonImage")
            }
            count += 1
        }
    }
}
