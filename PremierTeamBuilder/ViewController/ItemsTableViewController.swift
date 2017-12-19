//
//  ItemsTableViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/14/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class ItemsTableViewController: UITableViewController, UISearchBarDelegate {
    
    // MARK: - Properties
    var pokemon: Pokemon?
    var items: [String] {
        return PokemonTeamController.shared.items
    }
    var sortedItems: [String] = []

    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        sortedItems = items
        setNavigationBarTitle(onViewController: self, withTitle: "Choose Your Item")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedItems.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Keys.itemCellIdentifier, for: indexPath)
        
        let item = sortedItems[indexPath.row]
        cell.textLabel?.text = item

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let pokemon = pokemon else {return}
        let item = sortedItems[indexPath.row]
        pokemon.item = item
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Search Bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            // All Pokemon are viewed on Table View
            sortedItems = items
        } else {
            // Allows user to sort pokemon list by name
            sortedItems = items.filter { $0.lowercased().range(of: searchText.lowercased()) != nil}
        }
        tableView.reloadData()
    }

}
