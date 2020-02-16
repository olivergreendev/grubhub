//
//  TableSectionHeaderView.swift
//  GrubHub
//
//  Created by Oliver Green on 16/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class TableSectionHeaderView: UIView {
    
    private let titleViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
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
    
    let titleHeaderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Bold", size: 20)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    private func setupView() {
        
        addSubview(titleViewContainer)
        titleViewContainer.addSubview(titleHeaderView)
        titleHeaderView.addSubview(titleHeaderTitle)
        
        NSLayoutConstraint.activate([
            titleViewContainer.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleViewContainer.heightAnchor.constraint(equalToConstant: 70),
            titleViewContainer.topAnchor.constraint(equalTo: topAnchor),
            
            titleHeaderView.centerYAnchor.constraint(equalTo: titleViewContainer.centerYAnchor),
            titleHeaderView.rightAnchor.constraint(equalTo: titleHeaderTitle.rightAnchor, constant: 20),
            titleHeaderView.leftAnchor.constraint(equalTo: titleViewContainer.leftAnchor, constant: 10),
            titleHeaderView.heightAnchor.constraint(equalToConstant: 50),
            
            titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            titleHeaderTitle.leftAnchor.constraint(equalTo: titleHeaderView.leftAnchor, constant: 20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
