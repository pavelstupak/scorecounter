//
//  Player+CoreDataProperties.swift
//  scorecounter
//
//  Created by Pavel Stupak on 01.05.2020.
//  Copyright © 2020 Pavel Stupak. All rights reserved.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String
    @NSManaged public var points: Int16
    @NSManaged public var inGame: Bool

}
