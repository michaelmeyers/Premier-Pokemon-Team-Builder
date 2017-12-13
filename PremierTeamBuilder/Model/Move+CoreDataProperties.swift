//
//  Move+CoreDataProperties.swift
//  PremierTeamBuilder
//
//  Created by Michael Meyers on 12/8/17.
//  Copyright © 2017 Michael Meyers. All rights reserved.
//
//

import Foundation
import CoreData


extension Move {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Move> {
        return NSFetchRequest<Move>(entityName: "Move")
    }
    
    @NSManaged public var accuracy: Int64
    @NSManaged public var catagory: String?
    @NSManaged public var effectChance: Int64
    @NSManaged public var id: Int64
    @NSManaged public var methodOfLearning: String?
    @NSManaged public var moveDescription: String?
    @NSManaged public var name: String
    @NSManaged public var power: Int64
    @NSManaged public var pp: Int64
    @NSManaged public var typeString: String?
    
}

