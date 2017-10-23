//
//  ViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/18/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedTotal: UILabel!
    @IBOutlet weak var EVTextField: UITextField!
    @IBOutlet weak var IVTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

