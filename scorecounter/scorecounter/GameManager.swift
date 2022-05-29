//
//  GameManager.swift
//  scorecounter
//
//  Created by Pavel Stupak on 15/04/2020.
//  Copyright © 2020 Pavel Stupak. All rights reserved.
//

import UIKit
import CoreData

class GameManager {
    var players: [Player] = []
    var currentGamePlayers: [Player] = []
    
    func getPlayers() {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        
        do {
            players = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
	
	func getPlayer(at index: Int) -> Player {
		return players[index]
	}
    
    func getCurrentGamePlayers() {
        getPlayers()
        currentGamePlayers = players.filter {$0.inGame}
    }
        
    func savePlayers() {
        let context = getContext()
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func addPlayer(name: String) {
        let context = getContext()
        guard let entity = NSEntityDescription.entity(forEntityName: "Player", in: context) else { return }
        
        let playerObject = Player(entity: entity, insertInto: context)
        playerObject.name = name
        playerObject.points = 0
        playerObject.inGame = true
        
        do {
            try context.save()
            players.append(playerObject)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
	
	func deletePlayer(_ player: Player) {
		let context = getContext()
		context.delete(player)
		do {
			try context.save()
		} catch let error as NSError {
			print(error.localizedDescription)
		}
	}
    
    func addPoints(extraPoints: Int16, to player: Player) {
        player.points += extraPoints
    }
    
    func startNewGame() {
        for player in players {
            player.points = 0
        }
    }
    
    private func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
