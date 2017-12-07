//
//  Theme.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/27/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import Foundation
import UIKit

func changeLabelToTypeLabel(label: UILabel, type: Type) {
    
    // Designed for label framed width: 85 height: 28
    
    label.font = UIFont(name: "ArialRoundedMTBold", size: 15)
    label.layer.borderWidth = 3.0
    label.textColor = UIColor.white
    label.text = type.rawValue.uppercased()
    label.textAlignment = .center
    label.layer.cornerRadius = label.frame.height/2.5
    label.adjustsFontSizeToFitWidth = true
    label.minimumScaleFactor = 0.5
    switch type {
    case .bug:
        label.layer.borderColor = UIColor.bugBorder.cgColor
        label.layer.backgroundColor = UIColor.bug.cgColor
    case .dark:
        label.layer.borderColor = UIColor.darkBorder.cgColor
        label.layer.backgroundColor = UIColor.dark.cgColor
    case .dragon:
        label.layer.borderColor = UIColor.dragonBorder.cgColor
        label.layer.backgroundColor = UIColor.dragon.cgColor
    case .electric:
        label.layer.borderColor = UIColor.electricBorder.cgColor
        label.layer.backgroundColor = UIColor.electric.cgColor
    case .fairy:
        label.layer.borderColor = UIColor.fairyBorder.cgColor
        label.layer.backgroundColor = UIColor.fairy.cgColor
    case .fighting:
        label.layer.borderColor = UIColor.fightingBorder.cgColor
        label.layer.backgroundColor = UIColor.fighting.cgColor
    case .fire:
        label.layer.borderColor = UIColor.fireBorder.cgColor
        label.layer.backgroundColor = UIColor.fire.cgColor
    case .flying:
        label.layer.borderColor = UIColor.flyingBorder.cgColor
        label.layer.backgroundColor = UIColor.flying.cgColor
    case .ghost:
        label.layer.borderColor = UIColor.ghostBorder.cgColor
        label.layer.backgroundColor = UIColor.ghost.cgColor
    case .grass:
        label.layer.borderColor = UIColor.grassBorder.cgColor
        label.layer.backgroundColor = UIColor.grass.cgColor
    case .ground:
        label.layer.borderColor = UIColor.groundBorder.cgColor
        label.layer.backgroundColor = UIColor.ground.cgColor
    case .ice:
        label.layer.borderColor = UIColor.iceBorder.cgColor
        label.layer.backgroundColor = UIColor.ice.cgColor
    case .normal:
        label.layer.borderColor = UIColor.normalBorder.cgColor
        label.layer.backgroundColor = UIColor.normal.cgColor
    case .poison:
        label.layer.borderColor = UIColor.poisonBorder.cgColor
        label.layer.backgroundColor = UIColor.poison.cgColor
    case .psychic:
        label.layer.borderColor = UIColor.psychicBorder.cgColor
        label.layer.backgroundColor = UIColor.psychic.cgColor
    case .rock:
        label.layer.borderColor = UIColor.rockBorder.cgColor
        label.layer.backgroundColor = UIColor.rock.cgColor
    case .steel:
        label.layer.borderColor = UIColor.steelBorder.cgColor
        label.layer.backgroundColor = UIColor.steel.cgColor
    case .water:
        label.layer.borderColor = UIColor.waterBorder.cgColor
        label.layer.backgroundColor = UIColor.water.cgColor
    }
}

func changeLabelToDefaultTypeLabel(label: UILabel) {
    label.font = UIFont(name: "ArialRoundedMTBold", size: 15)
    label.layer.borderWidth = 3.0
    label.textColor = UIColor.white
    label.text = "???"
    label.textAlignment = .center
    label.layer.cornerRadius = label.frame.height/2.5
    label.layer.borderColor = UIColor.noTypeBorder.cgColor
    label.layer.backgroundColor = UIColor.noType.cgColor
}

extension UIColor {
    
