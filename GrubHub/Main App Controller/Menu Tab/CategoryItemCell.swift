//
//  CategoryItemCell.swift
//  GrubHub
//
//  Created by Oliver Green on 13/03/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class CategoryItemCell: UITableViewCell {
    
    let cell = [
        CategoryItemData(title: "Coffee", image: "coffee-icon"),
        CategoryItemData(title: "Pastries", image: "pastries-icon"),
        CategoryItemData(title: "Soft Drinks", image: "soft-drinks-icon"),
        CategoryItemData(title: "Tea", image: "default-flag"),
        CategoryItemData(title: "Smoothies", image: "default-flag"),
        CategoryItemData(title: "Muffins", image: "default-flag")
    ]
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.contentSize = CGSize(width: 0, height: 0)
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    
    private var stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.distribution = .fill
        view.axis = .horizontal
        view.spacing = 10
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCategoryCell()
    }
    
    func setupCategoryCell() {
        
        addSubview(cellView)
        cellView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            scrollView.topAnchor.constraint(equalTo: cellView.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: cellView.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            
            /*
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
             */
        ])
        
        /*
         if !categoryData.isEmpty {
             for n in 0...(categoryData.count - 1) {
                 createMultipleButtons(stackView: stackView, count: n)
             }
         }
         */
        
        for n in 0...(cell.count - 1) {
            createMultipleButtons(stackView: stackView, count: n)
        }
    }
    
    private func createMultipleButtons(stackView: UIStackView, count: Int) -> UIView {
        
        let view = CategoryButton()
        view.cellTitle.text = cell[count].title
        view.cellImage.image = UIImage(imageLiteralResourceName: cell[count].image!)
        stackView.addArrangedSubview(view)
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
