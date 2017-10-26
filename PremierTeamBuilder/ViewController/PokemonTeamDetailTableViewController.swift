//
//  PokemonTeamDetailTableViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonTeamDetailTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // MARK: - Propreties
    var pokemonTeam: PokemonTeam?

    @IBOutlet weak var teamNameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let pokemonTeam = pokemonTeam {
            teamNameTextField.text = pokemonTeam.name
        }
        teamNameTextField.delegate = self
        tableView.delegate = self
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let text = teamNameTextField.text, !text.isEmpty else {
            // PRESENT ALERT
            return
        }
        PokemonTeamController.shared.createTeam(withName: text)
        navigationController?.popViewController(animated: true)
    }
    
    
    private func textFieldShouldReturn(_ textField: UITextField){
        guard let text = teamNameTextField.text, !text.isEmpty else {return}
        if let pokemonTeam = pokemonTeam {
            pokemonTeam.name = text
        } else {
            PokemonTeamController.shared.createTeam(withName: text)
        }
    }


    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonTeam = pokemonTeam else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.defaultPokemonCellIdentifier, for: indexPath) as? DefaultPokemonTableViewCell else {return UITableViewCell()}
            return cell
        }
        guard let pokemon = pokemonTeam.sixPokemon[indexPath.row] else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.defaultPokemonCellIdentifier, for: indexPath) as? DefaultPokemonTableViewCell else {return UITableViewCell()}
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.pokemonCellIdentifier, for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
        
        cell.pokemon = pokemon
        cell.updatePokemonCell()

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
        if segue.identifier == Keys.pokemonTeamDetailSegueIdentifier {
            guard let tabBarController = segue.destination as? UITabBarController,
                let pokemonDetailVC = tabBarController.childViewControllers.first as? PokemonDetailViewController,
                let pokemonTeam = pokemonTeam,
                let indexPath = tableView.indexPathForSelectedRow,
                let pokemon = pokemonTeam.sixPokemon[indexPath.row] else {return}
            pokemonDetailVC.pokemon = pokemon
            pokemonDetailVC.pokemonTeam = pokemonTeam
        }
        if segue.identifier == Keys.segueIdentifierToPokemonSearchVC {
            guard let pokemonSearchTVC = segue.destination as? PokemonSearchTableViewController,
                let pokemonTeam = pokemonTeam else {return}
            pokemonSearchTVC.pokemonTeam = pokemonTeam
        }
    }


}
