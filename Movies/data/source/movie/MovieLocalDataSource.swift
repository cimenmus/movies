//
//  MovieLocalDataSource.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import Combine
import CoreData
import UIKit

struct MovieLocalDataSource: MovieDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getPopularMovies(page: Int) -> AnyPublisher<[MovieModel], AppError> {
        return DatabaseResult<[MovieModel]>(
            request: {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
                let sort = NSSortDescriptor(key: #keyPath(MovieEntity.popularity), ascending: false)
                request.sortDescriptors = [sort]
                request.fetchLimit = Constants.Movie.PAGE_LIMIT
                request.fetchOffset = (page - 1) * Constants.Movie.PAGE_LIMIT
                request.returnsObjectsAsFaults = false
                
                do {
                    var movieList = [MovieModel]()
                    let results = try self.context.fetch(request) as! [NSManagedObject]
                    for entity in results {
                        let movie = MovieModel(
                            id: entity.value(forKey: "id") as? Int,
                            adult: entity.value(forKey: "adult") as? Bool,
                            posterImagePath: entity.value(forKey: "posterImagePath") as? String,
                            backdropImagePath: entity.value(forKey: "backdropImagePath") as? String,
                            title: entity.value(forKey: "title") as? String,
                            overview: entity.value(forKey: "overview") as? String,
                            average: entity.value(forKey: "average") as? Double,
                            voteCount: entity.value(forKey: "voteCount") as? Int,
                            releaseDate: entity.value(forKey: "releaseDate") as? String,
                            popularity: entity.value(forKey: "popularity") as? Double)
                        movieList.append(movie)
                    }
                    return movieList
                } catch {
                    return nil
                }
            }
        ).execute()
    }
    
    func saveMovies(movies: [MovieModel]) {
        
        for movie in movies {
            let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: context)
            let managedObject = NSManagedObject(entity: entity!, insertInto: context)
            managedObject.setValue(movie.id, forKey: "id")
            managedObject.setValue(movie.adult, forKey: "adult")
            managedObject.setValue(movie.posterImagePath, forKey: "posterImagePath")
            managedObject.setValue(movie.backdropImagePath, forKey: "backdropImagePath")
            managedObject.setValue(movie.title, forKey: "title")
            managedObject.setValue(movie.overview, forKey: "overview")
            managedObject.setValue(movie.average, forKey: "average")
            managedObject.setValue(movie.voteCount, forKey: "voteCount")
            managedObject.setValue(movie.releaseDate, forKey: "releaseDate")
            managedObject.setValue(movie.popularity, forKey: "popularity")
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func getCastOfMovie(movieId: Int) -> AnyPublisher<[MovieCastModel], AppError> {
        return DatabaseResult<[MovieCastModel]>(
            request: {
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieCastEntity")
                let sort = NSSortDescriptor(key: #keyPath(MovieCastEntity.order), ascending: true)
                request.sortDescriptors = [sort]
                request.predicate = NSPredicate(format: "movieId = %i", movieId)
                request.returnsObjectsAsFaults = false
                
                do {
                    var movieCastList = [MovieCastModel]()
                    let results = try self.context.fetch(request) as! [NSManagedObject]
                    for entity in results {
                        let movieCast = MovieCastModel(
                            id: entity.value(forKey: "id") as? Int,
                            name: entity.value(forKey: "name") as? String,
                            character: entity.value(forKey: "character") as? String,
                            order: entity.value(forKey: "order") as? Int,
                            movieId: entity.value(forKey: "movieId") as? Int,
                            imagePath: entity.value(forKey: "imagePath") as? String)
                        movieCastList.append(movieCast)
                    }
                    return movieCastList
                } catch {
                    return nil
                }
            }
        ).execute()
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {
        
        for cast in movieCast {
            let entity = NSEntityDescription.entity(forEntityName: "MovieCastEntity", in: context)
            let managedObject = NSManagedObject(entity: entity!, insertInto: context)
            managedObject.setValue(cast.id, forKey: "id")
            managedObject.setValue(cast.name, forKey: "name")
            managedObject.setValue(cast.character, forKey: "character")
            managedObject.setValue(cast.order, forKey: "order")
            managedObject.setValue(movieId, forKey: "movieId")
            managedObject.setValue(cast.imagePath, forKey: "imagePath")
        }
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
}
