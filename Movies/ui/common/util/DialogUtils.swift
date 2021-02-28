//
//  DialogUtils.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import UIKit

class DialogUtils {
    
    private var loaderView: UIView?
    
    private let activityIndicator = UIActivityIndicatorView()
    
    func startLoader(onView : UIView) {
        if loaderView != nil && loaderView!.isHidden == false {
            return
        }
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.white
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .whiteLarge
        }
        activityIndicator.color = .gray
        activityIndicator.startAnimating()
        activityIndicator.center = spinnerView.center
        DispatchQueue.main.async {
            spinnerView.addSubview(self.activityIndicator)
            onView.addSubview(spinnerView)
        }
        loaderView = spinnerView
    }
    
    func stopLoader() {
        DispatchQueue.main.async {
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
        }
    }
    
    func showAlertDialog(message: String?, viewController: UIViewController) {
        let alertMessage: String
        if message == nil || message!.isEmpty {
            alertMessage = "Generic Error"
        } else {
            alertMessage = message!
        }
        
        let alertController = UIAlertController(title: "Warning", message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
