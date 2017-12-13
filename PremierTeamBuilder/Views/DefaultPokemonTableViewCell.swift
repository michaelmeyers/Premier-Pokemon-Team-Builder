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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
