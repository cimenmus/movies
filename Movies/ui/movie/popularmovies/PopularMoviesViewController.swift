//
//  PopularMoviesViewController.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import UIKit

class PopularMoviesViewController: BaseViewController {
    
    // dependencies are injected by Dependency Injetion
    var viewModel: PopularMoviesViewModel!
    
    override func initViews() {
        super.initViews()
    }
    
    override func initObservers() {
        super.initObservers()
    }
    
    override func initLogic() {
        super.initLogic()
        viewModel.getNextPopularMovies()
    }
    
}
