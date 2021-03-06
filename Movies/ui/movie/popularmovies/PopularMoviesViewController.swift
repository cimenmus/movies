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
    
    private var movieList = [MovieModel]()
    private lazy var movieTableView: ContentSizedTableView = {
        let tableView = ContentSizedTableView()
        tableView.isHidden = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieCell.classForCoder(), forCellReuseIdentifier: "MovieCell")
        tableView.separatorStyle = .singleLine
        tableView.keyboardDismissMode = .onDrag
        view.addSubview(tableView)
        return tableView
    }()

    override func initViews() {
        super.initViews()
        title = "Popular Movies"
        NSLayoutConstraint.activate([
                movieTableView.widthAnchor.constraint(equalToConstant: SCREEN_WIDTH),
                movieTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                movieTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
    
    override func initLogic() {
        super.initLogic()
        viewModel.getNextPopularMovies(showLoading: true)
    }
    
    override func initObservers() {
        super.initObservers()
        /**
         an object to
            - observe  and showpopular movies data
            - observe operation state to show/hide loading indicator and alert dialog
         */
        DataObserver.create(view: self,
                            publishSubject: self.viewModel.popularMoviesObservable,
                            onSuccess: {[weak self] newMovies in
                                self?.movieList.append(contentsOf: newMovies)
                                self?.movieTableView.reloadData()
                            }
        )
    }
    
}

//MARK:-- Table view Delegate-Datasource together usage
extension PopularMoviesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        if indexPath.row == movieList.count - 4 {
            self.viewModel.getNextPopularMovies()
        }
        cell.configureProperties(movie: movieList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = instantiateViewController(type: MovieDetailsViewController.self)
        vc.movie = movieList[indexPath.row]
        pushViewController(navigationController: self.navigationController, viewController: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
