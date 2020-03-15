//
//  OrderTabController.swift
//  GrubHub
//
//  Created by Oliver Green on 07/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class OrderTabController: UIViewController {
    
    // MARK: - NOTE
    /*
     When creating the basket total UIView
     You must parse a default value since the basketTotal var is optional
     Therefore it will be something along the lines of:
        - basletTotal.text = String(format: %.2f, "£\(MainViewController.basketTotal ?? 0)")
     This is parsing the basketTotal value, however giving a default value of 0 if the variable returns null - thus the label should read £0.00 instead of nothing
     */
    
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
        label.text = "Your Order"
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
    
    let cellId = "basketCellId"
    
    let mainTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let quantity: Int = 0
    let price: Float = 0
    
    var arr: [String] = []
    
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        for (testKey) in MainViewController.basket {
            if (!arr.contains(testKey.key)) {
                arr.append(testKey.key)
            }
        }
        
        
        
        self.mainTable.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .defaultBackground
        
        setupNavigationBar()
        customiseNavigationBar()
        customiseTabBar()
        setupLayout()
    }
    
    func setupNavigationBar() {
        
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
    
    func customiseNavigationBar() {
        
        gradientLayer.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 1)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        customHeader.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func customiseTabBar() {

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
    
    func setupLayout() {
        
        mainTable.delegate = self
        mainTable.dataSource = self
        
        mainTable.register(BasketTableCell
            .self, forCellReuseIdentifier: cellId)
        
        view.insertSubview(mainTable, belowSubview: headerShadowView)
        NSLayoutConstraint.activate([
            mainTable.topAnchor.constraint(equalTo: customHeader.bottomAnchor, constant: 0), //130
            mainTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension OrderTabController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MainViewController.basket.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = BasketTableSectionHeaderView()
        headerView.titleHeaderTitle.text = "Order"
        //headerView.priceHeaderTitle.text = "£\(String(format: "%.2f", (price/100)))"
        //headerView.priceHeaderTitle.text = "£\(String(format: "%.2f", MainViewController.basketTotal/100))"
        headerView.priceHeaderTitle.text = "£\(String(format: "%.2f", Float(MainViewController.basketTotal/100)))"
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: BasketTableCell = tableView.dequeueReusableCell(withIdentifier: cellId) as! BasketTableCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        cell.itemName.text = arr[indexPath.row]
        
        cell.itemQuantity.text = "Qty: \(MainViewController.basket[cell.itemName.text!] as? String)"
        
        print(cell.itemName.text!)
        
        return cell
    }
}

class BasketTableSectionHeaderView: UIView {
    
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
    
    private let priceHeaderView: UIView = {
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
    
    let priceHeaderTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "CircularStd-Book", size: 20)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //backgroundColor = .red
        
        setupView()
    }
    
    private func setupView() {
        
        addSubview(titleViewContainer)
        titleViewContainer.addSubview(titleHeaderView)
        titleHeaderView.addSubview(titleHeaderTitle)
        titleViewContainer.addSubview(priceHeaderView)
        priceHeaderView.addSubview(priceHeaderTitle)
        
        NSLayoutConstraint.activate([
            titleViewContainer.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleViewContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleViewContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleViewContainer.topAnchor.constraint(equalTo: topAnchor),
            
            titleHeaderView.bottomAnchor.constraint(equalTo: titleViewContainer.bottomAnchor, constant: -20),
            titleHeaderView.rightAnchor.constraint(equalTo: titleHeaderTitle.rightAnchor, constant: 20),
            titleHeaderView.leftAnchor.constraint(equalTo: titleViewContainer.leftAnchor, constant: 10),
            titleHeaderView.heightAnchor.constraint(equalToConstant: 50),
            
            titleHeaderTitle.centerYAnchor.constraint(equalTo: titleHeaderView.centerYAnchor),
            titleHeaderTitle.leftAnchor.constraint(equalTo: titleHeaderView.leftAnchor, constant: 20),
            
            priceHeaderView.bottomAnchor.constraint(equalTo: titleViewContainer.bottomAnchor, constant: -20),
            priceHeaderView.rightAnchor.constraint(equalTo: titleViewContainer.rightAnchor, constant: -10),
            priceHeaderView.leftAnchor.constraint(equalTo: priceHeaderTitle.leftAnchor, constant: -20),
            priceHeaderView.heightAnchor.constraint(equalToConstant: 50),
            
            priceHeaderTitle.centerYAnchor.constraint(equalTo: priceHeaderView.centerYAnchor),
            priceHeaderTitle.rightAnchor.constraint(equalTo: priceHeaderView.rightAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
