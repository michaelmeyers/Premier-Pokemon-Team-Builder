//
//  PokemonStatsViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonStatsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    var pokemon: Pokemon?
    
    var hpStatTotal: Int = 0
    var attackStatTotal: Int = 0
    var defenseStatTotal: Int = 0
    var spAttStatTotal: Int = 0
    var spDefStatTotal: Int = 0
    var speedStatTotal: Int = 0
    
    // MARK: - Outlets
    @IBOutlet weak var ivHPTextField: UITextField!
    @IBOutlet weak var evHPTextField: UITextField!
    @IBOutlet weak var hpTotal: UILabel!
    @IBOutlet weak var hpSlider: UISlider!
    
    @IBOutlet weak var ivAttackTextField: UITextField!
    @IBOutlet weak var evAttackTextField: UITextField!
    @IBOutlet weak var attackTotal: UILabel!
    @IBOutlet weak var attackSlider: UISlider!
    
    @IBOutlet weak var ivDefenseTextField: UITextField!
    @IBOutlet weak var evDefenseTextField: UITextField!
    @IBOutlet weak var defenseTotal: UILabel!
    @IBOutlet weak var defenseSlider: UISlider!
    
    @IBOutlet weak var ivSpAttTextField: UITextField!
    @IBOutlet weak var evSpAttTextField: UITextField!
    @IBOutlet weak var spAttTotal: UILabel!
    @IBOutlet weak var spAttSlider: UISlider!
    
    @IBOutlet weak var ivSpDefTextField: UITextField!
    @IBOutlet weak var evSpDefTextField: UITextField!
    @IBOutlet weak var spDefTotal: UILabel!
    @IBOutlet weak var spDefSlider: UISlider!
    
    @IBOutlet weak var ivSpeedTextField: UITextField!
    @IBOutlet weak var evSpeedTextField: UITextField!
    @IBOutlet weak var speedTotal: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        if pokemon != nil {
            setUpSlider(slider: hpSlider, evTextField: evHPTextField)
            setUpSlider(slider: attackSlider, evTextField: evAttackTextField)
            setUpSlider(slider: defenseSlider, evTextField: evDefenseTextField)
            setUpSlider(slider: spAttSlider, evTextField: evSpAttTextField)
            setUpSlider(slider: spDefSlider, evTextField: evSpDefTextField)
            setUpSlider(slider: speedSlider, evTextField: evSpeedTextField)
        }
        hpStatTotal = hpTotalCalculation()
        attackStatTotal = attTotalCalculation()
        defenseStatTotal = defTotalCalculation()
        spAttStatTotal = spAttTotalCalculation()
        spDefStatTotal = spDefTotalCalculation()
        speedStatTotal = speedTotalCalculation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    //TODO: Add actions for each slider. or one action that identifies the sender.
    
    @IBAction func updateSlider(_ sender: UISlider) {
        updateInfo(sender: sender)
    }
    
    
    // MARK: - UI Setup
    func setUpSlider(slider: UISlider, evTextField: UITextField) {
        slider.maximumValue = 252
        slider.minimumValue = 0
        evTextField.delegate = self
        textFieldShouldReturn(evTextField, slider: slider)
    }
    
    func textFieldShouldReturn(_ textField: UITextField, slider: UISlider) {
        guard let text = textField.text, !text.isEmpty,
            let textFloat = Float(text) else {return}
        slider.value = textFloat
        updateInfo(sender: slider)
        return
    }
    
    func updateInfo(sender: UISlider) {
        guard let pokemon = pokemon else {return}
        if sender == hpSlider {
            pokemon.evHP = Int(sender.value)
            evHPTextField.text = "\(Int(hpSlider.value))"
            hpStatTotal = hpTotalCalculation()
            hpTotal.text = "\(hpStatTotal)"
        }
        if sender == attackSlider {
            pokemon.evAttack = Int(sender.value)
            evAttackTextField.text = "\(Int(sender.value))"
            attackStatTotal = attTotalCalculation()
            attackTotal.text = "\(attackStatTotal)"
        }
        if sender == defenseSlider {
            pokemon.evDefense = Int(sender.value)
            evDefenseTextField.text = "\(Int(sender.value))"
            defenseStatTotal = defTotalCalculation()
            defenseTotal.text = "\(defenseStatTotal)"
        }
        if sender == spAttSlider {
            pokemon.evSpecialAttack = Int(sender.value)
            evSpAttTextField.text = "\(Int(sender.value))"
            spAttStatTotal = spAttTotalCalculation()
            spAttTotal.text = "\(spAttStatTotal)"
        }
        if sender == spDefSlider {
            pokemon.evSpecialDefense = Int(sender.value)
            evSpDefTextField.text = "\(Int(sender.value))"
            spDefStatTotal = spDefTotalCalculation()
            spDefTotal.text = "\(spDefStatTotal)"
        }
        if sender == speedSlider {
            pokemon.evSpeed = Int(sender.value)
            evSpeedTextField.text = "\(Int(sender.value))"
            speedStatTotal = speedTotalCalculation()
            speedTotal.text = "\(speedStatTotal)"
        }
    }
    
    func hpTotalCalculation() -> Int {
        guard let pokemon = pokemon else {return 0}
        let hp = pokemon.hpStat
        let evHP = pokemon.evHP
        let ivHP = pokemon.ivHP
        let total = (hp * 2) + 110 + ((evHP/4)) + ivHP
        return total
    }
    
    func attTotalCalculation() -> Int {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.attackStat
        let ev = pokemon.evAttack
        let iv = pokemon.ivAttack
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        switch pokemon.nature {
        case .adamant, .brave, .lonely, .naughty:
            total = total + (total / 10)
        case .bold, .modest, .calm, . timid:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func defTotalCalculation() -> Int {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.defenseStat
        let ev = pokemon.evDefense
        let iv = pokemon.ivDefense
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        switch pokemon.nature {
        case .bold, .impish, .relaxed, .lax:
            total = total + (total / 10)
        case .lonely, .mild, .gentle, .hasty:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func spAttTotalCalculation() -> Int {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.spAttackStat
        let ev = pokemon.evSpecialAttack
        let iv = pokemon.ivSpecialAttack
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        switch pokemon.nature {
        case .modest, .mild, .rash, .quiet:
            total = total + (total / 10)
        case .adamant, .impish, .careful, .jolly:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func spDefTotalCalculation() -> Int {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.spDefenseStat
        let ev = pokemon.evSpecialDefense
        let iv = pokemon.ivSpecialDefense
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        switch pokemon.nature {
        case .calm, .gentle, .careful, .sassy:
            total = total + (total / 10)
        case .naughty, .lax, .rash, .naive:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func speedTotalCalculation() -> Int {
        guard let pokemon = pokemon else {return 0}
        let speed = pokemon.speedStat
        let evSpeed = pokemon.evSpeed
        let ivSpeed = pokemon.ivSpeed
        var total = (speed * 2) + 5 + ((evSpeed/4)) + ivSpeed
        switch pokemon.nature {
        case .jolly, .timid, .naive, .hasty:
            total = total + (total / 10)
        case .brave, .sassy, .relaxed, . quiet:
            total = total - (total / 10)
        default:
            break
        }
        return total
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
