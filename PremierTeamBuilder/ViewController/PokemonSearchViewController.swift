//
//  PokemonSearchViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 11/4/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class PokemonSearchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    // MARK: - Properties
    var pokemonTeam: PokemonTeam?
    var searchTerms: [String]?
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var searchTermTableView: UITableView!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        searchTerms = PokemonTeamController.shared.allSearchableItems
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        searchTermTableView.isHidden = true
        resultsTableView.isHidden = false
    }
    
    
    // MARK: - Setup View
    func setDelegates() {
        pokemonSearchBar.delegate = self
        searchTermTableView.delegate = self
        searchTermTableView.dataSource = self
        searchTermTableView.isHidden = true
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    // MARK: - SearchBarDelegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        PokemonController.shared.searchResults = []
        searchTermTableView.isHidden = true
        resultsTableView.isHidden = false
        searchBar.resignFirstResponder()
        guard let searchTerm = searchBar.text?.lowercased(), !searchTerm.isEmpty else {return}
        PokemonController.shared.createPokemonObject(fromSearchTerm: searchTerm) {
            print("Reload TableView")
            DispatchQueue.main.async {
                self.resultsTableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        resultsTableView.isHidden = true
        searchTermTableView.isHidden = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            searchTerms = PokemonTeamController.shared.allSearchableItems
            searchTermTableView.reloadData()
        } else {
            searchTerms = searchTerms?.filter {
                return $0.lowercased().range(of: searchText.lowercased()) != nil}
            searchTermTableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultsTableView {
            return PokemonController.shared.searchResults.count
        } else {
            return searchTerms?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == resultsTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.searchResultsCellIdentifier, for: indexPath) as? pokemonSearchTableViewCell else {return UITableViewCell()}
            let pokemon = PokemonController.shared.searchResults[indexPath.row]

            cell.pokemon = pokemon
            cell.updateCell()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Keys.searchTermCellIdentifier, for: indexPath)
            cell.textLabel?.text = searchTerms?[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchTermTableView {
            guard tableView == searchTermTableView else {return}
            let searchTerm = searchTerms?[indexPath.row]
            pokemonSearchBar.text = searchTerm
            searchBarSearchButtonClicked(pokemonSearchBar)
        }
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
            let indexPath = resultsTableView.indexPathForSelectedRow else {
                return
        }
        let pokemon = PokemonController.shared.searchResults[indexPath.row]
        pokemonDetailVC.pokemonTeam = pokemonTeam
        pokemonDetailVC.pokemonObject = pokemon
    }
    
    
}
