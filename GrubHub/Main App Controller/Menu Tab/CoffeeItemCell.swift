//
//  CoffeeItemCell.swift
//  GrubHub
//
//  Created by Oliver Green on 26/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit
import CoreData

protocol AddToOrderProtocol {
    func onClickCell(index: Int)
}

class CoffeeItemCell: UITableViewCell {
    
    var cellDelegate: AddToOrderProtocol?
    var index: IndexPath?
    
    //MARK: Temporary Data
    var data: CoffeeData? {
        didSet {
            guard let data = data else { return }
            if let name = data.itemName {
                itemName.text = name
            }
            if let description = data.itemDescription {
                itemDescription.text = description
            }
            if let price = data.itemPrice {
                itemPrice.text = price
            }
            if let strength = data.itemStrength {
                if strength != "nil" {
                    coffeeStrength.image = UIImage(imageLiteralResourceName: strength)
                }
            }
        }
    }
    
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
        return label
    }()
    
    let itemDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 12)
        label.textColor = .lightGray
        label.numberOfLines = 0
        //label.backgroundColor = .red
        return label
    }()
    
    let itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 15)
        label.textColor = .gray
        label.textAlignment = .right
        //label.backgroundColor = .blue
        return label
    }()
    
    let addToOrder: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        let image = UIImage(named: "add-to-basket")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let coffeeStrength: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let cellMask: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = false
        return view
    }()
    
    //let menu = MenuTabTableController()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupItemCell()
    }
    
    func setupItemCell() {
        
        addSubview(cellView)
        cellView.addSubview(itemName)
        cellView.addSubview(itemDescription)
        cellView.addSubview(itemPrice)
        cellView.addSubview(addToOrder)
        cellView.addSubview(coffeeStrength)
        cellView.addSubview(cellMask)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            itemName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            itemName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            itemDescription.topAnchor.constraint(equalTo: itemName.bottomAnchor, constant: 10),
            itemDescription.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            itemDescription.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -100),
            
//            addToOrder.centerYAnchor.constraint(equalTo: itemName.centerYAnchor),
//            addToOrder.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20),
//            addToOrder.widthAnchor.constraint(equalToConstant: 50),
//            addToOrder.heightAnchor.constraint(equalToConstant: 50),
            addToOrder.widthAnchor.constraint(equalToConstant: 50),
            addToOrder.heightAnchor.constraint(equalToConstant: 50),
            addToOrder.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20),
            addToOrder.centerYAnchor.constraint(equalTo: itemName.centerYAnchor),
            
            itemPrice.rightAnchor.constraint(equalTo: addToOrder.leftAnchor, constant: -20),
            itemPrice.centerYAnchor.constraint(equalTo: addToOrder.centerYAnchor),
            
            coffeeStrength.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 10),
            coffeeStrength.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            cellMask.heightAnchor.constraint(equalToConstant: 10),
            cellMask.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            cellMask.leftAnchor.constraint(equalTo: cellView.leftAnchor),
            cellMask.rightAnchor.constraint(equalTo: cellView.rightAnchor),
            cellMask.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickButton))
        addToOrder.addGestureRecognizer(tap)
    }
    
    @objc func clickButton() {
        
        cellDelegate?.onClickCell(index: (index?.row)!)
        MenuTabTableController.basket[itemName.text!] = [10: 10]
        print(MenuTabTableController.basket)
        
        // MARK: - TO DO:
        // Check if the key that is about to be referenced already exists in the dictionary...if it does, then access the key, and give it a value of [Int: Int] which is [Qty: Price]
        // If the key exists, then the [Qty] just needs to be incremented by 1, and the [Price] needs to have the price of the item added to it
        // This means a new way of referencing the item's price is required
        // For this, make it so the item's price is initally declared as a whole number, e.g. 380 (pence), and when the item's price label is created, the text value assigned to it would be this Int, divided by 100, and cast as a String()
        // So when an item is created, its price is 380p, which when divided by 100, gives us 3.80, when the label's string is parsed, it will just be of the format "£\(itemPrice/100)"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
