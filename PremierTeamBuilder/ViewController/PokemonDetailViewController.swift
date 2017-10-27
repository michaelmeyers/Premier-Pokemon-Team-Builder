//
//  PokemonDetailViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit
import CloudKit

class PokemonDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    var pokemon: Pokemon?
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var natureLabel: UILabel!

    @IBOutlet weak var type1Label: UILabel!
    @IBOutlet weak var type2Label: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var spAtkLabel: UILabel!
    @IBOutlet weak var spDefLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var abilityButton: UIButton!
    @IBOutlet weak var abilityPickerView: UIPickerView!
    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var itemPickerView: UIPickerView!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        abilityPickerView.delegate = self
        abilityPickerView.dataSource = self
        itemPickerView.delegate = self
        itemPickerView.dataSource = self
        abilityPickerView.isHidden = true
        itemPickerView.isHidden = true
        if let pokemon = pokemon {
            guard let data = pokemon.imageData,
                let pokeImage = UIImage(data: data) else {return}
            pokemonImageView.image = pokeImage
            nameLabel.text = pokemon.name
            natureLabel.text = pokemon.nature.rawValue
//            abilityLabel.text =  pokemon.chosenAbility
//            itemLabel.text = pokemon.item
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

    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let pokemonTeam = pokemonTeam,
            let pokemon = pokemon else {return}
        PokemonController.shared.createPokemon(onTeam: pokemonTeam, fromPokemonObject: pokemon)
    }
    
    @IBAction func abilityButtonTapped(_ sender: UIButton) {
        abilityPickerView.isHidden = false
    }
    
    @IBAction func itemActionTapped(_ sender: UIButton) {
        abilityPickerView.isHidden = false
    }
    
    
    
    // MARK: - PickerView Datasource and Delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == abilityPickerView {
            return pokemon?.abilities.count ?? 0
        }
        if pickerView == itemPickerView {
            return PokemonTeamController.shared.items.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == abilityPickerView {
            return pokemon?.abilities[row]
        }
        if pickerView == itemPickerView {
            return PokemonTeamController.shared.items[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == abilityPickerView {
            abilityButton.setTitle(pokemon?.abilities[row], for: .normal)
            pokemon?.chosenAbility = pokemon?.abilities[row]
            abilityPickerView.isHidden = true
        }
        if pickerView == itemPickerView {
            let item = PokemonTeamController.shared.items[row]
            itemButton.setTitle(item, for: .normal)
            pokemon?.item = item
            itemPickerView.isHidden = true
        }
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
