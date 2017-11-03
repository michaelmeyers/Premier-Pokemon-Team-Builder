//
//  MoveTableViewCell.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 11/2/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class MoveTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    var move: Move?
    weak var delegate: MoveTableViewCellDelegate?
    
    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var catagoryImageView: UIImageView!
    @IBOutlet weak var powerTextLabel: UILabel!
    @IBOutlet weak var accuracyTextLabel: UILabel!
    @IBOutlet weak var ppTextLabel: UILabel!
    @IBOutlet weak var powerLabel: UILabel!
    @IBOutlet weak var accuracyLabel: UILabel!
    @IBOutlet weak var ppLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    
    // MARK: - Cell lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureInfoButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - Actions
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        delegate?.moveTVCInfoButtonTapped(self)
    }
    
    // MARK: - Cell Configuration
    func updateCell() {
        guard let move = move else {return}
        nameLabel.text = move.name
        changeLabelToTypeLabel(label: typeLabel, type: move.type)
        configuringImageIcon(imageView: catagoryImageView)
        powerTextLabel.text = "Power"
        accuracyTextLabel.text = "Accuracy"
        ppTextLabel.text = "PP"
        powerLabel.text = "\(move.power)"
        accuracyLabel.text = "\(move.accuracy)%"
        ppLabel.text = "\(move.pp)"
    }
    
    func configuringImageIcon(imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.height/2
        if move?.catagory == Keys.specialKey {
            imageView.image = #imageLiteral(resourceName: "special")
        }
        if move?.catagory == Keys.physicalKey {
            imageView.image = #imageLiteral(resourceName: "physical")
        }
        if move?.catagory == Keys.statusKey {
            imageView.image = #imageLiteral(resourceName: "status")
        }
    }
    
    func configureInfoButton() {
        infoButton.backgroundColor = UIColor.blue
        infoButton.setTitle("?", for: .normal)
        infoButton.setTitleColor(.white, for: .normal)
        infoButton.layer.cornerRadius = (infoButton.frame.height/2)
    }
}

protocol MoveTableViewCellDelegate: class {
    func moveTVCInfoButtonTapped(_ cell: MoveTableViewCell)
}
