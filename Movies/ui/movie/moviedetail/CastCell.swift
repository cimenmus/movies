//
//  CastCell.swift
//  Movies
//
//  Created by mustafa içmen on 6.03.2021.
//

import UIKit
import Foundation

class CastCell: UITableViewCell {
    
    var didSetupConstraints = false
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        return image
    }()
    
    private lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    private lazy var characterNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .gray
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        setupProperties()
        self.contentView.setNeedsUpdateConstraints()
    }
    
    override func updateConstraints() {
        if(!didSetupConstraints){
            
            profileImageView.snp.makeConstraints { (make) in
                make.left.equalTo(0)
                make.top.equalTo(8)
                make.bottom.equalTo(-8)
                make.width.height.equalTo(40)
            }
            
            artistLabel.snp.makeConstraints { (make) in
                make.left.equalTo(profileImageView.snp.right).offset(10)
                make.top.equalTo(profileImageView.snp.top)
                make.right.equalTo(-5)
            }
            
            characterNameLabel.snp.makeConstraints { (make) in
                make.left.equalTo(artistLabel)
                make.top.equalTo(artistLabel.snp.bottom).offset(1)
                make.right.equalTo(-5)
            }

            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    func configure(castModel: MovieCastModel) {
        profileImageView.loadTmdbImageWithPlaceHolder(fileName: castModel.imagePath)
        artistLabel.text = castModel.name
        if castModel.character != nil && !castModel.character!.isEmpty {
            characterNameLabel.isHidden = false
            characterNameLabel.text = "as \(castModel.character!)"
        } else {
            characterNameLabel.isHidden = true
        }
    }
    
    private func setupProperties() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(artistLabel)
        contentView.addSubview(characterNameLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
