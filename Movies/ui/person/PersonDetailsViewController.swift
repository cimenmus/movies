//
//  PersonDetailsViewController.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import UIKit
import Combine

class PersonDetailsViewController: BaseViewController {
    
    // dependencies are injected by Dependency Injetion
    var viewModel: PersonDetailsViewModel!
    
    var personId: Int!
    var cancellableSet: Set<AnyCancellable> = []
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.addSubview(profileImageView)
        scroll.addSubview(biographyLabel)
        return scroll
    }()
    
    private lazy var profileImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.sizeToFit()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    
    override func initViews() {
        super.initViews()
        view.addSubview(scrollView)
    }
    
    override func setConstraint() {
        if !didSetupConstraints {
            
            scrollView.snp.makeConstraints { (make) in
                make.left.right.equalToSuperview()
                make.top.equalTo(view.layoutMarginsGuide.snp.top).offset(0)
                make.bottom.equalTo(view.layoutMarginsGuide.snp.bottom).offset(0)
            }
            
            profileImageView.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.top.equalTo(15)
                make.width.height.equalTo(200)
            }
            
            biographyLabel.snp.makeConstraints { (make) in
                make.centerX.equalToSuperview()
                make.width.equalTo(SCREEN_WIDTH - 30)
                make.top.equalTo(profileImageView.snp.bottom).offset(10)
                make.bottom.equalTo(-5)
            }
            
            didSetupConstraints = true
        }
        
        super.setConstraint()
    }
    
    override func initObservers() {
        super.initObservers()
    }
    
    override func initLogic() {
        super.initLogic()
        self.getPersonDetails()
    }
    
    deinit {
        cancellableSet.forEach { cancelable in cancelable.cancel()}
    }
        
}

extension PersonDetailsViewController {
    
    func getPersonDetails() {
        self.viewModel.getPersonDetails(personId: personId)
            .observe(view: self,
                     onSuccess: { person in self.setFields(person: person)})
            .store(in: &cancellableSet)
    }
    
    private func setFields(person: PersonModel){
        title = person.name
        profileImageView.loadTmdbImageWithPlaceHolder(fileName: person.imagePath)
        biographyLabel.text = person.biography
    }
}

