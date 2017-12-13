//
//  TeamWeaknessHeaderTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 11/1/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class TeamWeaknessHeaderTableViewCell: UITableViewCell {
    
    // MARK: - Propeties
    
    // MARK: - Outlets
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var label0: UILabel!
    @IBOutlet weak var fourthLabel: UILabel!
    @IBOutlet weak var halfLabel: UILabel!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var fourLabel: UILabel!
    
    // MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func updateCell() {
        typeLabel.text = "Type"
        typeLabel.textAlignment = .center
        
        label0.text = "0"
        label0.backgroundColor = .black
        label0.textColor = .white
        label0.textAlignment = .center
        
        halfLabel.text = "1/2"
        halfLabel.textAlignment = .center
        halfLabel.backgroundColor = .yellowGreen
        
        fourthLabel.text = "1/4"
        fourthLabel.textAlignment = .center
        fourLabel.backgroundColor = .greenBlue
        
        oneLabel.text = "1"
        oneLabel.textAlignment = .center
        oneLabel.backgroundColor = .yellow
        
        twoLabel.text = "2"
        twoLabel.textAlignment = .center
        twoLabel.backgroundColor = .orangeYellow
        
        fourLabel.text = "4"
        fourthLabel.textAlignment = .center
        twoLabel.backgroundColor = .red
    }
    
}
