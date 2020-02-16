//
//  MenuTabController.swift
//  GrubHub
//
//  Created by Oliver Green on 07/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class MenuTabController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //private let categoryData = CategoryEntryAPI.getCategoryData()
    //let categoryData = CategoryButton.getCategoryData()
    
    fileprivate let data = [
        CellData(title: "Categories", type: "category"),
        CellData(title: "Coffee", type: "table"),
        CellData(title: "Pastries", type: "table")
    ]
    
    let gradientLayer = CAGradientLayer()
    private let customHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .gradientPurple
        view.layer.cornerRadius = 40
        view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        return view
    }()
    
    private let headerTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: "CircularStd-Bold", size: 22)
        label.text = "Costa Coffee"
        return label
    }()
    
    private let headerShadowView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.purpleShadow.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 8)
        view.layer.shadowOpacity = 0.40
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let tabBarShadowView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.purpleShadow.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: -8)
        view.layer.shadowOpacity = 0.12
        view.layer.shadowRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewWillLayoutSubviews() {
        
        var tabBarFrame = self.tabBarController?.tabBar.frame
        tabBarFrame!.size.height = 80
        tabBarFrame!.origin.y = self.view.frame.size.height - 80
        self.tabBarController?.tabBar.frame = tabBarFrame!
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        gradientLayer.frame = customHeader.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .defaultBackground
        
        setupNavigationBar()
        customiseNavigationBar()
        customiseTabBar()
        
        setupCollectionView()
        
        //setupTitleSection()
        //setupCatergorySection()
        
        //setupSectionObject()
    }
    
    private func setupNavigationBar() {
        
        view.addSubview(customHeader)
        customHeader.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        customHeader.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        customHeader.heightAnchor.constraint(equalToConstant: 100).isActive = true
        customHeader.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        customHeader.addSubview(headerTitle)
        headerTitle.centerXAnchor.constraint(equalTo: customHeader.centerXAnchor).isActive = true
        headerTitle.centerYAnchor.constraint(equalTo: customHeader.centerYAnchor, constant: 5).isActive = true
        
        view.insertSubview(headerShadowView, belowSubview: customHeader)
        headerShadowView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerShadowView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        headerShadowView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        headerShadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func customiseNavigationBar() {
        
        gradientLayer.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        customHeader.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func customiseTabBar() {

        self.tabBarController?.tabBar.layer.cornerRadius = 40
        self.tabBarController?.tabBar.layer.masksToBounds = true
        self.tabBarController?.tabBar.barTintColor = .white
        self.tabBarController?.tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        view.addSubview(tabBarShadowView)
        tabBarShadowView.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        tabBarShadowView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        tabBarShadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tabBarShadowView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func setupCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        //layout.itemSize = CGSize(width: view.frame.width, height: 300)
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width, height: 1)
        //let width = UIScreen.main.bounds.size.width - 20
        //layout.estimatedItemSize = CGSize(width: width, height: 300)
        
        let parentCollectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        parentCollectionView.dataSource = self
        parentCollectionView.delegate = self
        parentCollectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        parentCollectionView.translatesAutoresizingMaskIntoConstraints = false
        parentCollectionView.backgroundColor = .clear
        //view.addSubview(collectionView)
        
        view.insertSubview(parentCollectionView, belowSubview: headerShadowView)
        NSLayoutConstraint.activate([
            parentCollectionView.topAnchor.constraint(equalTo: customHeader.bottomAnchor),
            parentCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            parentCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            //parentCollectionView.heightAnchor.constraint(equalToConstant: 300)
            parentCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // Collection View Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! ItemCollectionViewCell //as! CustomCollectionCell
        cell.backgroundColor = .clear
        cell.data = self.data[indexPath.row]
        //cell.cellType = .category
        return cell
    }
}






/*
 private func setupSectionObject() {
     
     // 1
     view.addSubview(sectionContainer)
     NSLayoutConstraint.activate([
         sectionContainer.topAnchor.constraint(equalTo: customHeader.bottomAnchor, constant: 20),
         //sectionContainer.heightAnchor.constraint(equalToConstant: 200),
         sectionContainer.widthAnchor.constraint(equalToConstant: view.frame.width),
         sectionContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
 }
 */

/*
private func createMultipleButtons(stackView: UIStackView, count: Int) -> UIView {
    
    let view = CategoryButton()
    view.title.text = categoryData[count].title
    view.image.image = UIImage(imageLiteralResourceName: categoryData[count].image!)
    stackView.addArrangedSubview(view)
    return view
}
 */
