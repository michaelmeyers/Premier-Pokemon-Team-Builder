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
        
        typeLabel.text = typeKey
        
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
        fourthLabel.text = "\(fourthTotal)"
        halfLabel.text = "\(halfTotal)"
        normalEffectiveLabel.text = "\(oneTotal)"
        superEffectiveLabel.text = "\(superEffectiveTotal)"
        extremelyEffectiveLabel.text = "\(extremelyEffectiveTotal)"
        
        
        // TODO: GET MORE DISTINCT COLORS
        if (zeroTotal * 4) + (fourthTotal * 4) + (halfTotal * 2) < (superEffectiveTotal * 2) + (extremelyEffectiveTotal * 4) {
            if zeroTotal > 0 {
                immunityLabel.backgroundColor = .greenYellow
            }
            if fourthTotal > 0 {
                fourthLabel.backgroundColor = .greenYellow
            }
            if halfTotal > 0 {
                halfLabel.backgroundColor = .greenYellow
            }
            if superEffectiveTotal > 0 {
                superEffectiveLabel.backgroundColor = .maroon
            }
            if extremelyEffectiveTotal > 0 {
                extremelyEffectiveLabel.backgroundColor = .maroon
            }
        }
        if (zeroTotal * 4) + (fourthTotal * 4) + (halfTotal * 2) > (superEffectiveTotal * 2) + (extremelyEffectiveTotal * 4) {
            if zeroTotal > 0 {
                immunityLabel.backgroundColor = .green
            }
            if fourthTotal > 0 {
                fourthLabel.backgroundColor = .green
            }
            if halfTotal > 0 {
                halfLabel.backgroundColor = .green
            }
            if superEffectiveTotal > 0 {
                superEffectiveLabel.backgroundColor = .red
            }
            if extremelyEffectiveTotal > 0 {
                extremelyEffectiveLabel.backgroundColor = .red
            }
        }
    }
}
