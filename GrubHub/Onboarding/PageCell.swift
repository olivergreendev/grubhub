//
//  PageCell.swift
//  GrubHub
//
//  Created by Oliver Green on 26/01/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else { return }
            locateImageView.image = UIImage(named: unwrappedPage.imageName)
            titleTextView.text = unwrappedPage.titleText
            descriptionTextView.text = unwrappedPage.descriptionText
        }
    }
    
    private let locateImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "onboard_1"))
        // enables autolayout for imageView
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Locate."
        //textView.font = UIFont.systemFont(ofSize: 31, weight: .bold)
        textView.font = UIFont(name: "CircularStd-Bold", size: 31)
        textView.textColor = UIColor(red: 117/255.0, green: 161/255.0, blue: 248/255.0, alpha: 1.0)
        textView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let lineView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "GrubHub will detect where you are to make your life easier."
        //textView.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textView.font = UIFont(name: "CircularStd-Book", size: 18)
        textView.textColor = UIColor(red: 36/255.0, green: 52/255.0, blue: 84/255.0, alpha: 1.0)
        textView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1.0)
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 50, bottom: 0, right: 50)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupLayout()
        drawLines()
    }
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()
        
        topImageContainerView.backgroundColor = .clear
        
        addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        topImageContainerView.addSubview(locateImageView)
        
        locateImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        locateImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150).isActive = true
        
        topImageContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
        addSubview(titleTextView)
        titleTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 0).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 300)
        
        addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        lineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
    }
    
    private func drawLines() {

        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 280, height: 250))

        let img = renderer.image { ctx in
            
            ctx.cgContext.move(to: CGPoint(x: 125, y: 110))
            ctx.cgContext.addLine(to: CGPoint(x: 155, y: 110))

            ctx.cgContext.setLineWidth(10)
            ctx.cgContext.setStrokeColor(UIColor.primaryBlue.cgColor)

            ctx.cgContext.strokePath()
        }

        lineView.image = img
        lineView.frame = CGRect(x: 0, y: 100, width: frame.width, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
