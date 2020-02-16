//
//  CustomTableViewCell.swift
//  GrubHub
//
//  Created by Oliver Green on 04/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    var entry: CellEntry? {
        didSet {
            guard let entryItem = entry else { return }
            if let title = entryItem.title {
                cellImageView.image = #imageLiteral(resourceName: "company-icon-default")
                cellTitle.text = title
            }
            if let distance = entryItem.distance {
                cellDistance.text = "\(distance)"
            }
            if let status = entryItem.status {
                //cellFavouriteStatus.image = #imageLiteral(resourceName: "star-true")
                cellFavouriteStatus.image = UIImage(imageLiteralResourceName: status)
            }
        }
    }
    
    let cellImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 28
        image.clipsToBounds = true
        return image
    }()
    
    let cellContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let cellTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont(name: "CircularStd-Book", size: 18)
        title.textColor = .black
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let cellDistance: UILabel = {
        let distance = UILabel()
        distance.font = UIFont(name: "CircularStd-Book", size: 14)
        distance.textColor = .lightGray
        distance.translatesAutoresizingMaskIntoConstraints = false
        distance.clipsToBounds = true
        return distance
    }()
    
    let cellFavouriteStatus: UIImageView = {
        let image = UIImageView()
        //image.contentMode = .scaleToFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .center
        return image
    }()
    
    //var statusImageSize: Int = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(cellImageView)
        cellContainerView.addSubview(cellTitle)
        cellContainerView.addSubview(cellDistance)
        self.contentView.addSubview(cellContainerView)
        self.contentView.addSubview(cellFavouriteStatus)
        
        cellImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        cellImageView.widthAnchor.constraint(equalToConstant: 54).isActive = true
        cellImageView.heightAnchor.constraint(equalToConstant: 54).isActive = true
        
        cellContainerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cellContainerView.leadingAnchor.constraint(equalTo: self.cellImageView.trailingAnchor, constant: 20).isActive = true
        cellContainerView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -10).isActive = true
        cellContainerView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        cellTitle.topAnchor.constraint(equalTo: self.cellContainerView.topAnchor).isActive = true
        cellTitle.leadingAnchor.constraint(equalTo: self.cellContainerView.leadingAnchor).isActive = true
        cellTitle.trailingAnchor.constraint(equalTo: self.cellContainerView.trailingAnchor).isActive = true
        
        cellDistance.topAnchor.constraint(equalTo: self.cellTitle.bottomAnchor).isActive = true
        cellDistance.leadingAnchor.constraint(equalTo: self.cellContainerView.leadingAnchor).isActive = true
        cellDistance.topAnchor.constraint(equalTo: self.cellTitle.bottomAnchor).isActive = true
        
        // IMPORTANT:- empty star image should be the default size of 22x20
        // IMPORTANT:- the full star needs to be of size 44x40
        /*switch(cellFavouriteStatus.image) {
        case (#imageLiteral(resourceName: "star-false")):
            cellFavouriteStatus.widthAnchor.constraint(equalToConstant: 30).isActive = true
            cellFavouriteStatus.heightAnchor.constraint(equalToConstant: 30).isActive = true
        case #imageLiteral(resourceName: "star-true"):
            cellFavouriteStatus.widthAnchor.constraint(equalToConstant: 55).isActive = true
            cellFavouriteStatus.heightAnchor.constraint(equalToConstant: 55).isActive = true
        default:
            break
        }*/
        cellFavouriteStatus.widthAnchor.constraint(equalToConstant: 40).isActive = true
        cellFavouriteStatus.heightAnchor.constraint(equalToConstant: 40).isActive = true
        cellFavouriteStatus.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellFavouriteStatus.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
