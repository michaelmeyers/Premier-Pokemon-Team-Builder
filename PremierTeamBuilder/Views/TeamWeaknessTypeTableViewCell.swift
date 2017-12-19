//
//  TeamWeaknessTypeTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 11/1/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class TeamWeaknessTypeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    
    // MARK: - Outlets
    
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var immunityLabel: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var halfLabel: UILabel!
    @IBOutlet weak var normalEffectiveLabel: UILabel!
    @IBOutlet weak var superEffectiveLabel: UILabel!
    @IBOutlet weak var extremelyEffectiveLabel: UILabel!
    
    // MARK: - Cell LifeCycles
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCell(withTypeKey typeKey: String) {
        var zeroTotal: Int = 0
        var fourthTotal: Int = 0
        var halfTotal: Int = 0
        var oneTotal: Int = 0
        var superEffectiveTotal: Int = 0
        var extremelyEffectiveTotal: Int = 0
        
        typeLabel.text = typeKey.uppercased()
        typeLabel.textColor = .black
        typeLabel.backgroundColor = configureBackgroundColor(type: typeKey)
        typeLabel.adjustsFontSizeToFitWidth = true
        typeLabel.minimumScaleFactor = 0.2
        
        guard let pokemonTeam = pokemonTeam,
            let sixPokemon = pokemonTeam.sixPokemon?.array as? [Pokemon] else {return}
        for pokemon in sixPokemon {
            guard let value = pokemon.weaknessDictionary?[typeKey] else {return}
            if value == 0 {
                zeroTotal += 1
            }
            if value == 0.25 {
                fourthTotal += 1
            }
            if value == 0.5 {
                halfTotal += 1
            }
            if value == 1 {
                oneTotal += 1
            }
            if value == 2.0 {
                superEffectiveTotal += 1
            }
            if value == 4.0 {
                extremelyEffectiveTotal += 1
            }
        }
        
        immunityLabel.text = "\(zeroTotal)"
        immunityLabel.textAlignment = .center
        fourthLabel.text = "\(fourthTotal)"
        fourthLabel.textAlignment = .center
        halfLabel.text = "\(halfTotal)"
        halfLabel.textAlignment = .center
        normalEffectiveLabel.text = "\(oneTotal)"
        normalEffectiveLabel.textAlignment = .center
        superEffectiveLabel.text = "\(superEffectiveTotal)"
        superEffectiveLabel.textAlignment = .center
        extremelyEffectiveLabel.text = "\(extremelyEffectiveTotal)"
        extremelyEffectiveLabel.textAlignment = .center
        
        
        // TODO: GET MORE DISTINCT COLORS
        if (zeroTotal * 4) + (fourthTotal * 4) + (halfTotal * 2) < (superEffectiveTotal * 2) + (extremelyEffectiveTotal * 4) {
            if zeroTotal > 0 {
                immunityLabel.backgroundColor = .probably
            }
            if fourthTotal > 0 {
                fourthLabel.backgroundColor = .probably
            }
            if halfTotal > 0 {
                halfLabel.backgroundColor = .probably
            }
            if superEffectiveTotal > 0 {
                superEffectiveLabel.backgroundColor = .unbalanced
            }
            if extremelyEffectiveTotal > 0 {
                extremelyEffectiveLabel.backgroundColor = .unbalanced
            }
        }
        if (zeroTotal * 4) + (fourthTotal * 4) + (halfTotal * 2) > (superEffectiveTotal * 2) + (extremelyEffectiveTotal * 4) {
            if zeroTotal > 0 {
                immunityLabel.backgroundColor = .definitely
            }
            if fourthTotal > 0 {
                fourthLabel.backgroundColor = .definitely
            }
            if halfTotal > 0 {
                halfLabel.backgroundColor = .definitely
            }
            if superEffectiveTotal > 0 {
                superEffectiveLabel.backgroundColor = .weak
            }
            if extremelyEffectiveTotal > 0 {
                extremelyEffectiveLabel.backgroundColor = .weak
            }
        }
    }
}
