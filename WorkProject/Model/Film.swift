//
//  Film.swift
//  WorkProject
//
//  Created by Dominik Kolber on 10/17/19.
//  Copyright © 2019 Szymon Kolber. All rights reserved.
//

import UIKit

class Film: NSObject, NSCoding {
    
    let title: String
    let filmDescription: String
    let thumbnail: UIImage
    
    init(title: String, filmDescription: String, thumbnail: UIImage) {
        self.title = title
        self.filmDescription = filmDescription
        self.thumbnail = thumbnail
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let title = aDecoder.decodeObject(forKey: "title") as? String,
            let filmDescription = aDecoder.decodeObject(forKey: "filmDescription") as? String,
            let thumbnail = aDecoder.decodeObject(forKey: "thumbnail") as? UIImage
            else {
                return nil
        }
        self.init(title: title, filmDescription: filmDescription, thumbnail: thumbnail)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(filmDescription, forKey: "filmDescription")
        aCoder.encode(thumbnail, forKey: "thumbnail")
    }
    
    
}
