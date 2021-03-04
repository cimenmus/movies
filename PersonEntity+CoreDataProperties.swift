//
//  PersonEntity+CoreDataProperties.swift
//  
//
//  Created by mustafa içmen on 4.03.2021.
//
//

import Foundation
import CoreData


extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
    }

    @NSManaged public var biography: String?
    @NSManaged public var id: Int64
    @NSManaged public var imagePath: String?
    @NSManaged public var name: String?

}
