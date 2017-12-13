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
    var pokemonObject: Pokemon?
    var pokemonMoves: [Move]?
    
    let maxHPValue: Float = 200
    let maxValue: Float = 160
    
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
    @IBOutlet weak var hpStatLabel: UILabel!
    @IBOutlet weak var attackStatLabel: UILabel!
    @IBOutlet weak var defenseStatLabel: UILabel!
    @IBOutlet weak var spAtkStatLabel: UILabel!
    @IBOutlet weak var spDefStatLabel: UILabel!
    @IBOutlet weak var speedStatLabel: UILabel!
    
    @IBOutlet weak var abilityButton: UIButton!
    @IBOutlet weak var abilityPickerView: UIPickerView!
    @IBOutlet weak var itemButton: UIButton!
    @IBOutlet weak var itemPickerView: UIPickerView!
    @IBOutlet weak var move1Button: UIButton!
    @IBOutlet weak var move2Button: UIButton!
    @IBOutlet weak var move3Button: UIButton!
    @IBOutlet weak var move4Button: UIButton!
    @IBOutlet weak var hpProgressView: UIProgressView!
    @IBOutlet weak var attackProgressView: UIProgressView!
    @IBOutlet weak var defenseProgressView: UIProgressView!
    @IBOutlet weak var spAttProgressView: UIProgressView!
    @IBOutlet weak var spDefProgressView: UIProgressView!
    @IBOutlet weak var speedProgressView: UIProgressView!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = pokemonObject {
            setUpView(pokemon: pokemon)
        }
        if let pokemon = pokemon {
            setUpView(pokemon: pokemon)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMoveButtons()
    }

    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        guard let pokemonTeam = pokemonTeam else {return}
        guard let pokemon = pokemon else {
            guard let pokemon = pokemonObject else {return}
            PokemonController.shared.createPokemon(onTeam: pokemonTeam, fromPokemonObject: pokemon)
            PokemonTeamController.shared.updatePokemonTeamRecord(newPokemonTeam: pokemonTeam) { (success) in
                    if success == true {
                        print ("Team Saved")
                    } else {
                        print("Team Was NOT Saved")
                    }
            }
            performSegue(withIdentifier: Keys.unwindSegueIdentifierToPokemonTeamVC, sender: self)
            return
        }
        
        PokemonController.shared.updatePokemon(pokemon: pokemon)
        PokemonTeamController.shared.updatePokemonTeamRecord(newPokemonTeam: pokemonTeam) { (success) in
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
    
    func setUpView(pokemon: Pokemon) {
        setUpSaveButton()
        setStatLabels(pokemon: pokemon)
        barGraphSetup(pokemon: pokemon)
        abilityPickerView.delegate = self
        abilityPickerView.dataSource = self
        itemPickerView.delegate = self
        itemPickerView.dataSource = self
        abilityPickerView.isHidden = true
        itemPickerView.isHidden = true
        
        var pokeImage = #imageLiteral(resourceName: "defaultPokemonImage")
        if let data = pokemon.imageData {
            guard let image = UIImage(data: data as Data) else {return}
            pokeImage = image
        }
        pokemonImageView.image = pokeImage
        let name = pokemon.name.uppercased()
        nameLabel.text = name
        guard let natureString = pokemon.nature?.rawValue else {return}
        natureLabel.text = natureString
        guard let type1 = pokemon.type1 else {return}
        changeLabelToTypeLabel(label: type1Label, type: type1)
        if let type2 = pokemon.type2 {
            changeLabelToTypeLabel(label: type2Label, type: type2)
        } else {
            type2Label.isHidden = true
        }
    }
    
    func setUpSaveButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.tabBarController?.navigationItem.setRightBarButton(item, animated: false)
    }
    
    func barGraphSetup(pokemon: Pokemon){
        configureProgressView(progressView: hpProgressView, stat: pokemon.hpStat, maxValue: maxHPValue)
        configureProgressView(progressView: attackProgressView, stat: pokemon.attackStat, maxValue: maxValue)
        configureProgressView(progressView: defenseProgressView, stat: pokemon.defenseStat, maxValue: maxValue)
        configureProgressView(progressView: spAttProgressView, stat: pokemon.spAttackStat, maxValue: maxValue)
        configureProgressView(progressView: spDefProgressView, stat: pokemon.spDefenseStat, maxValue: maxValue)
        configureProgressView(progressView: speedProgressView, stat: pokemon.speedStat, maxValue: maxValue)
    }
    
    func configureProgressView (progressView: UIProgressView, stat: Int64, maxValue: Float) {
        let statFloat = Float(stat)
        let progress = statFloat/maxValue
        progressView.progress = progress
        progressView.progressViewStyle = .bar
        let color = configureColor(stat: statFloat)
        progressView.progressTintColor = color
    }
    
    func configureColor(stat: Float) -> UIColor {
        switch stat {
        case ..<40.0: return UIColor.maroon
        case ..<50.0: return UIColor.red
        case ..<60.0: return UIColor.redOrange
        case ..<70.0: return UIColor.orange
        case ..<80.0: return UIColor.orangeYellow
        case ..<90.0: return UIColor.brightYellow
        case ..<100.0: return UIColor.yellowGreen
        case ..<120.0: return UIColor.greenYellow
        case ..<150.0: return UIColor.greenish
        default: return UIColor.greenBlue
        }
    }
    
    func setStatLabels(pokemon: Pokemon) {
        hpStatLabel.text = "\(pokemon.hpStat)"
        attackStatLabel.text = "\(pokemon.attackStat)"
        defenseStatLabel.text = "\(pokemon.defenseStat)"
        spAtkStatLabel.text = "\(pokemon.spAttackStat)"
        spDefStatLabel.text = "\(pokemon.spDefenseStat)"
        speedStatLabel.text = "\(pokemon.speedStat)"
    }
    
    func updateMoveButtons() {
        if let pokemon = pokemon {
            if let move = pokemon.move1 {
                move1Button.setTitle(move, for: .normal)
            }
            if let move = pokemon.move2 {
                move2Button.setTitle(move, for: .normal)
            }
            if let move = pokemon.move3 {
                move3Button.setTitle(move, for: .normal)
            }
            if let move = pokemon.move4 {
                move4Button.setTitle(move, for: .normal)
            }
        } else {
            guard let pokemon = pokemonObject else {return}
            if let move = pokemon.move1 {
                move1Button.setTitle(move, for: .normal)
            }
            if let move = pokemon.move2 {
                move2Button.setTitle(move, for: .normal)
            }
            if let move = pokemon.move3 {
                move3Button.setTitle(move, for: .normal)
            }
            if let move = pokemon.move4 {
                move4Button.setTitle(move, for: .normal)
            }
        }
        
    }
    
    // MARK: - PickerView Datasource and Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == abilityPickerView {
            guard let pokemon = pokemon else {return 0}
            return pokemon.abilities.count
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
            guard let abilities = pokemon?.abilities else {return}
            abilityButton.setTitle(abilities[row], for: .normal)
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
    
    // MARK: - Methods


    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var buttonPressed: String = ""
        if segue.identifier == Keys.segueIdentifierMove1ToMovesTVC {
            buttonPressed = "move1"
        }
        if segue.identifier == Keys.segueIdentifierMove2ToMovesTVC {
            buttonPressed = "move2"
        }
        if segue.identifier == Keys.segueIdentifierMove3ToMovesTVC {
            buttonPressed = "move3"
        }
        if segue.identifier == Keys.segueIdentifierMove4ToMovesTVC {
            buttonPressed = "move4"
        }
        guard let movesTVC = segue.destination as? MovesListTableViewController else {return}
        if let pokemon = pokemon {
            movesTVC.pokemon = pokemon
            movesTVC.buttonPressed = buttonPressed
        } else {
            guard let pokemon = pokemonObject else {return}
            movesTVC.pokemon = pokemon
            movesTVC.buttonPressed = buttonPressed
        }
        
    }
}
