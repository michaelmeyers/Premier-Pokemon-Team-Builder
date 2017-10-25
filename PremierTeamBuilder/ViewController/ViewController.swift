//
//  ViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit
import CloudKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedTotal: UILabel!
    @IBOutlet weak var EVTextField: UITextField!
    @IBOutlet weak var IVTextField: UITextField!
    
    @IBOutlet weak var pokemonTeamNameTextField: UITextField!
    @IBOutlet weak var pokemonNameTextField: UITextField!
    
    var pokemonTeam: PokemonTeam?
    
    @IBAction func createPokemonTeamButtonTapped(_ sender: UIButton) {
        guard let text = pokemonTeamNameTextField.text else {return}
        let pokemonTeam = PokemonTeam(name: text)
        pokemonTeam.recordID = CKRecordID(recordName: "AWESOME")
        self.pokemonTeam = pokemonTeam
        guard let record = pokemonTeam.ckRecord else {return}
        PokemonTeamController.shared.savePokemonTeamRecord(record: record) { (success) in
            if success == true {
                print("Team Saved")
            } else {
                print("FAILED to save team")
            }
        }
    }
    
    @IBAction func createPokemonButtonTapped(_ sender: UIButton) {
        guard let pokemonTeam = pokemonTeam,
        let recordID = pokemonTeam.recordID else {return}
        let reference = CKReference(recordID: recordID, action: .deleteSelf)
        let pokemon = Pokemon(name: "pikachu", moves: ["Dig"], type1: Type.electric, type2: nil, abilities: ["static"], imageEndpoint: "blah", pokemonTeamRef: reference)
        guard let record = pokemon.ckRecord else {return}
        PokemonController.shared.savePokemonRecord(record: record) { (success) in
            if success == true {
                print("Pokemon Saved")
            } else {
                print("FAILED to save Pokemon")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PokemonTeamController.shared.fetchPokemonTeamsAndPokemonRecords {
            guard let pokemonTeam = PokemonTeamController.shared.pokemonTeams?[0],
            let pokemon = pokemonTeam.sixPokemon?[0] else {return}
            self.pokemonTeamNameTextField.text = pokemonTeam.name
            self.pokemonNameTextField.text = pokemon.name
            self.view.reloadInputViews()
        }
        setUpSlider()
        guard let dictionaryBug = typeDictionaries[Keys.typeBugKey],
            let dictionarySteel = typeDictionaries[Keys.typeSteelKey],
            let comboDictionary = add(dictionary1: dictionaryBug, toDictionary: dictionarySteel) else {
            print("Error with the add dictionary Function")
            return }
        print(comboDictionary)
    }

    @IBAction func updateSpeedSlider(_ sender: UISlider) {
        speedTotal.text = "\(Int(speedSlider.value))"
        EVTextField.text = "\(Int(speedSlider.value))"
    }
    
    func setUpSlider(){
        speedSlider.maximumValue = 252
        speedSlider.minimumValue = 0
        speedSlider.isContinuous = true
        EVTextField.delegate = self
        textFieldShouldReturn(EVTextField)
        
    }
    
    private func textFieldShouldReturn(_ textField: UITextField) {
        guard let text = textField.text, !text.isEmpty else {return}
        guard let textFloat = Float(text) else {return}
        speedSlider.value = textFloat
        speedTotal.text = "\(Int(speedSlider.value))"
        return
    }
}

