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
    var teamName: String? {
        didSet{
            guard let teamName = teamName else {return}
            setNavigationBarTitle(onViewController: self, withTitle: teamName)
            tableView.reloadData()
        }
    }
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editTeamNameButton: UIButton!
    @IBOutlet weak var editTeamView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func unwindToPokemonTeamDetailVC(segue:UIStoryboardSegue) { }
    
    @IBAction func editTeamNameButtonTapped(_ sender: UIButton) {
        presentEditNameAlert()
    }

    // MARK: - setUpUI
    func setUpUI() {
        setDelegates()
        if let pokemonTeam = pokemonTeam {
            teamName = pokemonTeam.name
        }
        editTeamNameButton.titleLabel?.adjustsFontSizeToFitWidth = true
        editTeamNameButton.titleLabel?.minimumScaleFactor = 0.2
    }
    
    func setDelegates() {
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configuredCellBackgroundColor(forCell cell: UITableViewCell, withIndexPath indexPath: IndexPath) {
        if indexPath.row % 2 == 0 {
            cell.backgroundColor = .cellGray
        } else {
            cell.backgroundColor = .white
        }
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = tableView.frame.height - editTeamView.frame.height
        let cellCount = CGFloat(tableView.numberOfRows(inSection: 0))
        let cellheight = height/cellCount
        return cellheight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let pokemonTeam = pokemonTeam,
            pokemonTeam.sixPokemon?.count != 0 else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.defaultPokemonCellIdentifier, for: indexPath) as? DefaultPokemonTableViewCell else {return UITableViewCell()}
                configuredCellBackgroundColor(forCell: cell, withIndexPath: indexPath)
                return cell
        }
        guard let sixPokemon = pokemonTeam.sixPokemon else {guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.defaultPokemonCellIdentifier, for: indexPath) as? DefaultPokemonTableViewCell else {return UITableViewCell()}
            configuredCellBackgroundColor(forCell: cell, withIndexPath: indexPath)
            return cell}
        if indexPath.row <= sixPokemon.count - 1 {
            let pokemon = pokemonTeam.sixPokemon?[indexPath.row] as? Pokemon
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.pokemonCellIdentifier, for: indexPath) as? PokemonTableViewCell else {return UITableViewCell()}
            
            cell.backgroundColor = .cellGray
            
            cell.pokemon = pokemon
            cell.updatePokemonCell()
            configuredCellBackgroundColor(forCell: cell, withIndexPath: indexPath)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: Keys.defaultPokemonCellIdentifier, for: indexPath) as? DefaultPokemonTableViewCell else {return UITableViewCell()}
            configuredCellBackgroundColor(forCell: cell, withIndexPath: indexPath)
            return cell
        }
    }
    
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath)
            if cell?.isKind(of: DefaultPokemonTableViewCell.self) == true {
                presentSimpleAlert(controllerToPresentAlert: self, title: "", message: "Cannot delete default pokemon cell.")
                return
            }
            guard let pokemonTeam = pokemonTeam,
                let sixPokemon = pokemonTeam.sixPokemon,
                let pokemon = sixPokemon.object(at: indexPath.row) as? Pokemon else {return}
            //let newIndexPath = IndexPath(row: 5, section: 0)
            PokemonController.shared.deletePokemon(pokemon: pokemon, fromTeam: pokemonTeam)
            tableView.reloadData()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Keys.pokemonTeamDetailSegueIdentifier {
            guard let tabBarController = segue.destination as? UITabBarController,
                let pokemonDetailVC = tabBarController.childViewControllers.first as? PokemonDetailViewController,
                let pokemonStatsVC = tabBarController.childViewControllers[1] as? PokemonStatsViewController,
                let pokemonTeam = pokemonTeam,
                let indexPath = tableView.indexPathForSelectedRow,
                let sixPokemon = pokemonTeam.sixPokemon,
                let pokemon = sixPokemon.object(at: indexPath.row) as? Pokemon else {return}
            pokemonDetailVC.pokemon = pokemon
            pokemonDetailVC.pokemonTeam = pokemonTeam
            pokemonStatsVC.pokemon = pokemon
        }
        if segue.identifier == Keys.segueIdentifierToPokemonSearchVC {
            guard let pokemonSearchVC = segue.destination as? PokemonSearchViewController,
                let pokemonTeam = pokemonTeam else {return}
            pokemonSearchVC.pokemonTeam = pokemonTeam
            //PokemonController.shared.allPokemon = []
        }
        
        if segue.identifier == Keys.segueIdentifierToTeamWeaknessVC {
            guard let teamWeaknessVC = segue.destination as? TeamWeaknessViewController,
                let pokemonTeam = pokemonTeam else {return}
            teamWeaknessVC.pokemonTeam = pokemonTeam
        }
        setBackBarButtonItem(ViewController: self)
    }
    
    // MARK: - Alert Controller
    func presentEditNameAlert() {
        let alertController = UIAlertController(title: "Edit Pokemon Team Name", message: "What would you like your new name to be?", preferredStyle: .alert)
        var nameTextField = UITextField()
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Enter New Team Name"
            nameTextField = textfield
        }
        
        let change = UIAlertAction(title: "Change", style: .default) { (_) in
            guard let text = nameTextField.text, text != "",
            let pokemonTeam = self.pokemonTeam else {return}
            self.teamName = text
            PokemonTeamController.shared.updateTeam(pokemonTeam: pokemonTeam, newName: text)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(change)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}

// Outdated Code

//        if let pokemonTeam = pokemonTeam {
//            PokemonController.shared.fetchPokemonRecordFor(pokemonTeam: pokemonTeam, withRecordType: Keys.ckPokemonRecordType, completion: { (records, reference, error) in
//                if let error = error {
//                    print("There was an error fethcing Pokemon Data for CloudKit: \(error.localizedDescription)")
//                    return
//                }
//                PokemonController.shared.loadPokemon(fromRecords: records, pokemonTeamRef: reference, completion: { (pokemons) in
//                    guard let sixPokemon = pokemons else {return}
//                    pokemonTeam.sixPokemon = NSOrderedSet(array: sixPokemon)
//                    DispatchQueue.main.async {
//                        self.tableView.reloadData()
//                    }
//                })
//            })
//        }
