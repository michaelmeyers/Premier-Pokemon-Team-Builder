//
//  PokemonTeamListTableViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/24/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonTeamListTableViewController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Outlets
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        let nc = NotificationCenter.default
        nc.addObserver(self, selector: #selector(reloadTableView), name: Keys.notificationToReloadTableView, object: nil)
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - SetUpUI
    func setUpUI() {
        configureNavigationBar(onViewController: self)
        setNavigationBarTitle(onViewController: self, withTitle: "My Pokemon Teams")
    }
    
    @objc func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        addTeamAlert()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PokemonTeamController.shared.pokemonTeams.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.pokemonTeamCellIdentifier, for: indexPath) as? PokemonTeamTableViewCell else {return PokemonTeamTableViewCell()}
        let pokemonTeams = PokemonTeamController.shared.pokemonTeams
        let pokemonTeam = pokemonTeams[indexPath.row]
        cell.pokemonTeam = pokemonTeam
        cell.updatePokemonTeamCell()
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemonTeam = PokemonTeamController.shared.pokemonTeams[indexPath.row]
            PokemonTeamController.shared.deleteTeam(pokemonTeam: pokemonTeam, indexPath: indexPath)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Keys.pokemonTeamListTableViewSegueIdentifier,
            let pokemonTeamDetailVC = segue.destination as? PokemonTeamDetailTableViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        let pokemonTeam = PokemonTeamController.shared.pokemonTeams[indexPath.row]
        pokemonTeamDetailVC.pokemonTeam = pokemonTeam
        setBackBarButtonItem(ViewController: self)
    }
    
    // MARK: - Alert Controller
    func addTeamAlert() {
        var nameTextField = UITextField()
        let alertController = UIAlertController(title: "Create New Pokemon Team", message: "Pick a Team Name", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter Team Name"
            nameTextField = textfield
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            guard let text = nameTextField.text, !text.isEmpty else {return}
            let pokemonTeam = PokemonTeam(name: text)
            PokemonTeamController.shared.createTeam(pokemonTeam: pokemonTeam)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
