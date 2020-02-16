//
//  CustomViewSection.swift
//  GrubHub
//
//  Created by Oliver Green on 10/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class CustomViewSection: UIView {
    
    private let sectionContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green
        return view
    }()
    
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
        label.text = "Categories"
        return label
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .darkGray
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentSize = CGSize(width: 0, height: 0)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setupSectionObject()
    }
    /*
    static func setupSectionObject() {
        
        // 1
        addSubview(sectionContainer)
        NSLayoutConstraint.activate([
            sectionContainer.topAnchor.constraint(equalTo: previousView.bottomAnchor, constant: 20),
            //sectionContainer.heightAnchor.constraint(equalToConstant: 200),
            sectionContainer.widthAnchor.constraint(equalToConstant: frame.width),
            sectionContainer.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
        
        // 2
        sectionContainer.addSubview(titleViewContainer)
        titleViewContainer.addSubview(titleHeaderView)
        titleHeaderView.addSubview(titleHeaderTitle)
        NSLayoutConstraint.activate([
            titleViewContainer.centerXAnchor.constraint(equalTo: sectionContainer.centerXAnchor),
            titleViewContainer.trailingAnchor.constraint(equalTo: sectionContainer.trailingAnchor),
            titleViewContainer.leadingAnchor.constraint(equalTo: sectionContainer.leadingAnchor),
            titleViewContainer.heightAnchor.constraint(equalToConstant: 70),
            titleViewContainer.topAnchor.constraint(equalTo: sectionContainer.topAnchor),
            
            titleHeaderView.centerYAnchor.constraint(equalTo: titleViewContainer.centerYAnchor),
            titleHeaderView.widthAnchor.constraint(equalToConstant: 145),
            titleHeaderView.leftAnchor.constraint(equalTo: titleViewContainer.leftAnchor, constant: 10),
            titleHeaderView.heightAnchor.constraint(equalToConstant: 50),
            
            titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            titleHeaderTitle.centerXAnchor.constraint(equalTo: titleHeaderView.centerXAnchor)
        ])
        
        // 3
        sectionContainer.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: titleViewContainer.bottomAnchor, constant: 0),
            scrollView.centerXAnchor.constraint(equalTo: sectionContainer.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: sectionContainer.widthAnchor),
            scrollView.heightAnchor.constraint(equalToConstant: 150),
            sectionContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10)
        ])
        
        // 4
        /*
        if !categoryData.isEmpty {
            for n in 0...(categoryData.count - 1) {
                createMultipleButtons(stackView: stackView, count: n)
            }
        }

        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -15)
        ])
        */
    }
     */
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: has not been implemented")
    }
}
