//
//  ViewController.swift
//  WorkProject
//
//  Created by Dominik Kolber on 10/17/19.
//  Copyright © 2019 Szymon Kolber. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController, UpdateFilmsDelegate {
    
    let filmsViewModel = FilmsViewModel()
    var films: [Film] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let films = readUserDefaults() {
            insertFilms(films: films)
        } else {
            self.showSpinner(onView: self.tableView)
            self.filmsViewModel.fetchFilms(url: URL(string: Links.ytLink)!)
            self.films = filmsViewModel.films
        }
        
        tableView.dataSource = self
        tableView.register(FilmTableViewCell.self, forCellReuseIdentifier: FilmTableViewCell.reuseId)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Update", style: .plain, target: self, action: #selector(handleUpdate))
        
        
        filmsViewModel.delegate = self
        
        setUp()
    }
    
    @objc private func handleUpdate() {
        
        films = []
        self.showSpinner(onView: self.tableView)
        self.filmsViewModel.fetchFilms(url: URL(string: Links.ytLink)!)
        self.films = filmsViewModel.films
        
    }

    private func setUp() {
        
        view.backgroundColor = .white
        
        navigationItem.title = "Films"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
    }
    
    func updateFilms(films: [Film]) {
        self.films = films
        self.removeSpinner()
        self.saveUserDefaults()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func insertFilms(films: [Film]) {
        self.films = films
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
}

extension MainViewController{
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FilmTableViewCell.reuseId, for: indexPath) as! FilmTableViewCell
        let film = films[indexPath.row]
        cell.titleLabel.text = film.title
        cell.descriptionLabel.text = film.filmDescription
        cell.thumbnailImageView.image = film.thumbnail        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension MainViewController {
    
    func saveUserDefaults() {
        let userDefaults = UserDefaults.standard
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: films)
        userDefaults.set(encodedData, forKey: "films")
    }
    
    func readUserDefaults() -> [Film]? {
        
        let userDefaults = UserDefaults.standard
        if let decoded = userDefaults.data(forKey: "films") {
            let decodedFilms = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! [Film]
            if decodedFilms.count == 0 {
                return nil
            } else {
                return decodedFilms
            }
        } else {
            return nil
        }
        
    }
}
