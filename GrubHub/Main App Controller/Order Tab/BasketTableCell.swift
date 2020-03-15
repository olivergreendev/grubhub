//
//  BasketTableCell.swift
//  GrubHub
//
//  Created by Oliver Green on 01/03/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class BasketTableCell: UITableViewCell {
    
    //MARK: DATA
    var basketReference: [String: Int] = [:]
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setCellStyle()
        view.clipsToBounds = true
        return view
    }()
    
    let itemName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 15)
        label.textColor = .black
        //label.backgroundColor = .blue
        label.text = "Espresso"
        return label
    }()
    
    let itemQuantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 15)
        label.textColor = .gray
        label.textAlignment = .right
        //label.backgroundColor = .blue
        //label.text = "Qty: 20"
        return label
    }()
    
    let increaseQuantityButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        let image = UIImage(named: "add-to-basket")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let decreaseQuantityButton: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        let image = UIImage(named: "qty-decrease")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        /*
        basketReference = MainViewController.basket
        
        self.itemQuantity.text = "Qty: \(basketReference["Espresso"]!)"
        
        print(basketReference)
         */
        
        // We can't put this logic here because it gets called each time a cell is created
        // The data needs to be parsed when the cells are created in the cellForRowAt function
        // cell?.data = ...
        // This involves parsing the indexPath into the basket array to get the itemName and itemQuantity
        // Then we need to update the table each time the tabBar item is tapped
        
        setupItemCell()
    }
    
    func setupItemCell() {
        
        addSubview(cellView)
        cellView.addSubview(itemName)
        cellView.addSubview(itemQuantity)
        cellView.addSubview(increaseQuantityButton)
        cellView.addSubview(decreaseQuantityButton)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            itemName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            itemName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            increaseQuantityButton.widthAnchor.constraint(equalTo: increaseQuantityButton.imageView!.widthAnchor),
            increaseQuantityButton.heightAnchor.constraint(equalTo: increaseQuantityButton.imageView!.heightAnchor),
            increaseQuantityButton.rightAnchor.constraint(equalTo: decreaseQuantityButton.leftAnchor, constant: -10),
            increaseQuantityButton.centerYAnchor.constraint(equalTo: itemName.centerYAnchor),
            
            decreaseQuantityButton.widthAnchor.constraint(equalTo: decreaseQuantityButton.imageView!.widthAnchor),
            decreaseQuantityButton.heightAnchor.constraint(equalTo: decreaseQuantityButton.imageView!.heightAnchor),
            decreaseQuantityButton.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20),
            decreaseQuantityButton.centerYAnchor.constraint(equalTo: itemName.centerYAnchor),
            
            itemQuantity.rightAnchor.constraint(equalTo: increaseQuantityButton.leftAnchor, constant: -10),
            itemQuantity.centerYAnchor.constraint(equalTo: increaseQuantityButton.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
