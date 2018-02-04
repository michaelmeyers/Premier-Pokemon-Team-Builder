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
    var pokemonMoves: [Move]?
    var cellMove: Move?
    var buttonPressed: String?
    
    // MARK: - ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pokemonMoves?.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.moveCellIdentifier, for: indexPath) as? MoveTableViewCell,
        let moves = pokemonMoves else {return UITableViewCell()}
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
        let moves = pokemonMoves else {return}
        let move = moves[indexPath.row]
        switch buttonPressed {
        case "move1": pokemon.move1 = move.name
        case "move2": pokemon.move2 = move.name
        case "move3": pokemon.move3 = move.name
        case "move4": pokemon.move4 = move.name
        default:
            fatalError("ButtonPressed string does not match moves1-4")
        }
        navigationController?.popViewController(animated: true)
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
