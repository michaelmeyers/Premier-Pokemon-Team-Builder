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
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - TableView Setup
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typesKeyArray.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = UITableViewCell(style: .default, reuseIdentifier: Keys.teamWeaknessHeaderIdentifier) as? TeamWeaknessHeaderTableViewCell else {return UITableViewCell()}
            cell.updateCell()
            return cell
            
        } else {
            guard let cell = UITableViewCell(style: .default, reuseIdentifier: Keys.teamWeaknessTypeIdentifier) as? TeamWeaknessTypeTableViewCell,
            let pokemonTeam = pokemonTeam else {return UITableViewCell()}
            let typeKey = typesKeyArray[indexPath.row - 1]
            cell.pokemonTeam = pokemonTeam
            cell.updateCell(withTypeKey: typeKey)
            return cell
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