    // MARK: - Main Type Color
    static var bug: UIColor{
        return UIColor(red: 168.0/255.0, green: 184.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    }
    static var dark: UIColor {
        return UIColor(red: 112.0/255.0, green: 88.0/255.0, blue: 72.0/255.0, alpha: 1.0)
    }
    static var dragon: UIColor {
        return UIColor(red: 120.0/255.0, green: 65.0/255.0, blue: 252.0/255.0, alpha: 1.0)
    }
    static var electric: UIColor {
        return UIColor(red: 251.0/255.0, green: 217.0/255.0, blue: 78.0/255.0, alpha: 1.0)
    }
    static var fairy: UIColor {
        return UIColor(red: 238.0/255.0, green: 153.0/255.0, blue: 172.0/255.0, alpha: 1.0)
    }
    static var fighting: UIColor {
        return UIColor(red: 192.0/255.0, green: 42.0/255.0, blue: 32.0/255.0, alpha: 1.0)
    }
    static var flying: UIColor {
        return UIColor(red: 167.0/255.0, green: 142.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
    static var ghost: UIColor {
        return UIColor(red: 109.0/255.0, green: 85.0/255.0, blue: 149.0/255.0, alpha: 1.0)
    }
    static var grass: UIColor {
        return UIColor(red: 98.0/255.0, green: 222.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }
    static var ice: UIColor {
        return UIColor(red: 98.0/255.0, green: 212.0/255.0, blue: 212.0/255.0, alpha: 1.0)
    }
    static var normal: UIColor {
        return UIColor(red: 170.0/255.0, green: 170.0/255.0, blue: 123.0/255.0, alpha: 1.0)
    }
    static var poison: UIColor {
        return UIColor(red: 141.0/255.0, green: 50.0/255.0, blue: 141.0/255.0, alpha: 1.0)
    }
    static var psychic: UIColor {
        return UIColor(red: 225.0/255.0, green: 71.0/255.0, blue: 102.0/255.0, alpha: 1.0)
    }
    static var ground: UIColor {
        return UIColor(red: 211.0/255.0, green: 184.0/255.0, blue: 104.0/255.0, alpha: 1.0)
    }
    static var rock: UIColor {
        return UIColor(red: 135.0/255.0, green: 108.0/255.0, blue: 35.0/255.0, alpha: 1.0)
    }
    static var steel: UIColor {
        return UIColor(red: 163.0/255.0, green: 163.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    }
    static var water: UIColor {
        return UIColor(red: 66.0/255.0, green: 100.0/255.0, blue: 210.0/255.0, alpha: 1.0)
    }
    static var fire: UIColor {
        return UIColor(red: 235.0/255.0, green: 89.0/255.0, blue: 43.0/255.0, alpha: 1.0)
    }
    static var noType: UIColor {
        return UIColor(red: 103.0/255.0, green: 159.0/255.0, blue: 143.0/255.0, alpha: 1.0)
    }
    
    // MARK: - Type Border Colors
    static var bugBorder: UIColor {
        return UIColor(red: 98.0/255.0, green: 109.0/255.0, blue: 7.0/255.0, alpha: 1.0)
    }
    static var darkBorder: UIColor {
        return UIColor(red: 64.0/255.0, green: 48.0/255.0, blue: 36.0/255.0, alpha: 1.0)
    }
    static var dragonBorder: UIColor {
        return UIColor(red: 64.0/255.0, green: 27.0/255.0, blue: 153.0/255.0, alpha: 1.0)
    }
    static var electricBorder: UIColor {
        return UIColor(red: 149.0/255.0, green: 123.0/255.0, blue: 15.0/255.0, alpha: 1.0)
    }
    static var fairyBorder: UIColor {
        return UIColor(red: 145.0/255.0, green: 89.0/255.0, blue: 101.0/255.0, alpha: 1.0)
    }
    static var fightingBorder: UIColor {
        return UIColor(red: 124.0/255.0, green: 31.0/255.0, blue: 25.0/255.0, alpha: 1.0)
    }
    static var fireBorder: UIColor {
        return UIColor(red: 147.0/255.0, green: 74.0/255.0, blue: 20.0/255.0, alpha: 1.0)
    }
    static var flyingBorder: UIColor {
        return UIColor(red: 104.0/255.0, green: 89.0/255.0, blue: 151.0/255.0, alpha: 1.0)
    }
    static var ghostBorder: UIColor {
        return UIColor(red: 62.0/255.0, green: 44.0/255.0, blue: 89.0/255.0, alpha: 1.0)
    }
    static var groundBorder: UIColor {
        return UIColor(red: 141.0/255.0, green: 118.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    }
    static var iceBorder: UIColor {
        return UIColor(red: 89.0/255.0, green: 133.0/255.0, blue: 133.0/255.0, alpha: 1.0)
    }
    static var normalBorder: UIColor {
        return UIColor(red: 100.0/255.0, green: 100.0/255.0, blue: 68.0/255.0, alpha: 1.0)
    }
    static var poisonBorder: UIColor {
        return UIColor(red: 93.0/255.0, green: 29.0/255.0, blue: 93.0/255.0, alpha: 1.0)
    }
    static var psychicBorder: UIColor {
        return UIColor(red: 152.0/255.0, green: 46.0/255.0, blue: 79.0/255.0, alpha: 1.0)
    }
    static var rockBorder: UIColor {
        return UIColor(red: 113.0/255.0, green: 97.0/255.0, blue: 29.0/255.0, alpha: 1.0)
    }
    static var steelBorder: UIColor {
        return UIColor(red: 111.0/255.0, green: 111.0/255.0, blue: 126.0/255.0, alpha: 1.0)
    }
    static var waterBorder: UIColor {
        return UIColor(red: 58.0/255.0, green: 84.0/255.0, blue: 147.0/255.0, alpha: 1.0)
    }
    static var noTypeBorder: UIColor {
        return UIColor(red: 56.0/255.0, green: 92.0/255.0, blue: 82.0/255.0, alpha: 1.0)
    }
    static var grassBorder: UIColor {
        return UIColor(red: 67.0/255.0, green: 122.0/255.0, blue: 41.0/255.0, alpha: 1.0)
    }
    
    // MARK: - BarGraph Colors
    static var maroon: UIColor {
        return UIColor(red: 197.0/255.0, green: 3.0/255.0, blue: 58.0/255.0, alpha: 1.0)
    }
    static var redOrange: UIColor {
        return UIColor(red: 236.0/255.0, green: 130.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    static var orangeYellow: UIColor {
        return UIColor(red: 243.0/255.0, green: 184.0/255.0, blue: 60.0/255.0, alpha: 1.0)
    }
    static var brightYellow: UIColor {
        return UIColor(red: 234.0/255.0, green: 244.0/255.0, blue: 42.0/255.0, alpha: 1.0)
    }
    static var yellowGreen: UIColor {
        return UIColor(red: 152.0/255.0, green: 237.0/255.0, blue: 57.0/255.0, alpha: 1.0)
    }
    static var greenYellow: UIColor {
        return UIColor(red: 76.0/255.0, green: 255.0/255.0, blue: 100.0/255.0, alpha: 1.0)
    }
    static var greenish: UIColor {
        return UIColor(red: 22.0/255.0, green: 242.0/255.0, blue: 150.0/255.0, alpha: 1.0)
    }
    static var greenBlue: UIColor {
        return UIColor(red: 80.0/255.0, green: 227.0/255.0, blue: 194.0/255.0, alpha: 1.0)
    }
}
