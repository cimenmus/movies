//
//  MovieCastEntity+CoreDataProperties.swift
//  
//
//  Created by mustafa içmen on 4.03.2021.
//
//

import Foundation
import CoreData


extension MovieCastEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieCastEntity> {
        return NSFetchRequest<MovieCastEntity>(entityName: "MovieCastEntity")
    }

    @NSManaged public var character: String?
    @NSManaged public var id: Int64
    @NSManaged public var imagePath: String?
    @NSManaged public var movieId: Int64
    @NSManaged public var name: String?
    @NSManaged public var order: Int64

}
