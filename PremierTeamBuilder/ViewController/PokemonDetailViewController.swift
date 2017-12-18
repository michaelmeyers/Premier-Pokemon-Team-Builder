//
//  PokemonDetailViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit
import CloudKit

class PokemonDetailViewController: UIViewController {
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    var pokemon: Pokemon?
    var pokemonMoves: [Move]?
    
    let maxHPValue: Float = 200
    let maxValue: Float = 160
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonImageView: UIImageView!
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
    @IBOutlet weak var itemButton: UIButton!
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
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMoveButtons()
        updateItemButton()
        updateNatureLabel()
    }
    
    // MARK: - Actions
    
    @objc func saveButtonTapped() {
        guard let pokemonTeam = pokemonTeam else {return}
        if pokemon?.pokemonTeamRefString == nil {
            guard let pokemon = self.pokemon else {return}
            PokemonController.shared.createPokemon(onTeam: pokemonTeam, fromPokemonObject: pokemon)
            PokemonTeamController.shared.updatePokemonTeamRecord(newPokemonTeam: pokemonTeam) { (success) in
                if success == true {
                    print ("Team Saved")
                } else {
                    print("Team Was NOT Saved")
                }
            }
        } else {
            guard let pokemon = pokemon else {return}
            PokemonController.shared.updatePokemon(pokemon: pokemon)
            PokemonTeamController.shared.updatePokemonTeamRecord(newPokemonTeam: pokemonTeam) { (success) in
                if success == true {
                    print ("Team Saved")
                } else {
                    print("Team Was NOT Saved")
                }
            }
        }
        performSegue(withIdentifier: Keys.unwindSegueIdentifierToPokemonTeamVC, sender: self)
    }
    
    @IBAction func abilityButtonTapped(_ sender: UIButton) {
        presentPickAbilityAlert()
    }
    
    @IBAction func itemActionTapped(_ sender: UIButton) {
        // No actions is Need Button is Just a Segue
    }
    
    // MARK: -View Setup
    
    func setUpUI() {
        guard let pokemon = pokemon else {return}
        setUpView(pokemon: pokemon)
        setNavigationBarTitle(onViewController: self, withTitle: "pokemon.name.uppercased()")
        setAbilityButtonTitle()
        setItemButtonTitle()
    }
    
    func setUpView(pokemon: Pokemon) {
        setUpSaveButton()
        setStatLabels(pokemon: pokemon)
        barGraphSetup(pokemon: pokemon)
        
        var pokeImage = #imageLiteral(resourceName: "defaultPokemonImage")
        if let data = pokemon.imageData {
            guard let image = UIImage(data: data as Data) else {return}
            pokeImage = image
        }
        pokemonImageView.image = pokeImage
        let name = pokemon.name.uppercased()
        setNavigationBarTitle(onViewController: self, withTitle: name)
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
    
    func setAbilityButtonTitle() {
        guard let pokemon = pokemon else {return}
        if let ability = pokemon.chosenAbility {
            abilityButton.setTitle(ability, for: .normal)
        } else {
            abilityButton.setTitle("Choose Ability", for: .normal)
        }
    }
    
    func setItemButtonTitle() {
        guard let pokemon = pokemon else {return}
        if pokemon.item.lowercased() == "none" {
            itemButton.setTitle("Choose Item", for: .normal)
        } else {
            itemButton.setTitle(pokemon.item, for: .normal)
        }
    }
    
    func setUpSaveButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.tabBarController?.navigationItem.setRightBarButton(item, animated: false)
    }
    
    // Func to call and set up all of the Pokemon Bar Graphs
    func barGraphSetup(pokemon: Pokemon){
        configureProgressView(progressView: hpProgressView, stat: pokemon.hpStat, maxValue: maxHPValue)
        configureProgressView(progressView: attackProgressView, stat: pokemon.attackStat, maxValue: maxValue)
        configureProgressView(progressView: defenseProgressView, stat: pokemon.defenseStat, maxValue: maxValue)
        configureProgressView(progressView: spAttProgressView, stat: pokemon.spAttackStat, maxValue: maxValue)
        configureProgressView(progressView: spDefProgressView, stat: pokemon.spDefenseStat, maxValue: maxValue)
        configureProgressView(progressView: speedProgressView, stat: pokemon.speedStat, maxValue: maxValue)
    }
    
    // Progress Bars are used to make the bar graph for the Pokemon Stats
    func configureProgressView (progressView: UIProgressView, stat: Int64, maxValue: Float) {
        let statFloat = Float(stat)
        let progress = statFloat/maxValue
        progressView.progress = progress
        progressView.progressViewStyle = .bar
        let color = configureColor(stat: statFloat)
        progressView.progressTintColor = color
    }
    
    // Configured the color based of the amount of the stat.
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
    
    // Set all of the Stats to show the Pokemons Stats
    func setStatLabels(pokemon: Pokemon) {
        hpStatLabel.text = "\(pokemon.hpStat)"
        attackStatLabel.text = "\(pokemon.attackStat)"
        defenseStatLabel.text = "\(pokemon.defenseStat)"
        spAtkStatLabel.text = "\(pokemon.spAttackStat)"
        spDefStatLabel.text = "\(pokemon.spDefenseStat)"
        speedStatLabel.text = "\(pokemon.speedStat)"
    }
    // Set the Item Button to match the Pokemon's Item
    func updateItemButton() {
        guard let pokemon = pokemon else {return}
        itemButton.setTitle(pokemon.item, for: .normal)
    }
    
    // Sets the Nature Label to match the Pokemon's Nature
    func updateNatureLabel() {
        guard let pokemon = pokemon,
            let nature = pokemon.nature else {return}
        natureLabel.text = nature.rawValue
    }
    
    // Changed to Move Button Labels to match their corresponding strings on the Pokemon
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
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Keys.segueIdentifierToItemsTVC {
            guard let itemsTVC = segue.destination as? ItemsTableViewController,
                let pokemon = pokemon else {return}
            itemsTVC.pokemon = pokemon
        }
        else {
            var buttonPressed: String = ""
            if segue.identifier == Keys.segueIdentifierMove1ToMovesTVC {
                buttonPressed = "move1"
                setBackBarButtonItem(ViewController: self)
            }
            if segue.identifier == Keys.segueIdentifierMove2ToMovesTVC {
                buttonPressed = "move2"
                setBackBarButtonItem(ViewController: self)
            }
            if segue.identifier == Keys.segueIdentifierMove3ToMovesTVC {
                buttonPressed = "move3"
                setBackBarButtonItem(ViewController: self)
            }
            if segue.identifier == Keys.segueIdentifierMove4ToMovesTVC {
                buttonPressed = "move4"
                setBackBarButtonItem(ViewController: self)
            }
            guard let movesTVC = segue.destination as? MovesListTableViewController else {return}
            if let pokemon = pokemon {
                movesTVC.pokemon = pokemon
                movesTVC.buttonPressed = buttonPressed
                setBackBarButtonItem(ViewController: self)
            }
        }
    }
    
    // MARK: - Alert Controller
    func presentPickAbilityAlert() {
        let alertController = UIAlertController(title: "Choose Your Pokemon's Ability", message: "", preferredStyle: .alert)
        guard let pokemon  = pokemon else {return}
        let abilities = pokemon.abilities
        for ability in abilities {
            let action = UIAlertAction(title: ability, style: .default, handler: { (_) in
                pokemon.chosenAbility = ability
                self.abilityButton.setTitle(ability, for: .normal)
                self.view.setNeedsDisplay()
            })
            alertController.addAction(action)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
