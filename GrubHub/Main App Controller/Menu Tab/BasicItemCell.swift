//
//  BasicItemCell.swift
//  GrubHub
//
//  Created by Oliver Green on 13/03/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class BasicItemCell : UITableViewCell {
    
    var cellDelegate: AddToOrderProtocol?
    
    //MARK: Temporary Data
    var data: CoffeeData? {
        didSet {
            guard let data = data else { return }
            if let name = data.itemName {
                itemName.text = name
            }
            if let price = data.itemPrice {
                itemPrice.text = "£\(String(format: "%.2f", price/100))"
                itemPriceInt = price
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
    
    let itemPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 15)
        label.textColor = .gray
        label.textAlignment = .right
        //label.backgroundColor = .blue
        return label
    }()
    
    var itemPriceInt: Float = 0
    
    let addToOrder: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.custom)
        let image = UIImage(named: "add-to-basket")
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let itemQuantity: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupItemCell()
    }
    
    func setupItemCell() {
        
        addSubview(cellView)
        cellView.addSubview(itemName)
        cellView.addSubview(itemPrice)
        cellView.addSubview(addToOrder)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            itemName.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 20),
            itemName.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            addToOrder.widthAnchor.constraint(equalTo: addToOrder.imageView!.widthAnchor),
            addToOrder.heightAnchor.constraint(equalTo: addToOrder.imageView!.heightAnchor),
            addToOrder.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20),
            addToOrder.centerYAnchor.constraint(equalTo: itemName.centerYAnchor),
            
            itemPrice.rightAnchor.constraint(equalTo: addToOrder.leftAnchor, constant: -20),
            itemPrice.centerYAnchor.constraint(equalTo: addToOrder.centerYAnchor),
        ])
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(clickButton))
        addToOrder.addGestureRecognizer(tap)
    }
    
    @objc func clickButton() {
        
        let old = MainViewController.basket[itemName.text!]
        
        MainViewController.basket[itemName.text ?? "nil"] = (old ?? 0) + 1
        
        print(MainViewController.basket)
        
        MainViewController.basketTotal += itemPriceInt
        
        print(MainViewController.basketTotal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
