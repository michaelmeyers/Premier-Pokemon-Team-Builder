//
//  PokemonSearchTableViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonSearchTableViewController: UITableViewController, UISearchBarDelegate {

    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonSearchBar.delegate = self
    }

    
    // MARK: - SearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else {return}
        PokemonController.shared.createPokemonObject(fromSearchTerm: searchTerm) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PokemonController.shared.searchResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.searchResultsCellIdentifier, for: indexPath) as? pokemonSearchTableViewCell else {return UITableViewCell()}
        let pokemon = PokemonController.shared.searchResults[indexPath.row]
        cell.pokemon = pokemon
        cell.updateCell()
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
        guard segue.identifier == Keys.segueIdentiferToPokemonDetailVCFromSearch,
            let tabBarController = segue.destination as? UITabBarController,
            let pokemonDetailVC = tabBarController.childViewControllers.first as? PokemonDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow else {return}
        let pokemon = PokemonController.shared.searchResults[indexPath.row]
        pokemonDetailVC.pokemonTeam = pokemonTeam
        pokemonDetailVC.pokemon = pokemon
    }

}
