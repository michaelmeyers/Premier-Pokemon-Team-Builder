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
    var currentTask: URLSessionTask?
    var sortedPokemon: [Pokemon] = []
    
    // MARK: - Outlets
    @IBOutlet weak var pokemonSearchBar: UISearchBar!
    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let currentTask = currentTask {
            currentTask.cancel()
            print( "Data Task Cancelled")
        }
    }
    
    
    // MARK: - Setup View
    func setUpUI() {
        setDelegates()
        sortedPokemon = PokemonController.shared.allPokemon
        setNavigationBarTitle(onViewController: self, withTitle: "Pokemon Search")
    }
    
    func setDelegates() {
        pokemonSearchBar.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        //Want to reset it "" i think
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let allPokemon = PokemonController.shared.allPokemon
        if searchText.isEmpty {
            
            // All Pokemon are viewed on Table View
            sortedPokemon = allPokemon
        } else if typesKeyArray.contains(searchText.lowercased())  {
            
            // Allows the user to search pokemon list by type
            sortedPokemon = allPokemon.filter({ $0.type1String == searchText.lowercased() || $0.type2String == searchText.lowercased() })
        } else {
            
            // Allows user to sort pokemon list by name
            sortedPokemon = allPokemon.filter { $0.name.lowercased().range(of: searchText.lowercased()) != nil}
        }
        resultsTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedPokemon.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.searchResultsCellIdentifier, for: indexPath) as? pokemonSearchTableViewCell else {return UITableViewCell()}
        let pokemon = sortedPokemon[indexPath.row]
        
        cell.pokemon = pokemon
        cell.updateCell()
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let pokemon = sortedPokemon[indexPath.row]
            PokemonController.shared.deletePokemonFromUserContext(pokemon: pokemon)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == Keys.segueIdentiferToPokemonDetailVCFromSearch,
            let pokemonDetailVC = segue.destination as? PokemonDetailViewController,
            let indexPath = resultsTableView.indexPathForSelectedRow,
            let pokemonTeam = pokemonTeam else { return }
        let pokemon = sortedPokemon[indexPath.row]
        let userPokemon = PokemonController.shared.createPokemon(onTeam: pokemonTeam, fromPokemonObject: pokemon)
        pokemonDetailVC.pokemon = userPokemon
        setBackBarButtonItem(ViewController: self)
    }
}
