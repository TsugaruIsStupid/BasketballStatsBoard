//
//  PlayerData+CoreDataProperties.swift
//  
//
//  Created by KJ on 7/28/22.
//
//

import Foundation
import CoreData


extension PlayerData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlayerData> {
        return NSFetchRequest<PlayerData>(entityName: "PlayerData")
    }

    @NSManaged public var minutes: Double
    @NSManaged public var points: Int16
    @NSManaged public var rebounds: Int16
    @NSManaged public var assists: Int16
    @NSManaged public var steal: Int16
    @NSManaged public var block: Int16
    @NSManaged public var fg_percent: Double
    @NSManaged public var fg_made: Int16
    @NSManaged public var fg_attempt: Int16
    @NSManaged public var three_made: Int16
    @NSManaged public var three_attempt: Int16
    @NSManaged public var three_percent: Double
    @NSManaged public var ft_made: Int16
    @NSManaged public var ft_attempt: Int16
    @NSManaged public var ft_percent: Double
    @NSManaged public var off_reb: Int16
    @NSManaged public var def_reb: Int16
    @NSManaged public var turnover: Int16
    @NSManaged public var foul: Int16
    @NSManaged public var plus_minus: Int16
    @NSManaged public var block_against: Int16
    @NSManaged public var name: String?

}
