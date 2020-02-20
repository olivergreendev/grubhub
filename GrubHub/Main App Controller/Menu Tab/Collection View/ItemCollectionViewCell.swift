//
//  ItemCollectionViewCell.swift
//  GrubHub
//
//  Created by Oliver Green on 11/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleHeaderView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
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
    
    private let itemCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        //layout.itemSize = CGSize(width: 100, height: 60)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        //collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let contentHeight = CGFloat(300)
    var isHeightCalculated: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    //MARK: TODO
    /*
     1. itemCollectionView's Flow Layout - set estimatedItemSize property
     2. override preferredLayoutAttributesFittingAttributes to return an appropiate size
     */
    
    func setupLayout() {
        
        //Empty View
        
        contentView.addSubview(titleViewContainer)
        titleViewContainer.addSubview(titleHeaderView)
        titleHeaderView.addSubview(titleHeaderTitle)
        NSLayoutConstraint.activate([
            titleViewContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleViewContainer.heightAnchor.constraint(equalToConstant: 80),
            titleViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            titleHeaderView.centerYAnchor.constraint(equalTo: titleViewContainer.centerYAnchor),
            //titleHeaderView.widthAnchor.constraint(equalToConstant: titleHeaderTitle.frame.width),
            titleHeaderView.rightAnchor.constraint(equalTo: titleHeaderTitle.rightAnchor, constant: 20),
            titleHeaderView.leftAnchor.constraint(equalTo: titleViewContainer.leftAnchor, constant: 10),
            titleHeaderView.heightAnchor.constraint(equalToConstant: 60),
            
            //titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            //titleHeaderTitle.centerXAnchor.constraint(equalTo: titleHeaderView.centerXAnchor)
            titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            titleHeaderTitle.leftAnchor.constraint(equalTo: titleHeaderView.leftAnchor, constant: 20)
        ])
        
        //Category Collection View
        
        itemCollectionView.dataSource = self
        itemCollectionView.delegate = self
        
        itemCollectionView.register(CategoryItemCell.self, forCellWithReuseIdentifier: "categoryItemCellId")
        
        addSubview(itemCollectionView)
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": categoryCollectionView]))
        //addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[v0]-50-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": categoryCollectionView]))
        NSLayoutConstraint.activate([
            itemCollectionView.topAnchor.constraint(equalTo: titleViewContainer.bottomAnchor),
            itemCollectionView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            itemCollectionView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            itemCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            //itemCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        itemCollectionView.backgroundColor = .red
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryItemCellId", for: indexPath)
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: (contentView.frame.width - 20), height: 60)
        }
        
        return CGSize(width: (contentView.frame.width - 20), height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.height = CGFloat(ceilf(Float(contentHeight)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        
        return layoutAttributes
    }
    
    //Fatal Error
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class TestTest: UICollectionViewCell, UICollectionViewDelegateFlowLayout {
    
    let testImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "germany")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let testLabel: UILabel = {
        let label = UILabel()
        label.text = "this is a really long label for testing"
        label.font = UIFont(name: "CircularStd-Book", size: 12)
        return label
    }()
    
    //var isHeightCalculated = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        
        //backgroundColor = .lightGray
    }
    
    func setupViews() {
        
        //Drop Shadow & Corner Radius
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        layer.backgroundColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 8
        
//        addSubview(testImage)
//        testImage.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
//        addSubview(testLabel)
//        testLabel.frame = CGRect(x: 0, y: 0, width: frame.width, height: 20)
//        testLabel.backgroundColor = .blue
    }
    
    /*
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        if !isHeightCalculated {
            setNeedsLayout()
            layoutIfNeeded()
            let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
            var newFrame = layoutAttributes.frame
            newFrame.size.width = CGFloat(ceil(Float(size.width)))
            layoutAttributes.frame = newFrame
            isHeightCalculated = true
        }
        
        return layoutAttributes
    }
     */
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 0 {
            return CGSize(width: (contentView.frame.width - 20), height: 60)
        }
        
        return CGSize(width: (contentView.frame.width - 20), height: 60)
    }
    
    
    
    //FatalError
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
