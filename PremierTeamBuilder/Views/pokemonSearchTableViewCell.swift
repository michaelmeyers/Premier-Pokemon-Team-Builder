//
//  pokemonSearchTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class pokemonSearchTableViewCell: UITableViewCell {
    
    // MARK: - Properties
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
    
    func updateCell() {
        guard let pokemon = pokemon,
            let data = pokemon.imageData else {return}
        let image = UIImage(data: data)
        pokemonImageView.image = image
        pokemonNameLabel.text = pokemon.name
        changeLabelToTypeLabel(label: pokemonType1Label, type: pokemon.type1)
        if let type2 = pokemon.type2 {
            changeLabelToTypeLabel(label: pokemonType2Label, type: type2)
        } else {
            pokemonType2Label.isHidden = true
        }
    }

}
