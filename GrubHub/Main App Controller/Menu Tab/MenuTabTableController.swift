//
//  MenuTabController.swift
//  GrubHub
//
//  Created by Oliver Green on 12/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class MenuTabTableController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    private let mainTable: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.allowsSelection = true
        return tableView
    }()
    
    //MARK: Temporary Data
    fileprivate let tableHeaders = ["Categories", "Coffee", "Pastries", "Soft Drinks"]
    
    fileprivate let data = [
        ItemData(itemName: "Espresso", itemPrice: "£2.50", itemDescription: "Espressos are the purest coffee experience you can get, and while the're not for everyone, it can be a truly singular drinking experience.", itemStrength: "coffee-strength-4"),
        ItemData(itemName: "Mocha", itemPrice: "£2.50", itemDescription: "The perfect cure for a chocolate craving, this beverage is 60 ml of espresso, 50 ml of chocolate, and 30 ml of steamed milk.", itemStrength: "coffee-strength-3"),
        ItemData(itemName: "Cappuccino", itemPrice: "£3.00", itemDescription: "This beloved drink is two ounces of espresso topped with another two ounces of steamed milk and finished with two ounces of foamed milk.", itemStrength: "coffee-strength-1"),
        ItemData(itemName: "Latte", itemPrice: "£2.80", itemDescription: "This beverage is a blend of two ounces of espresso and ten ounces of steamed milk. It’s topped with the tiniest hint of foamed milk.", itemStrength: "coffee-strength-1"),
        ItemData(itemName: "Flat White", itemPrice: "£3.20", itemDescription: "With two ounces of espresso to four ounces of steamed milk, this drink may be a little more palatable if you’re not a fan of strong coffee flavor.", itemStrength: "coffee-strength-2"),
        
    ]
    
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
        
        setupTableLayout()
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
    
    private func setupTableLayout() {
        
        mainTable.delegate = self
        mainTable.dataSource = self
        
        mainTable.register(CustomCategoryCell.self, forCellReuseIdentifier: "categoryCellId")
        mainTable.register(CustomItemCell.self, forCellReuseIdentifier: "itemCellId")
        
        view.addSubview(mainTable)
        NSLayoutConstraint.activate([
            mainTable.topAnchor.constraint(equalTo: customHeader.bottomAnchor),
            mainTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //TableView Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section != 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellId") as! CustomItemCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.data = self.data[indexPath.row]
            return cell
        }
        
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCellId") as! CustomCategoryCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tableHeaders.count
    }
    
    /*
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return tableHeaders[section]
    }
     */
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = TableSectionHeaderView()
        headerView.titleHeaderTitle.text = tableHeaders[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return data.count
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 0 {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //Return a height of 115 for the Category section
        if indexPath.section == 0 {
            return 130
        }
        
        //Expand rows in other sections; returning 140
        if tableView.indexPathForSelectedRow?.row == indexPath.row && tableView.indexPathForSelectedRow?.section == indexPath.section {
            return 140
        }
        
        //Collapse these rows; returning 70 as a base value
        else {
            return 70
        }
    }
    
    //Override Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

class CustomItemCell : UITableViewCell {
    
    //MARK: Temporary Data
    var data: ItemData? {
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
                coffeeStrength.image = UIImage(imageLiteralResourceName: strength)
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
    
    let addToOrder: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "add-to-basket")
        return image
    }()
    
    let coffeeStrength: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.image = #imageLiteral(resourceName: "coffee-strength")
        return image
    }()
    
    let tempMask: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 6
        view.layer.masksToBounds = false
        return view
    }()
    
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
        //Temp Mask
        cellView.addSubview(tempMask)
        
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
            
            addToOrder.centerYAnchor.constraint(equalTo: itemName.centerYAnchor),
            addToOrder.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -20),
            
            itemPrice.rightAnchor.constraint(equalTo: addToOrder.leftAnchor, constant: -20),
            itemPrice.centerYAnchor.constraint(equalTo: addToOrder.centerYAnchor),
            
            coffeeStrength.topAnchor.constraint(equalTo: itemDescription.bottomAnchor, constant: 10),
            coffeeStrength.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            tempMask.heightAnchor.constraint(equalToConstant: 10),
            tempMask.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            tempMask.leftAnchor.constraint(equalTo: cellView.leftAnchor),
            tempMask.rightAnchor.constraint(equalTo: cellView.rightAnchor),
            tempMask.bottomAnchor.constraint(equalTo: cellView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomCategoryCell: UITableViewCell {
    
    private let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.contentSize = CGSize(width: 0, height: 0)
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCategoryCell()
    }
    
    func setupCategoryCell() {
        
        addSubview(cellView)
        cellView.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            
            cellView.topAnchor.constraint(equalTo: topAnchor),
            cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            cellView.centerXAnchor.constraint(equalTo: centerXAnchor),
            cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            scrollView.topAnchor.constraint(equalTo: cellView.topAnchor),
            scrollView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: cellView.widthAnchor),
            scrollView.bottomAnchor.constraint(equalTo: cellView.bottomAnchor),
            
            
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
            
            /*
            stackView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
             */
        ])
        
        /*
         if !categoryData.isEmpty {
             for n in 0...(categoryData.count - 1) {
                 createMultipleButtons(stackView: stackView, count: n)
             }
         }
         */
        
        for n in 0...5 {
            createMultipleButtons(stackView: stackView, count: n)
        }
    }
    
    private func createMultipleButtons(stackView: UIStackView, count: Int) -> UIView {
        
        let view = CategoryButton()
        //view.title.text = categoryData[count].title
        //view.image.image = UIImage(imageLiteralResourceName: categoryData[count].image!)
        stackView.addArrangedSubview(view)
        return view
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/*
private func createMultipleButtons(stackView: UIStackView, count: Int) -> UIView {
    
    let view = CategoryButton()
    view.title.text = categoryData[count].title
    view.image.image = UIImage(imageLiteralResourceName: categoryData[count].image!)
    stackView.addArrangedSubview(view)
    return view
}
 */

/*
cell.layer.cornerRadius = 10
let shadowPath2 = UIBezierPath(rect: cell.bounds)
cell.layer.masksToBounds = false
cell.layer.shadowColor = UIColor.black.cgColor
cell.layer.shadowOffset = CGSize(width: CGFloat(1.0), height: CGFloat(3.0))
cell.layer.shadowOpacity = 0.5
cell.layer.shadowPath = shadowPath2.cgPath
*/


/*
let tempBlock: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    view.layer.cornerRadius = 6
    return view
}()

let tempBlock2: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    view.layer.cornerRadius = 6
    return view
}()

let tempBlock3: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    view.layer.cornerRadius = 6
    return view
}()
*/

//MARK: TODO
//SET THIS AS A UI COLLECTION VIEW, NOT UI VIEWS
//!!! THE TABLE CELLS HEIGHT ARE BIGGER THAN THE CELLVIEWS HEIGHT, THATS WHY THE TEXT IS SHOWING UNDER EACH CELL - SET THE TABLE ROWS BACKGROUND TO RED TO SEE
/*
tempBlock.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
tempBlock.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
tempBlock.widthAnchor.constraint(equalToConstant: 100),
tempBlock.heightAnchor.constraint(equalToConstant: 100),

tempBlock2.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
tempBlock2.leftAnchor.constraint(equalTo: tempBlock.rightAnchor, constant: 20),
tempBlock2.widthAnchor.constraint(equalToConstant: 100),
tempBlock2.heightAnchor.constraint(equalToConstant: 100),

tempBlock3.centerYAnchor.constraint(equalTo: cellView.centerYAnchor),
tempBlock3.leftAnchor.constraint(equalTo: tempBlock2.rightAnchor, constant: 20),
tempBlock3.widthAnchor.constraint(equalToConstant: 100),
tempBlock3.heightAnchor.constraint(equalToConstant: 100)
*/


//

/*
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
*/
