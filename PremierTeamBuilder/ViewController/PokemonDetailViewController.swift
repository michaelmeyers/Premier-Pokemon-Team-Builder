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
    
    //TODO: Review Code and fix to make sure it follows proper MVC
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    var pokemon: Pokemon?
    var labelArray: [UILabel] = []
    
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
    @IBOutlet weak var hpBarLabel: UILabel!
    @IBOutlet weak var attackBarLabel: UILabel!
    @IBOutlet weak var defenseBarLabel: UILabel!
    @IBOutlet weak var spAttackBarLabel: UILabel!
    @IBOutlet weak var spDefenseBarLabel: UILabel!
    @IBOutlet weak var speedBarLabel: UILabel!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpSaveButton()
        barLabelSetup()
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
            let name = pokemon.name.uppercased()
            nameLabel.text = name
            natureLabel.text = pokemon.nature.rawValue
            changeLabelToTypeLabel(label: type1Label, type: pokemon.type1)
            if let type2 = pokemon.type2 {
                changeLabelToTypeLabel(label: type2Label, type: type2)
            } else {
                type2Label.isHidden = true
            }
        }
    }

    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        guard let pokemonTeam = pokemonTeam,
            let pokemon = pokemon else {return}
        PokemonController.shared.createPokemon(onTeam: pokemonTeam, fromPokemonObject: pokemon)
        guard let record = pokemonTeam.ckRecord else {return}
        PokemonTeamController.shared.savePokemonTeamRecord(record: record) { (success) in
            if success == true {
                print ("Team Saved")
            } else {
                print("Team Was NOT Saved")
            }
        }
        navigationController?.popViewController(animated: true)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func abilityButtonTapped(_ sender: UIButton) {
        abilityButton.isHidden = true
        abilityPickerView.isHidden = false
    }
    
    @IBAction func itemActionTapped(_ sender: UIButton) {
        itemButton.isHidden = true
        itemPickerView.isHidden = false
    }
    
    // MARK: -View Setup
    func setUpSaveButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.tabBarController?.navigationItem.setRightBarButton(item, animated: false)
    }
    
    func barLabelSetup(){
        guard let pokemon = pokemon else {return}
        let hpLabel = createLabel(int: pokemon.hpStat)
        let attackLabel = createLabel(int: pokemon.attackStat)
        let defenseLabel = createLabel(int: pokemon.defenseStat)
        let spAttackLabel = createLabel(int: pokemon.spAttackStat)
        let spDefenseLabel = createLabel(int: pokemon.spDefenseStat)
        let speedLabel = createLabel(int: pokemon.speedStat)
        
        for label in labelArray {
            configureColor(label: label)
        }
        self.hpLabel = hpLabel
        self.attackLabel = attackLabel
        self.defenseLabel = defenseLabel
        self.spAtkLabel = spAttackLabel
        self.spDefLabel = spDefenseLabel
        self.speedLabel = speedLabel
    }
    
    func createLabel(int: Int) -> UILabel {
        let cgFloat = CGFloat(int)
        let cgRect = CGRect(x: 0, y: 0, width: cgFloat, height: 20.5)
        let label = UILabel(frame: cgRect)
        label.text = ""
        labelArray.append(label)
        return label
    }
    
    func configureColor(label: UILabel){
        switch label.frame.width {
        case ..<40.0: label.backgroundColor = UIColor.maroon
        case ..<50.0: label.backgroundColor = UIColor.red
        case ..<60.0: label.backgroundColor = UIColor.redOrange
        case ..<70.0: label.backgroundColor = UIColor.orange
        case ..<80.0: label.backgroundColor = UIColor.orangeYellow
        case ..<90.0: label.backgroundColor = UIColor.brightYellow
        case ..<100.0: label.backgroundColor = UIColor.yellowGreen
        case ..<120.0: label.backgroundColor = UIColor.greenYellow
        case ..<150.0: label.backgroundColor = UIColor.greenish
        default: label.backgroundColor = UIColor.greenBlue
        }
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
            abilityButton.isHidden = false
        }
        if pickerView == itemPickerView {
            let item = PokemonTeamController.shared.items[row]
            itemButton.setTitle(item, for: .normal)
            pokemon?.item = item
            itemPickerView.isHidden = true
            itemButton.isHidden = false
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Keys.segueIdentifierMove1ToMovesTVC || segue.identifier == Keys.segueIdentifierMove2ToMovesTVC || segue.identifier == Keys.segueIdentifierMove3ToMovesTVC || segue.identifier == Keys.segueIdentifierMove4ToMovesTVC,
        let movesTVC = segue.destination as? MovesListTableViewController,
        let pokemon = pokemon else {return}
        movesTVC.pokemon = pokemon
    }
}
