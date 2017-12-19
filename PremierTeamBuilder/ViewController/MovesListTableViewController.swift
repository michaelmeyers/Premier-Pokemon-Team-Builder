//
//  MovesListTableViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class MovesListTableViewController: UITableViewController, MoveTableViewCellDelegate, UISearchBarDelegate {
    
    // MARK: - Properties
    var pokemon: Pokemon?
    var cellMove: Move?
    var buttonPressed: String?

    var sortedMoves: [Move] = []
    
    @IBOutlet weak var moveSearchBar: UISearchBar!
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        moveSearchBar.delegate = self
        setNavigationBarTitle(onViewController: self, withTitle: "Choose Your Move")
        if pokemon?.moves?.count == 0 {
            guard let pokemon = pokemon else {return}
            if pokemon.moveIDs.count != 0 {
                let moveIDs = pokemon.moveIDs
                let moves = MoveController.shared.moves
                var pokemonMoves: [Move] = []
                for id in moveIDs {
                    pokemonMoves.append(moves[Int(id) - 1])
                }
                let sortedMoves = pokemonMoves.sorted { $0.name < $1.name }
                pokemon.moves = NSOrderedSet(array: sortedMoves)
            }
        }
        guard let allMoves = pokemon?.moves?.array as? [Move] else {return}
        sortedMoves = allMoves
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sortedMoves.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.moveCellIdentifier, for: indexPath) as? MoveTableViewCell else {return UITableViewCell()}
        
        let move = sortedMoves[indexPath.row]
        
        cell.move = move
        cell.delegate = self
        cell.updateCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let buttonPressed = buttonPressed,
            let indexPath = tableView.indexPathForSelectedRow,
        let pokemon = pokemon else {return}
        let move = sortedMoves[indexPath.row]
        switch buttonPressed {
        case "move1": pokemon.move1 = move.name
        case "move2": pokemon.move2 = move.name
        case "move3": pokemon.move3 = move.name
        case "move4": pokemon.move4 = move.name
        default:
            fatalError("ButtonPressed string does not match moves1-4")
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let allMoves = pokemon?.moves?.array as? [Move] else {return}
        if searchText.isEmpty {
            
            // All Moves are viewed on Table View
            sortedMoves = allMoves
        } else {
            
            // Allows user to sort Move list by name
            sortedMoves = allMoves.filter { $0.name.lowercased().range(of: searchText.lowercased()) != nil}
        }
        tableView.reloadData()
    }

    
    // MARK: - Methods
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        guard segue.identifier == Keys.segueIdentifierBackToPokemonDetailVC,
    //            let pokemonDVC = segue.destination as? PokemonDetailViewController,
    //            let buttonPressed = buttonPressed,
    //            let indexPath = tableView.indexPathForSelectedRow,
    //            let pokemon = pokemon else {return}
    //        let move = moves[indexPath.row]
    //        switch buttonPressed {
    //        case "move1": pokemon.move1 = move.name
    //        case "move2": pokemon.move2 = move.name
    //        case "move3": pokemon.move3 = move.name
    //        case "move4": pokemon.move4 = move.name
    //        default:
    //            fatalError("ButtonPressed string does not match moves1-4")
    //        }
    //        pokemonDVC.pokemon = pokemon
    //    }
    
    
    // MARK: - MoveTableViewCell Delegate
    func moveTVCInfoButtonTapped(_ cell: MoveTableViewCell) {
        guard let move = cell.move else {return}
        cellMove = move
        infoAlert()
    }
    
    // MARK: - Alert Controller
    func infoAlert() {
        guard let move = cellMove else {return}
        let alertController = UIAlertController(title: move.name, message: move.moveDescription, preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
