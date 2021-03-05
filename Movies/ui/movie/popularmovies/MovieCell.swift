//
//  MovieCell.swift
//  Movies
//
//  Created by mustafa içmen on 5.03.2021.
//

import UIKit
import Foundation

class MovieCell: UITableViewCell {
    
    lazy var movieImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.sizeToFit()
        label.numberOfLines = 2
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let image = UIImageView()
        image.isHidden = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "rating")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var averageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.sizeToFit()
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        configureCell()
    }
    
    func configureCell() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(starImageView)
        contentView.addSubview(averageLabel)
        contentView.addSubview(releaseDateLabel)
        
        NSLayoutConstraint.activate([
            
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            movieImageView.widthAnchor.constraint(equalToConstant: 90),
            movieImageView.heightAnchor.constraint(equalToConstant: 90),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            starImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            starImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            starImageView.widthAnchor.constraint(equalToConstant: 12),
            starImageView.heightAnchor.constraint(equalToConstant: 12),
            
            averageLabel.centerYAnchor.constraint(equalTo: starImageView.centerYAnchor),
            averageLabel.leadingAnchor.constraint(equalTo: starImageView.trailingAnchor, constant: 5),
            averageLabel.widthAnchor.constraint(equalToConstant: 60),
            
            releaseDateLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 0),
            releaseDateLabel.topAnchor.constraint(equalTo: starImageView.bottomAnchor, constant: 3),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func configureProperties(movie: MovieModel) {
        movieImageView.loadTmdbImageWithPlaceHolder(fileName: movie.posterImagePath)
        titleLabel.text = movie.title
        if movie.average != nil {
            starImageView.isHidden = false
            averageLabel.text = String(movie.average!)
        }
        
        releaseDateLabel.text = movie.releaseDate ?? ""
        
        var rect: CGRect = titleLabel.frame
        rect.size = (titleLabel.text?.size(withAttributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)]))!
        let titleLabelHeight = titleLabel.heightAnchor.constraint(equalToConstant: rect.height)
        titleLabel.addConstraint(titleLabelHeight)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
