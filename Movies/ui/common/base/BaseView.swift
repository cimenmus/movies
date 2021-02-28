//
//  BaseView.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation

protocol BaseView {
    
    func startLoader()
    
    func stopLoader()
    
    func onError(appError: AppError)
}
