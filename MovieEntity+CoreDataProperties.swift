//
//  MovieEntity+CoreDataProperties.swift
//  
//
//  Created by mustafa içmen on 4.03.2021.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var adult: Bool
    @NSManaged public var average: Double
    @NSManaged public var backdropImagePath: String?
    @NSManaged public var id: Int64
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var posterImagePath: String?
    @NSManaged public var releaseDate: String?
    @NSManaged public var title: String?
    @NSManaged public var voteCount: Int64

}
