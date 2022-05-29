//
//  AddRoundTableViewController.swift
//  scorecounter
//
//  Created by Pavel Stupak on 15/04/2020.
//  Copyright © 2020 Pavel Stupak. All rights reserved.
//

import UIKit

class AddRoundTableViewController: UITableViewController {
    var gameManager = GameManager()
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        for index in 0..<gameManager.currentGamePlayers.count {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! AddRoundTableViewCell
            let number = Int16(cell.enterScoreTextField.text!)
            gameManager.addPoints(extraPoints: number ?? 0, to: gameManager.currentGamePlayers[index])
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        gameManager.getCurrentGamePlayers()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameManager.currentGamePlayers.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AddRoundTableViewCell

        cell.textLabel?.text = gameManager.currentGamePlayers[indexPath.row].name

        return cell
    }
}
