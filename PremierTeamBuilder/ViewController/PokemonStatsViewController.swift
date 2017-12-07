//
//  PokemonStatsViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonStatsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    let natures = changeNatureEnumToArray()
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
    
    @IBOutlet weak var naturePickerView: UIPickerView!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUpUI()
    }
    
    // MARK: - Pickerview Delegate and DataSoucre
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return natures.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let nature = natures[row]
        let title = addStringToNature(nature: nature)
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let nature = natures[row]
        pokemon?.nature = nature
        updateUpUI()
    }
    
    func addStringToNature (nature: Nature) -> String {
        switch nature {
        case .adamant: return nature.rawValue+" +Atk -SpAtk"
        case .bashful: return nature.rawValue+" Neutral"
        case .bold: return nature.rawValue+" +Def -Atk"
        case .brave: return nature.rawValue+" +Atk -Speed"
        case .calm: return nature.rawValue+" +SpDef -Atk"
        case .careful: return nature.rawValue+" +SpDef -SpAtk"
        case .docile: return nature.rawValue+" Neutral"
        case .gentle: return nature.rawValue+" +SpDef -Def"
        case .hardy: return nature.rawValue+" Neutral"
        case .hasty: return nature.rawValue+" +Speed -SpAtk"
        case .impish: return nature.rawValue+" +Def -SpAtk"
        case .jolly: return nature.rawValue+" +Speed -SpAtk"
        case .lax: return nature.rawValue+" +Def -SpDef"
        case .lonely: return nature.rawValue+" +Atk -Def"
        case .mild: return nature.rawValue+" +SpAtk -Def"
        case .modest: return nature.rawValue+" +SpAtk -Atk"
        case .naive: return nature.rawValue+" +Speed -SpDef"
        case .naughty: return nature.rawValue+" +Atk -SpDef"
        case .quiet: return nature.rawValue+" +SpAtk -Speed"
        case .quirky: return nature.rawValue+" Neutral"
        case .rash: return nature.rawValue+" +SpAtk -SpDef"
        case .relaxed: return nature.rawValue+" +Def -Speed"
        case .sassy: return nature.rawValue+" +SpDef -Speed"
        case .serious: return nature.rawValue+" Neutral"
        case .timid: return nature.rawValue+" +Speed -Atk"
        }
    }
    
    // MARK: - TextFields Datasoucre and Delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.clearsOnBeginEditing = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        guard let pokemon = pokemon else {return}
        
        if textField == ivHPTextField {
            guard let text = textField.text,
                let value = Int(text) else {return}
            pokemon.ivHP = value
            updateUpUI()
        }
        if textField == ivAttackTextField {
            guard let text = textField.text,
                let value = Int(text) else {return}
            pokemon.ivAttack = value
            updateUpUI()
        }
        if textField == ivDefenseTextField {
            guard let text = textField.text,
                let value = Int(text) else {return}
            pokemon.ivDefense = value
            updateUpUI()
        }
        if textField == ivSpAttTextField {
            guard let text = textField.text,
                let value = Int(text) else {return}
            pokemon.ivSpecialAttack = value
            updateUpUI()
        }
        if textField == ivSpDefTextField {
            guard let text = textField.text,
                let value = Int(text) else {return}
            pokemon.ivSpecialDefense = value
            updateUpUI()
        }
        if textField == ivSpeedTextField {
            guard let text = textField.text,
                let value = Int(text) else {return}
            pokemon.ivSpeed = value
            updateUpUI()
        }
    }
    
    // MARK: - Actions
    //TODO: Add actions for each slider. or one action that identifies the sender.
    
    @IBAction func updateSlider(_ sender: UISlider) {
        updateInfo(sender: sender)
    }
    
    
    // MARK: - UI Setup
    func setUpUI() {
        setDelegates()
        setUpSliders()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    func setUpSliders() {
        setUpSlider(slider: hpSlider, evTextField: evHPTextField)
        setUpSlider(slider: attackSlider, evTextField: evAttackTextField)
        setUpSlider(slider: defenseSlider, evTextField: evDefenseTextField)
        setUpSlider(slider: spAttSlider, evTextField: evSpAttTextField)
        setUpSlider(slider: spDefSlider, evTextField: evSpDefTextField)
        setUpSlider(slider: speedSlider, evTextField: evSpeedTextField)
    }
    
    func setDelegates() {
        naturePickerView.delegate = self
        naturePickerView.dataSource = self
        ivHPTextField.delegate = self
        ivHPTextField.clearsOnBeginEditing = true
        ivAttackTextField.delegate = self
        ivAttackTextField.clearsOnBeginEditing = true
        ivDefenseTextField.delegate = self
        ivDefenseTextField.clearsOnBeginEditing = true
        ivSpAttTextField.delegate = self
        ivSpAttTextField.clearsOnBeginEditing = true
        ivSpDefTextField.delegate = self
        ivSpDefTextField.clearsOnBeginEditing = true
        ivSpeedTextField.delegate = self
        ivSpeedTextField.clearsOnBeginEditing = true
        evHPTextField.clearsOnBeginEditing = true
        evAttackTextField.clearsOnBeginEditing = true
        evDefenseTextField.clearsOnBeginEditing = true
        evSpAttTextField.clearsOnBeginEditing = true
        evSpDefTextField.clearsOnBeginEditing = true
        evSpeedTextField.clearsOnBeginEditing = true
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func updateUpUI() {
        guard let pokemon = pokemon else {return}
        
        hpSlider.value = Float(pokemon.evHP)
        attackSlider.value = Float(pokemon.evAttack)
        defenseSlider.value = Float(pokemon.evDefense)
        spAttSlider.value = Float(pokemon.evSpecialAttack)
        spDefSlider.value = Float(pokemon.evSpecialDefense)
        speedSlider.value = Float(pokemon.evSpeed)
        
        hpStatTotal = hpTotalCalculation()
        attackStatTotal = attTotalCalculation()
        defenseStatTotal = defTotalCalculation() 
        spAttStatTotal = spAttTotalCalculation()
        spDefStatTotal = spDefTotalCalculation()
        speedStatTotal = speedTotalCalculation()
        hpTotal.text = "\(hpStatTotal)"
        attackTotal.text = "\(attackStatTotal)"
        defenseTotal.text = "\(defenseStatTotal)"
        spAttTotal.text = "\(spAttStatTotal)"
        spDefTotal.text = "\(spDefStatTotal)"
        speedTotal.text = "\(speedStatTotal)"
        
        ivHPTextField.text = "\(pokemon.ivHP)"
        ivAttackTextField.text = "\(pokemon.ivAttack)"
        ivDefenseTextField.text = "\(pokemon.ivDefense)"
        ivSpAttTextField.text = "\(pokemon.ivSpecialAttack)"
        ivSpDefTextField.text = "\(pokemon.ivSpecialDefense)"
        ivSpeedTextField.text = "\(pokemon.ivSpeed)"
        
        evHPTextField.text = "\(pokemon.evHP)"
        evAttackTextField.text = "\(pokemon.evAttack)"
        evDefenseTextField.text = "\(pokemon.evDefense)"
        evSpAttTextField.text = "\(pokemon.evSpecialAttack)"
        evSpDefTextField.text = "\(pokemon.evSpecialDefense)"
        evSpeedTextField.text = "\(pokemon.evSpeed)"
    }
    
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
            let rounded = sender.value
            pokemon.evHP = Int(rounded)
            evHPTextField.text = "\(Int(rounded))"
            hpStatTotal = hpTotalCalculation()
            hpTotal.text = "\(hpStatTotal)"
        }
        if sender == attackSlider {
            let rounded = sender.value
            pokemon.evAttack = Int(rounded)
            evAttackTextField.text = "\(Int(rounded))"
            attackStatTotal = attTotalCalculation()
            attackTotal.text = "\(attackStatTotal)"
        }
        if sender == defenseSlider {
            let rounded = sender.value
            pokemon.evDefense = Int(rounded)
            evDefenseTextField.text = "\(Int(rounded))"
            defenseStatTotal = defTotalCalculation()
            defenseTotal.text = "\(defenseStatTotal)"
        }
        if sender == spAttSlider {
            let rounded = sender.value
            pokemon.evSpecialAttack = Int(rounded)
            evSpAttTextField.text = "\(Int(rounded))"
            spAttStatTotal = spAttTotalCalculation()
            spAttTotal.text = "\(spAttStatTotal)"
        }
        if sender == spDefSlider {
            let rounded = sender.value
            pokemon.evSpecialDefense = Int(rounded)
            evSpDefTextField.text = "\(Int(rounded))"
            spDefStatTotal = spDefTotalCalculation()
            spDefTotal.text = "\(spDefStatTotal)"
        }
        if sender == speedSlider {
            let rounded = sender.value
            pokemon.evSpeed = Int(rounded)
            evSpeedTextField.text = "\(Int(rounded))"
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
    
    func calculateSliderBarTotal() -> Float {
        var total: Float = 0.0
        total += round(hpSlider.value)
        total += round(attackSlider.value)
        total += round(defenseSlider.value)
        total += round(spAttSlider.value)
        total += round(spDefSlider.value)
        total += round(speedSlider.value)
        return total
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        let total = calculateSliderBarTotal()
        if total > 508 {
            presentSimpleAlert(controllerToPresentAlert: self, title: "", message: "Total Pokemon EVs cannot exceed 508")
            var difference = sender.value - (total - 508)
            difference = round(difference)
            sender.value = difference
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
