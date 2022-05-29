//
//  MainTableViewController.swift
//  scorecounter
//
//  Created by Pavel Stupak on 15/04/2020.
//  Copyright © 2020 Pavel Stupak. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    var gameManager = GameManager()
    
    @IBOutlet weak var newGameButton: UIBarButtonItem!
    @IBOutlet weak var addRoundButton: UIBarButtonItem!
    
    @IBAction func newGameButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Current scores will be reseted", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        alert.addAction(UIAlertAction(title: "Continue", style: .default, handler: { (_) in
            self.gameManager.startNewGame()
            self.gameManager.savePlayers()
            self.gameManager.getCurrentGamePlayers()
            self.tableView.reloadData()
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gameManager.getCurrentGamePlayers()
        tableView.reloadData()
        
        newGameButton.isEnabled = !gameManager.currentGamePlayers.isEmpty
        addRoundButton.isEnabled = !gameManager.currentGamePlayers.isEmpty
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameManager.currentGamePlayers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = gameManager.currentGamePlayers[indexPath.row].name
        cell.detailTextLabel?.text = String(gameManager.currentGamePlayers[indexPath.row].points)

        return cell
    }
}
