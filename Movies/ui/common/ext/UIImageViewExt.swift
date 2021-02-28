//
//  UIImageViewExt.swift
//  Movies
//
//  Created by mustafa içmen on 28.02.2021.
//

import Foundation
import SDWebImage

extension UIImageView {
    
    @discardableResult func loadTmdbImageWithPlaceHolder(fileName: String?) -> UIImageView {
        let imageUrl = Constants.TMDB_IMAGEURL_PREFIX + (fileName ?? "")
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        return self.loadWithMisingImage(imageUrl)
    }
    
    @discardableResult func loadWithMisingImage(_ url: String) -> UIImageView {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
        
        return self
    }
}
