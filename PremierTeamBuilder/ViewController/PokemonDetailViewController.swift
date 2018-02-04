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
    @IBOutlet weak var move1Button: UIButton!
    @IBOutlet weak var move2Button: UIButton!
    @IBOutlet weak var move3Button: UIButton!
    @IBOutlet weak var move4Button: UIButton!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemon = pokemonObject {
            setUpView(pokemon: pokemon)
        }
        if let pokemon = pokemon {
            setUpView(pokemon: pokemon)
        }
        fetchAllPokemonMoves()
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
            navigationController?.popViewController(animated: true)
            navigationController?.popViewController(animated: true)
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
        barLabelSetup(pokemon: pokemon)
        abilityPickerView.delegate = self
        abilityPickerView.dataSource = self
        itemPickerView.delegate = self
        itemPickerView.dataSource = self
        abilityPickerView.isHidden = true
        itemPickerView.isHidden = true
        
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
    
    func setUpSaveButton() {
        let button = UIButton(type: .custom)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        let item = UIBarButtonItem(customView: button)
        self.tabBarController?.navigationItem.setRightBarButton(item, animated: false)
    }
    
    func barLabelSetup(pokemon: Pokemon){
        configureBarGraphLabel(label: hpBarLabel, width: pokemon.hpStat)
        configureBarGraphLabel(label: attackBarLabel, width: pokemon.attackStat)
        configureBarGraphLabel(label: defenseBarLabel, width: pokemon.defenseStat)
        configureBarGraphLabel(label: spAttackBarLabel, width: pokemon.spAttackStat)
        configureBarGraphLabel(label: spDefenseBarLabel, width: pokemon.spDefenseStat)
        configureBarGraphLabel(label: speedBarLabel, width: pokemon.speedStat)
    }
    
    func configureBarGraphLabel(label: UILabel, width: Int) {
        let constraints = label.constraints
        for constraint in constraints {
            label.removeConstraint(constraint)
        }
        label.addConstraint(NSLayoutConstraint(item: label, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: CGFloat(width)))
        label.text = ""
        configureColor(label: label)
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
    
    func updateMoveButtons() {
        guard let pokemon = pokemon else {return}
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
    
    // MARK: - Methods
    func fetchAllPokemonMoves() {
        let group = DispatchGroup()
        var moves: [Move] = []
        if let pokemon = pokemon {
            let movesStrings = pokemon.moves
            for moveString in movesStrings {
                group.enter()
                MoveController.shared.createMove(fromSearchTerm: moveString, completion: { (move) in
                    guard let move = move else {
                        group.leave()
                        return}
                    moves.append(move)
                    print(move.name)
                    group.leave()
                })
            }
        }
        group.notify(queue: DispatchQueue.main) {
            moves.sort { $0.name < $1.name }
            self.pokemonMoves = moves
        }
    }

    
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
            movesTVC.pokemonMoves = pokemonMoves
        } else {
            guard let pokemon = pokemonObject else {return}
            movesTVC.pokemon = pokemon
            movesTVC.buttonPressed = buttonPressed
            movesTVC.pokemonMoves = pokemonMoves
        }
        
    }
}
