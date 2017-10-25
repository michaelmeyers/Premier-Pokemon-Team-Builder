//
//  PokemonDetailViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    var pokemon: Pokemon?
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var natureLabel: UILabel!
    @IBOutlet weak var abilityLabel: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var spAtkLabel: UILabel!
    @IBOutlet weak var spDefLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!

    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = pokemon {
            guard let data = pokemon.imageData,
                let pokeImage = UIImage(data: data) else {return}
            pokemonImageView.image = pokeImage
            natureLabel.text = pokemon.nature.rawValue
            abilityLabel.text =  pokemon.chosenAbility
            itemLabel.text = pokemon.item
            type1Label.text = pokemon.type1.rawValue
            if let type2 = pokemon.type2 {
                type2Label.text = type2.rawValue
            } else {
                type2Label.isHidden = true
            }
            hpLabel.text = "\(String(describing: pokemon.hpStat))"
            attackLabel.text = "\(String(describing: pokemon.attackStat))"
            defenseLabel.text = "\(String(describing: pokemon.defenseStat))"
            spAtkLabel.text = "\(String(describing: pokemon.spAttackStat))"
            spDefLabel.text = "\(String(describing: pokemon.spDefenseStat))"
            speedLabel.text = "\(String(describing: pokemon.speedStat))"
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
