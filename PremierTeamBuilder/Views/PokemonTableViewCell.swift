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
        pokemonType2Label.isHidden = false
        
        guard let pokemon = pokemon else {return}
        pokemonImageView.image = #imageLiteral(resourceName: "defaultPokemonImage")
        pokemonImageView.layer.borderColor = UIColor.black.cgColor
        pokemonImageView.layer.borderWidth = 2
        pokemonImageView.backgroundColor = .clear
        if let data = pokemon.imageData {
            let pokemonImage = UIImage(data: data as Data)
            pokemonImageView.image = pokemonImage
        }
        pokemonNameLabel.text = pokemon.name
        guard let type1 = pokemon.type1 else {return}
        changeLabelToTypeLabel(label: pokemonType1Label, type: type1)
        if let type2 = pokemon.type2 {
            changeLabelToTypeLabel(label: pokemonType2Label, type: type2)
        } else {
            pokemonType2Label.isHidden = true
        }
        
    }
    
}
