//
//  MenuItemCell.swift
//  GrubHub
//
//  Created by Oliver Green on 12/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class CustomMenuItemCell: UITableViewCell {
    
    var item: CoffeeData? {
        didSet {
            itemName.text = item?.itemName
            itemPrice.text = item?.itemPrice
            itemDescription.text = item?.itemDescription
        }
    }
    
    private let cellView: UIView = {
        let view = UIView()
        //view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gray
        //view.setCellShadow()
        return view
    }()
    
    private let itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Bold", size: 15)
        label.textColor = .black
        label.text = "Test"
        return label
    }()
    
    private let itemDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Bold", size: 15)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    func setupCell() {
        
        addSubview(cellView)
        cellView.addSubview(itemName)
        //addSubview(itemDescription)
        //addSubview(itemPrice)
        
//        NSLayoutConstraint.activate([
//            cellView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
//            cellView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
//            cellView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 10),
//            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
//        ])
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
            
            itemName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 10),
            itemName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
