//
//  MovesListTableViewController.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 10/25/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//

import UIKit

class MovesListTableViewController: UITableViewController, MoveTableViewCellDelegate {
    
    // MARK: - Properties
    var pokemon: Pokemon?
    var moves: [Move]?
    var cellMove: Move?
    var buttonPressed: String?
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movesArray = pokemon?.movesArray {
            self.moves = movesArray
        } else {
            guard let pokemon = pokemon else {return}
            let moves = MoveController.shared.moves
            var pokemonMoves: [Move] = []
            for name in pokemon.moves {
                for move in moves {
                    if move.name.lowercased() == name.lowercased() {
                        pokemonMoves.append(move)
                    }
                }
            }
            let sortedMoves = pokemonMoves.sorted { $0.name < $1.name }
            pokemon.movesArray = sortedMoves
            self.moves = sortedMoves
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return moves?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.moveCellIdentifier, for: indexPath) as? MoveTableViewCell,
            let moves = moves else {return UITableViewCell()}
        let move = moves[indexPath.row]
        cell.move = move
        cell.delegate = self
        cell.updateCell()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let buttonPressed = buttonPressed,
            let indexPath = tableView.indexPathForSelectedRow,
            let pokemon = pokemon,
            let moves = moves else {return}
        let move = moves[indexPath.row]
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
        let alertController = UIAlertController(title: move.name, message: move.description, preferredStyle: .alert
        )
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
