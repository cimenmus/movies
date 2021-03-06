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
    var viewModel: MovieDetailsViewModel!
    
    var movie: MovieModel!
    
    private var castList = [MovieCastModel]()
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.addSubview(stackView)
        scroll.addSubview(movieBackdropImageView)
        scroll.addSubview(starImageView)
        scroll.addSubview(averageLabel)
        scroll.addSubview(releaseDateLabel)
        scroll.addSubview(overviewLabel)
        scroll.addSubview(castLabel)
        scroll.addSubview(castTableView)
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.distribution = .fill
        return s
    }()
    
    private lazy var movieBackdropImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var starImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "rating")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var averageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
        
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()

    private lazy var castTableView: ContentSizedTableView = {
        let table = ContentSizedTableView()
        table.delegate = self
        table.dataSource = self
        table.register(CastCell.classForCoder(), forCellReuseIdentifier: "CastCell")
        table.separatorStyle = .singleLine
        table.backgroundColor = .white
        table.isScrollEnabled = false
        return table
    }()
    
    override func initViews() {
        super.initViews()
        
        view.addSubview(scrollView)
        
        setNavigationTitle(title: movie.title ?? "")
        self.movieBackdropImageView.loadTmdbImageWithPlaceHolder(fileName: movie.backdropImagePath)
        averageLabel.text = String(movie.average ?? 0.0)
        releaseDateLabel.text = movie.releaseDate
        overviewLabel.text = movie.overview ?? "-"
    }
    
    override func setConstraint() {
        if !didSetupConstraints {
            
            scrollView.snp.makeConstraints { (make) in
                make.left.right.equalTo(0)
                make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(0)
                make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(0)
            }
            
            stackView.snp.makeConstraints { (make) in
                make.top.equalTo(overviewLabel.snp.bottom).offset(20)
                make.left.equalTo(10)
                make.width.equalTo(SCREEN_WIDTH - 30)
            }
            
            movieBackdropImageView.snp.makeConstraints { (make) in
                make.top.equalTo(0)
                make.left.equalTo(0)
                make.right.equalTo(0)
                make.width.equalTo(SCREEN_WIDTH)
                make.height.equalTo(SCREEN_WIDTH * CGFloat(Constants.TMDB_BACKDROP_IMAGE_RATIO))
            }
            
            starImageView.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(movieBackdropImageView.snp.bottom).offset(10)
                make.width.height.equalTo(13)
            }
            
            averageLabel.snp.makeConstraints { (make) in
                make.left.equalTo(starImageView.snp.right).offset(5)
                make.centerY.equalTo(starImageView)
                make.width.equalTo(60)
            }
            
            releaseDateLabel.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.top.equalTo(averageLabel.snp.bottom).offset(3)
            }
            
            overviewLabel.snp.makeConstraints { (make) in
                make.left.equalTo(releaseDateLabel)
                make.top.equalTo(releaseDateLabel.snp.bottom).offset(10)
                make.width.equalTo(SCREEN_WIDTH - 30)
            }
            
            castLabel.snp.makeConstraints { (make) in
                make.left.equalTo(releaseDateLabel)
                make.top.equalTo(overviewLabel.snp.bottom).offset(10)
                make.width.equalTo(SCREEN_WIDTH - 30)
            }
            
            castTableView.snp.makeConstraints { (make) in
                make.left.equalTo(10)
                make.width.equalTo(SCREEN_WIDTH - 30)
                make.top.equalTo(stackView.snp.bottom).offset(15)
                make.bottom.equalTo(-5)
            }
            
            didSetupConstraints = true
        }
        
        super.setConstraint()
    }
    
    override func initObservers() {
        super.initObservers()
        DataObserver.create(view: self,
                            publishSubject: self.viewModel.movieCastObservable,
                            onSuccess: {[weak self] cast in self?.bindCastTableView(cast: cast)})
    }
    
    override func initLogic() {
        super.initLogic()
        viewModel.getCastOfMovie(movieId: movie.id ?? 0)
    }
    
    private func bindCastTableView(cast: [MovieCastModel]) {
        self.castList.append(contentsOf: cast)
        castTableView.reloadData()
        castTableView.layoutIfNeeded()
        castTableView.heightAnchor.constraint(equalToConstant: self.castTableView.contentSize.height).isActive = true
        scrollView.layoutIfNeeded()
    }
    
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CastCell", for: indexPath) as! CastCell
        cell.configure(castModel: self.castList[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = instantiateViewController(type: PersonDetailsViewController.self)
        vc.personId = self.castList[indexPath.row].id
        pushViewController(navigationController: self.navigationController, viewController: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
