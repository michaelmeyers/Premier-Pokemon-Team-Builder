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
        PokemonTeamController.shared.fetchPokemonTeamsAndPokemonRecords {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        if PokemonTeamController.shared.pokemonList.count == 0 {
            PokemonTeamController.shared.fetchListOfAllPokemon(completion: { (success) in
                if success == true {
                    print ("Pokemon List Fully Loaded")
                } else {
                    print ("There was an error with the pokemon List fetch")
                }
            })
        }
        if PokemonTeamController.shared.items.count == 1 {
        PokemonTeamController.shared.fetchItems { (success) in
            if success == true {
                print ("Item List Fully Loaded")
            } else {
                print ("There was an error with the Item List fetch")
            }
        }
        }
            MoveController.shared.createMove(fromSearchTerm: "ember", completion: { (move) in
                guard let move = move else {
                    print("No Move")
                    return
                }
                print (move.name)
            })
    }

    // MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        addTeamAlert()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PokemonTeamController.shared.pokemonTeams?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.pokemonTeamCellIdentifier, for: indexPath) as? PokemonTeamTableViewCell,
            let pokemonTeams = PokemonTeamController.shared.pokemonTeams else {return PokemonTeamTableViewCell()}
        let pokemonTeam = pokemonTeams[indexPath.row]
        
        cell.pokemonTeam = pokemonTeam
        cell.updatePokemonTeamCell()

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let pokemonTeam = PokemonTeamController.shared.pokemonTeams?[indexPath.row] else {return}
            PokemonTeamController.shared.deleteTeam(pokemonTeam: pokemonTeam)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Keys.pokemonTeamListTableViewSegueIdentifier,
        let tabBarController = segue.destination as? UITabBarController,
            let pokemonTeamDetailVC = tabBarController.childViewControllers.first as? PokemonTeamDetailTableViewController,
            let teamWeaknessVC = tabBarController.childViewControllers[1] as? TeamWeaknessViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        let pokemonTeam = PokemonTeamController.shared.pokemonTeams?[indexPath.row]
        pokemonTeamDetailVC.pokemonTeam = pokemonTeam
        teamWeaknessVC.pokemonTeam = pokemonTeam
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
