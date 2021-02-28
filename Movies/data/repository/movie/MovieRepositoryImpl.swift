//
//  MovieRepositoryImpl.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import RxSwift

// decides which data source is used to fetch Search data
class MovieRepositoryImpl: BaseRepository, MovieRepository {
    
    // dependencies are injected by Dependency Injetion
    let networkUtils: NetworkUtils!
    let movieRemoteDataSource: MovieDataSource!
    let movieLocalDataSource: MovieDataSource!
    
    // will be called by Dependency Injection
    init(networkUtils: NetworkUtils,
         movieLocalDataSource: MovieDataSource,
         movieRemoteDataSource: MovieDataSource) {
        self.networkUtils = networkUtils
        self.movieRemoteDataSource = movieRemoteDataSource
        self.movieLocalDataSource = movieLocalDataSource
    }
    
    /**
     the "request" method is indside BaseRepository
     take 3 closure parameters to fetch data from network, insert data to database and fetch data from database
     first tries to fetch data from network
     if fetching network succeed, the fetched data will be inserted into database, then data is returned
     if network is not available, the data will be fetched from database and then returned
     */
    func getPopularMovies(page: Int) -> Single<[MovieModel]> {
        return resource(
            loadFromNetwork: { self.movieRemoteDataSource.getPopularMovies(page: page) },
            loadFromDb: { self.movieLocalDataSource.getPopularMovies(page: page) },
            saveToDb: { data in self.movieLocalDataSource.saveMovies(movies: data)}
        )
    }
    
    func saveMovies(movies: [MovieModel]) {
        movieLocalDataSource.saveMovies(movies: movies)
    }
    
    /**
     the "request" method is indside BaseRepository
     take 3 closure parameters to fetch data from network, insert data to database and fetch data from database
     first tries to fetch data from network
     if fetching network succeed, the fetched data will be inserted into database, then data is returned
     if network is not available, the data will be fetched from database and then returned
     */
    func getCastOfMovie(movieId: Int) -> Single<[MovieCastModel]> {
        return resource(
            loadFromNetwork: { self.movieRemoteDataSource.getCastOfMovie(movieId: movieId) },
            loadFromDb: { self.movieLocalDataSource.getCastOfMovie(movieId: movieId) },
            saveToDb: { data in self.movieLocalDataSource.saveMovieCast(movieId: movieId, movieCast: data)}
        )
    }
    
    func saveMovieCast(movieId: Int, movieCast: [MovieCastModel]) {
        movieLocalDataSource.saveMovieCast(movieId: movieId, movieCast: movieCast)
    }
    
}
