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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updatePokemonTeamCell() {
        
        guard let pokemonTeam = pokemonTeam else {return}
        let sixPokemon = pokemonTeam.sixPokemon
        teamNameLabel.text = pokemonTeam.name
        
        if let pokemon1 = sixPokemon[0] {
            guard let data = pokemon1.imageData else {return}
            let image = UIImage(data: data)
            pokemon1ImageView.image = image
        } else {return}
        
        if let pokemon2 = sixPokemon[1] {
            guard let data = pokemon2.imageData else {return}
            let image = UIImage(data: data)
            pokemon2ImageView.image = image
        } else {return}
        
        if let pokemon3 = sixPokemon[2] {
            guard let data = pokemon3.imageData else {return}
            let image = UIImage(data: data)
            pokemon3ImageView.image = image
        } else {return}
        
        if let pokemon4 = sixPokemon[3] {
            guard let data = pokemon4.imageData else {return}
            let image = UIImage(data: data)
            pokemon4ImageView.image = image
        } else {return}
        
        if let pokemon5 = sixPokemon[4] {
            guard let data = pokemon5.imageData else {return}
            let image = UIImage(data: data)
            pokemon5ImageView.image = image
        } else {return}
        
        if let pokemon6 = sixPokemon[5] {
            guard let data = pokemon6.imageData else {return}
            let image = UIImage(data: data)
            pokemon6ImageView.image = image
        } else {return}
    }

}
