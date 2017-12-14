//
//  TeamWeaknessViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class TeamWeaknessViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var definitelyBalancedView: UIView!
    @IBOutlet weak var probablyBalancedView: UIView!
    @IBOutlet weak var teamWeaknessView: UIView!
    @IBOutlet weak var UnbalancedWeaknessView: UIView!
    @IBOutlet weak var teamNameLabel: UILabel!
    
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - SetUpUI
    func setUpUI() {
        setDelegates()
        configureLegend()
        setNavigationBarTitle(onViewController: self, withTitle: "Team Weakness Chart")
    }
    
    func configureLegend() {
        definitelyBalancedView.backgroundColor = UIColor.green
        probablyBalancedView.backgroundColor = UIColor.greenYellow
        teamWeaknessView.backgroundColor = UIColor.red
        UnbalancedWeaknessView.backgroundColor = UIColor.maroon
        guard let pokemonTeam = pokemonTeam else {return}
        teamNameLabel.text = pokemonTeam.name
    }
    
    func setDelegates() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
    }
    
    // MARK: - TableView Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesKeyArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height
        let cellCount = CGFloat(tableView.numberOfRows(inSection: 0))
        let cellheight = height/cellCount
        return cellheight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.teamWeaknessHeaderIdentifier, for: indexPath) as? TeamWeaknessHeaderTableViewCell else {return UITableViewCell()}
            cell.updateCell()
            return cell
            //guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.pokemonTeamCellIdentifier, for: indexPath) as? PokemonTeamTableViewCell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.teamWeaknessTypeIdentifier, for: indexPath) as? TeamWeaknessTypeTableViewCell,
                let pokemonTeam = pokemonTeam else {return UITableViewCell()}
            let typeKey = typesKeyArray[indexPath.row - 1]
            cell.pokemonTeam = pokemonTeam
            cell.updateCell(withTypeKey: typeKey)
            return cell
        }
    }
}
