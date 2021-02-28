//
//  BaseViewController.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import UIKit
import SDWebImage
import SnapKit

class BaseViewController: UIViewController, UINavigationControllerDelegate {
    
    // will be injected on child view controller
    var dialogUtils: DialogUtils!
    var didSetupConstraints = false
    
    let SCREEN_WIDTH = UIScreen.main.bounds.width
    let SCREEN_HEIGHT = UIScreen.main.bounds.height
    
    override func viewDidLoad() {
        initViews()
        initObservers()
        initLogic()
        setConstraint()
    }
    
    func initViews() {
        view.backgroundColor = .white
        removeBackButtonItemTitle()
    }
        
    func initObservers(){}
    
    func initLogic(){}
    
    func setNavigationTitle(title: String) {
        navigationItem.title = title
    }
    
    func setConstraint() {
        super.updateViewConstraints()
    }
    
    private func removeBackButtonItemTitle(){
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }
    
}

extension BaseViewController: BaseView {
    
    func startLoader() {
        dialogUtils.startLoader(onView: self.view)
    }
    
    func stopLoader() {
        dialogUtils.stopLoader()
    }
    
    func onError(appError: AppError) {
        dialogUtils.showAlertDialog(message: appError.message, viewController: self)
    }
}
