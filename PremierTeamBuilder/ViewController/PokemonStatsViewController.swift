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
    var textFieldBeingEdited: UITextField?
    var currentYShiftForKeyboard: CGFloat = 0
    
    let natures = changeNatureEnumToArray()
    var pokemon: Pokemon?
    
    var hpStatTotal: Int64 = 0
    var attackStatTotal: Int64 = 0
    var defenseStatTotal: Int64 = 0
    var spAttStatTotal: Int64 = 0
    var spDefStatTotal: Int64 = 0
    var speedStatTotal: Int64 = 0
    
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
    
    // MARK: - UI Setup
    func setUpUI() {
        setDelegates()
        setUpSliders()
        setSaveButton()
        guard let pokemon = pokemon else {return}
        setNavigationBarTitle(onViewController: self, withTitle: pokemon.name.uppercased())
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        // Added Tap Gesture to dismiss the Keyboard when user clicks off keyboard view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func setSaveButton() {
        navigationItem.rightBarButtonItem?.tintColor = .white
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
        evHPTextField.delegate = self
        evHPTextField.clearsOnBeginEditing = true
        evAttackTextField.clearsOnBeginEditing = true
        evAttackTextField.delegate = self
        evDefenseTextField.clearsOnBeginEditing = true
        evDefenseTextField.delegate = self
        evSpAttTextField.clearsOnBeginEditing = true
        evSpAttTextField.delegate = self
        evSpDefTextField.clearsOnBeginEditing = true
        evSpDefTextField.delegate = self
        evSpeedTextField.clearsOnBeginEditing = true
        evSpeedTextField.delegate = self
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
        pokemon?.natureString = nature.rawValue
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
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        guard let pokemon = pokemon,
        let text = textField.text else {return}
        
        guard let int = Int(text) else {return}
        guard int <= 31 else {
            presentSimpleAlert(controllerToPresentAlert: self, title: "IVs Cannot Exceed 31", message: "")
            textField.text = "0"
            return
        }
        
        if textField == ivHPTextField {
            guard let value = Int64(text) else {return}
            pokemon.ivHP = value
            updateUpUI()
        }
        if textField == ivAttackTextField {
            guard let value = Int64(text) else {return}
            pokemon.ivAttack = value
            updateUpUI()
        }
        if textField == ivDefenseTextField {
            guard let value = Int64(text) else {return}
            pokemon.ivDefense = value
            updateUpUI()
        }
        if textField == ivSpAttTextField {
            guard let value = Int64(text) else {return}
            pokemon.ivSpecialAttack = value
            updateUpUI()
        }
        if textField == ivSpDefTextField {
           guard let value = Int64(text) else {return}
            pokemon.ivSpecialDefense = value
            updateUpUI()
        }
        if textField == ivSpeedTextField {
            guard let value = Int64(text) else {return}
            pokemon.ivSpeed = value
            updateUpUI()
        }
    }
    
    func yShiftWhenKeyboardAppearsFor(textField: UITextField, keyboardHeight: CGFloat, nextY: CGFloat) -> CGFloat {
        
        let textFieldOrigin = self.view.convert(textField.frame, from: textField.superview!).origin.y
        let textFieldBottomY = textFieldOrigin + textField.frame.size.height
        
        // This is the y point that the textField's bottom can be at before it gets covered by the keyboard
        let maximumY = self.view.frame.height - keyboardHeight
        
        if textFieldBottomY > maximumY {
            // This makes the view shift the right amount to have the text field being edited 60 points above they keyboard if it would have been covered by the keyboard.
            return textFieldBottomY - maximumY + 60
        } else {
            // It would go off the screen if moved, and it won't be obscured by the keyboard.
            return 0
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        
        var keyboardSize: CGRect = .zero
        
        if let keyboardRect = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? CGRect,
            keyboardRect.height != 0 {
            keyboardSize = keyboardRect
        } else if let keyboardRect = notification.userInfo?["UIKeyboardBoundsUserInfoKey"] as? CGRect {
            keyboardSize = keyboardRect
        }
        
        if let textField = textFieldBeingEdited {
            if self.view.frame.origin.y == 0 {
                
                let yShift = yShiftWhenKeyboardAppearsFor(textField: textField, keyboardHeight: keyboardSize.height, nextY: keyboardSize.height)
                self.currentYShiftForKeyboard = yShift
                self.view.frame.origin.y -= yShift
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        
        if self.view.frame.origin.y != 0 {
            
            self.view.frame.origin.y += currentYShiftForKeyboard
        }
        stopEditingTextField()
    }
    
    func stopEditingTextField() {
        view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldBeingEdited = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    // MARK: - Actions
    //TODO: Add actions for each slider. or one action that identifies the sender.
    
    @IBAction func updateSlider(_ sender: UISlider) {
        updateInfo(sender: sender)
    }
    
    // MARK: - Slider Setup
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
            pokemon.evHP = Int64(rounded)
            evHPTextField.text = "\(Int64(rounded))"
            hpStatTotal = hpTotalCalculation()
            hpTotal.text = "\(hpStatTotal)"
        }
        if sender == attackSlider {
            let rounded = sender.value
            pokemon.evAttack = Int64(rounded)
            evAttackTextField.text = "\(Int64(rounded))"
            attackStatTotal = attTotalCalculation()
            attackTotal.text = "\(attackStatTotal)"
        }
        if sender == defenseSlider {
            let rounded = sender.value
            pokemon.evDefense = Int64(rounded)
            evDefenseTextField.text = "\(Int64(rounded))"
            defenseStatTotal = defTotalCalculation()
            defenseTotal.text = "\(defenseStatTotal)"
        }
        if sender == spAttSlider {
            let rounded = sender.value
            pokemon.evSpecialAttack = Int64(rounded)
            evSpAttTextField.text = "\(Int64(rounded))"
            spAttStatTotal = spAttTotalCalculation()
            spAttTotal.text = "\(spAttStatTotal)"
        }
        if sender == spDefSlider {
            let rounded = sender.value
            pokemon.evSpecialDefense = Int64(rounded)
            evSpDefTextField.text = "\(Int64(rounded))"
            spDefStatTotal = spDefTotalCalculation()
            spDefTotal.text = "\(spDefStatTotal)"
        }
        if sender == speedSlider {
            let rounded = sender.value
            pokemon.evSpeed = Int64(rounded)
            evSpeedTextField.text = "\(Int64(rounded))"
            speedStatTotal = speedTotalCalculation()
            speedTotal.text = "\(speedStatTotal)"
        }
    }
    
    // MARK: - Stat Total Calculations
    func hpTotalCalculation() -> Int64 {
        guard let pokemon = pokemon else {return 0}
        let hp = pokemon.hpStat
        let evHP = pokemon.evHP
        let ivHP = pokemon.ivHP
        let total = (hp * 2) + 110 + ((evHP/4)) + ivHP
        return total
    }
    
    func attTotalCalculation() -> Int64 {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.attackStat
        let ev = pokemon.evAttack
        let iv = pokemon.ivAttack
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        guard let nature = pokemon.nature else { return 0 }
        switch nature {
        case .adamant, .brave, .lonely, .naughty:
            total = total + (total / 10)
        case .bold, .modest, .calm, . timid:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func defTotalCalculation() -> Int64 {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.defenseStat
        let ev = pokemon.evDefense
        let iv = pokemon.ivDefense
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        guard let nature = pokemon.nature else {return 0}
        switch nature {
        case .bold, .impish, .relaxed, .lax:
            total = total + (total / 10)
        case .lonely, .mild, .gentle, .hasty:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func spAttTotalCalculation() -> Int64 {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.spAttackStat
        let ev = pokemon.evSpecialAttack
        let iv = pokemon.ivSpecialAttack
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        guard let nature = pokemon.nature else {return 0}
        switch nature {
        case .modest, .mild, .rash, .quiet:
            total = total + (total / 10)
        case .adamant, .impish, .careful, .jolly:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func spDefTotalCalculation() -> Int64 {
        guard let pokemon = pokemon else {return 0}
        let baseStat = pokemon.spDefenseStat
        let ev = pokemon.evSpecialDefense
        let iv = pokemon.ivSpecialDefense
        var total = (baseStat * 2) + 5 + ((ev / 4)) + iv
        guard let nature = pokemon.nature else {return 0}
        switch nature {
        case .calm, .gentle, .careful, .sassy:
            total = total + (total / 10)
        case .naughty, .lax, .rash, .naive:
            total = total - (total / 10)
        default:
            break
        }
        return total
    }
    
    func speedTotalCalculation() -> Int64 {
        guard let pokemon = pokemon else {return 0}
        let speed = pokemon.speedStat
        let evSpeed = pokemon.evSpeed
        let ivSpeed = pokemon.ivSpeed
        var total = (speed * 2) + 5 + ((evSpeed/4)) + ivSpeed
        guard let nature = pokemon.nature else {return 0}
        switch nature {
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
}
