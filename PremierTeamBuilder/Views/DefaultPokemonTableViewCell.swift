//
//  DefaultPokemonTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class DefaultPokemonTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    
    @IBOutlet weak var defaultImageView: UIImageView!
    @IBOutlet weak var defaultNameLabel: UILabel!
    @IBOutlet weak var defaultTypeLabel: UILabel!
    
    // MARK: - Cell Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultImageView.image = #imageLiteral(resourceName: "substitute")
        defaultNameLabel.text = "Click to add Pokemon"
        defaultTypeLabel.text = "???"
        defaultTypeLabel.layer.borderColor = UIColor.noTypeBorder.cgColor
        defaultTypeLabel.layer.backgroundColor = UIColor.noType.cgColor
        defaultTypeLabel.font = UIFont(name: "ArialRoundedMTBold", size: 15)
        defaultTypeLabel.layer.borderWidth = 3.0
        defaultTypeLabel.textColor = UIColor.white
        defaultTypeLabel.textAlignment = .center
        defaultTypeLabel.layer.cornerRadius = defaultTypeLabel.frame.height/2.5
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
