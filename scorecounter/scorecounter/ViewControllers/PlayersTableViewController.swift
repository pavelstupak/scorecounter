//
//  PlayersTableViewController.swift
//  scorecounter
//
//  Created by Pavel Stupak on 15/04/2020.
//  Copyright © 2020 Pavel Stupak. All rights reserved.
//

import UIKit
import CoreData

class PlayersTableViewController: UITableViewController {
    
    var gameManager = GameManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBAction func addPlayerButtonPressed(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "New player", message: nil, preferredStyle: .alert)
        
        alert.addTextField { (textField) in textField.placeholder = "Enter player's name"
            textField.autocapitalizationType = .words
            textField.returnKeyType = .done
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields!.first
            let playerName = textField!.text!
            self.gameManager.addPlayer(name: playerName)
            self.tableView.insertRows(at: [IndexPath(row: self.gameManager.players.count-1, section: 0)], with: .fade)
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func inGameSwitchChanged(_ sender: UISwitch) {
        let cell = sender.superview?.superview as! PlayersTableViewCell
        let indexPath = tableView.indexPath(for: cell)
        gameManager.players[indexPath!.row].inGame.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setEditing(true, animated: true)
        tableView.tableFooterView = UIView()
        gameManager.getPlayers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gameManager.savePlayers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameManager.players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PlayersTableViewCell

        cell.textLabel?.text = gameManager.players[indexPath.row].name
        cell.inGameSwitch.isOn = gameManager.players[indexPath.row].inGame
        return cell
    }
	
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
			let player = gameManager.getPlayer(at: indexPath.row)
			gameManager.deletePlayer(player)
			gameManager.players.remove(at: indexPath.row)
			tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
