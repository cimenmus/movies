//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import UIKit

class MovieDetailsViewController: BaseViewController {
    
    // dependencies are injected by Dependency Injetion
    var movie: MovieModel!
    var viewModel: MovieDetailsViewModel!
    
    override func initViews() {
        super.initViews()
    }
    
    override func initObservers() {
        super.initObservers()
    }
    
    override func initLogic() {
        super.initLogic()
        viewModel.getCastOfMovie(movieId: movie.id ?? 0)
    }
    
}
