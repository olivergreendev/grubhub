//
//  CategoryButton.swift
//  GrubHub
//
//  Created by Oliver Green on 08/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class CategoryButton: UIView {
        
    let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 14)
        label.textColor = .gray
        return label
    }()
    
    let image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
    
    func setupButton() {
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        self.layer.cornerRadius = 8
        
        self.widthAnchor.constraint(equalToConstant: 120).isActive = true
        self.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.03
        self.layer.shadowRadius = 5.0
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.addGestureRecognizer(tapGesture)
        
        self.addSubview(title)
        self.addSubview(image)
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 25),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -15),
            image.widthAnchor.constraint(equalToConstant: 35),
            image.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        
        //print(self.title.text!)
    }
}
