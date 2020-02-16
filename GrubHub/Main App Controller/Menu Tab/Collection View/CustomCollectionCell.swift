//
//  CustomCollectionCell.swift
//  GrubHub
//
//  Created by Oliver Green on 10/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class CustomCollectionCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var data: CellData? {
        didSet {
            guard let data = data else { return }
            if let type = data.type {
                switch type {
                case "category":
                    break
                case "table":
                    break
                default:
                    break
                }
            }
            if let title = data.title {
                titleHeaderTitle.text = title
            }
        }
    }
    
    private let titleViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        return view
    }()
    
    private let titleHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 25
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.03
        view.layer.shadowRadius = 5.0
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        return view
    }()
    
    private let titleHeaderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Bold", size: 20)
        label.textColor = .black
        //label.text = "Categories"
        return label
    }()
    
    private let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .blue
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)

        setupLayout()
    }
    
    func setupLayout() {
        
        //Empty View
        
        contentView.addSubview(titleViewContainer)
        titleViewContainer.addSubview(titleHeaderView)
        titleHeaderView.addSubview(titleHeaderTitle)
        NSLayoutConstraint.activate([
            titleViewContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleViewContainer.heightAnchor.constraint(equalToConstant: 70),
            titleViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            titleHeaderView.centerYAnchor.constraint(equalTo: titleViewContainer.centerYAnchor),
            //titleHeaderView.widthAnchor.constraint(equalToConstant: titleHeaderTitle.frame.width),
            titleHeaderView.rightAnchor.constraint(equalTo: titleHeaderTitle.rightAnchor, constant: 20),
            titleHeaderView.leftAnchor.constraint(equalTo: titleViewContainer.leftAnchor, constant: 10),
            titleHeaderView.heightAnchor.constraint(equalToConstant: 50),
            
            //titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            //titleHeaderTitle.centerXAnchor.constraint(equalTo: titleHeaderView.centerXAnchor)
            titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            titleHeaderTitle.leftAnchor.constraint(equalTo: titleHeaderView.leftAnchor, constant: 20)
        ])
        
        //Category Collection View
        
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        
        //categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCellId")
        categoryCollectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCellId")
        
        addSubview(categoryCollectionView)
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": categoryCollectionView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0]-50-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": categoryCollectionView]))
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: titleViewContainer.bottomAnchor),
            categoryCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            categoryCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            //categoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCellId", for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 115, height: 115) //frame.height
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CategoryCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
