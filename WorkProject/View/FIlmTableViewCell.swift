//
//  FIlmTableViewCell.swift
//  WorkProject
//
//  Created by Dominik Kolber on 10/17/19.
//  Copyright © 2019 Szymon Kolber. All rights reserved.
//

import UIKit

class FilmTableViewCell: UITableViewCell {
    
    static let reuseId = "FilmTableViewCell"
    
    let titleLabel: UILabel = {
       
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .red
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
        
    }()
    
    let descriptionLabel: UILabel = {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = .black
        return label
        
    }()
    
    let textContainer: UIView = {
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let thumbnailContainer: UIView = {
       
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let thumbnailImageView: UIImageView = {
       
        let img = UIImage(named: "baner")!
        let imgView = UIImageView(image: img)
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    var film: Film?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
    private func setUp() {
        
        addSubview(thumbnailContainer)
        addSubview(textContainer)
        
        textContainer.addSubview(titleLabel)
        textContainer.addSubview(descriptionLabel)
        thumbnailContainer.addSubview(thumbnailImageView)
        
        textContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        textContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
        textContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        thumbnailContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        thumbnailContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2).isActive = true
        thumbnailContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        thumbnailContainer.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        titleLabel.widthAnchor.constraint(equalTo: textContainer.widthAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: textContainer.topAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: textContainer.trailingAnchor).isActive = true
        
        descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: textContainer.bottomAnchor, constant: 10).isActive = true
        
        thumbnailImageView.centerXAnchor.constraint(equalTo: thumbnailContainer.centerXAnchor).isActive = true
        thumbnailImageView.centerYAnchor.constraint(equalTo: thumbnailContainer.centerYAnchor).isActive = true
        thumbnailImageView.widthAnchor.constraint(lessThanOrEqualToConstant: 150).isActive = true
        
    }
    
    
}
