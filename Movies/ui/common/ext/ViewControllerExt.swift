//
//  ViewControllerExt.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func pushViewController(navigationController: UINavigationController?,
                            viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pushViewController<T>(navigationController: UINavigationController?,
                               type: T.Type) {
        let vc = instantiateViewController(type: type) as! UIViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // creates ViewController instance
    func instantiateViewController<T>(type: T.Type) -> T {
        let vc = DependencyManager.shared.resolve(type: type)
        return vc
    }
}
