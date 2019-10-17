//
//  FilmsViewModel.swift
//  WorkProject
//
//  Created by Dominik Kolber on 10/17/19.
//  Copyright © 2019 Szymon Kolber. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FilmsViewModel {
    
    weak var delegate: UpdateFilmsDelegate?
    
    var films: [Film] = [] {
        didSet{
            delegate?.updateFilms(films: self.films)
        }
    }
    
    func fetchFilms(url: URL) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
                    //here dataResponse received from a network request
                    do {
                        let json = try JSON(data: dataResponse)
                        var filmsArray = [Film]()
                        if let items = json["items"].array {
                            for film in items {
                                
                                var tit = ""
                                var desc = ""
                                var img = UIImage()
                                
                                if let title = film["snippet"]["title"].string {
                                    tit = title
                                }
                                
                                if let description = film["snippet"]["description"].string {
                                    desc = description
                                }
                                
                                if let imageURL = film["snippet"]["thumbnails"]["medium"]["url"].string {
                                    let data = try! Data(contentsOf: URL(string: imageURL)!)
                                    let image = UIImage(data: data)!
                                    
                                    img = image
                                }
                                
                                let filmToAppend = Film(title: tit, filmDescription: desc, thumbnail: img)
                                filmsArray.append(filmToAppend)
                            }
                            filmsArray = filmsArray.sorted(by: {$0.description.count < $1.description.count})
                            self.films = filmsArray
                        }
                        
                    } catch {
                        print("Something went wrong")
                    }
            
        }
        task.resume()
        
    }
    
    
    
}
