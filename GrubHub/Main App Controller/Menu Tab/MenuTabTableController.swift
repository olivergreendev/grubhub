//
//  MenuTabController.swift
//  GrubHub
//
//  Created by Oliver Green on 12/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

extension MenuTabTableController: AddToOrderProtocol {
    
    func onClickCell(index: Int) {
        print("\(index) is clicked")
    }
}

class MenuTabTableController: UIViewController {
    
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
        label.text = "Coffee House"
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
    
    private let headerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Hide", for: .normal)
        button.backgroundColor = .red
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(hideSection), for: .touchUpInside)
        button.isHidden = true
        return button
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
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    //MARK: Temporary Data
    //fileprivate let tableHeaders = ["Categories", "Coffee", "Pastries", "Soft Drinks"]
    
    fileprivate let cellData = [
        ["Categories", "Coffee", "Pastries", "Soft Drinks", "Tea", "Smoothies", "Muffins"],
        [CoffeeData(itemName: "Espresso", itemPrice: 250, itemDescription: "Espressos are the purest coffee experience you can get, and while the're not for everyone, it can be a truly singular drinking experience.", itemStrength: "coffee-strength-4"),
        CoffeeData(itemName: "Mocha", itemPrice: 250, itemDescription: "The perfect cure for a chocolate craving, this beverage is 60 ml of espresso, 50 ml of chocolate, and 30 ml of steamed milk.", itemStrength: "coffee-strength-3"),
        CoffeeData(itemName: "Cappuccino", itemPrice: 300, itemDescription: "This beloved drink is two ounces of espresso topped with another two ounces of steamed milk and finished with two ounces of foamed milk.", itemStrength: "coffee-strength-1"),
        CoffeeData(itemName: "Latte", itemPrice: 280, itemDescription: "This beverage is a blend of two ounces of espresso and ten ounces of steamed milk. It’s topped with the tiniest hint of foamed milk.", itemStrength: "coffee-strength-1"),
        CoffeeData(itemName: "Flat White", itemPrice: 320, itemDescription: "With two ounces of espresso to four ounces of steamed milk, this drink may be a little more palatable if you’re not a fan of strong coffee flavor.", itemStrength: "coffee-strength-2")],
        [CoffeeData(itemName: "Danish Pastry", itemPrice: 180, itemDescription: "Part-baked and fully-baked danish pastries with a delicious & traditional filling.", itemStrength: "coffee-strength-1"), CoffeeData(itemName: "Butter Croissant", itemPrice: 100, itemDescription: "Available both fully-baked or part-baked – made with a high quantity of butter to deliver a really rich buttery taste.", itemStrength: "coffee-strength-1"), CoffeeData(itemName: "Mini Selections", itemPrice: 300, itemDescription: "Mini viennois & mini danish selections available as fully-baked or part-baked, delicious treats with morning coffee.", itemStrength: "coffee-strength-1"), CoffeeData(itemName: "Continental Confectionery", itemPrice: 320, itemDescription: "With consumers looking for new tastes and experiences this range of popular European confectionery will delight your customers!", itemStrength: "coffee-strength-1")],
        [CoffeeData(itemName: "Coca Cola", itemPrice: 180, itemDescription: "250ml traditional Coca Cola served in a glass bottle.", itemStrength: "coffee-strength-1"), CoffeeData(itemName: "Fanta: Orange", itemPrice: 140, itemDescription: "250ml Fanta Orange served in a glass bottle.", itemStrength: "coffee-strength-1"), CoffeeData(itemName: "Pepsi", itemPrice: 210, itemDescription: "250ml traditional Pepsi flavour served in a glass bottle", itemStrength: "coffee-strength-1")],
        [CoffeeData(itemName: "Green Tea", itemPrice: 120, itemDescription: "", itemStrength: ""), CoffeeData(itemName: "Brown Tea", itemPrice: 120, itemDescription: "", itemStrength: "")], //Tea
        [CoffeeData(itemName: "Strawberry Supreme", itemPrice: 210, itemDescription: "A delicious combination of milk, whipped cream and fresh strawberries.", itemStrength: ""), CoffeeData(itemName: "Raspbery Twist", itemPrice: 240, itemDescription: "A delicious combination of milk, whipped cream and fresh raspberries.", itemStrength: ""), CoffeeData(itemName: "Lemon Buzz", itemPrice: 250, itemDescription: "A tongue sizzling combination of milk, whipped cream, and freshly squeezed lemon juice and syrup.", itemStrength: "")], //Smoothies
        [CoffeeData(itemName: "Blueberry Muffin", itemPrice: 120, itemDescription: "", itemStrength: ""), CoffeeData(itemName: "Chocolate Muffin", itemPrice: 140, itemDescription: "", itemStrength: "")] //Muffins
    ]
    
    var hideSections = false
    
    var sections = [String]()
    var rows = [String]()
    
    var emptyDict: [String: String] = [:]
    
    // ["Espresso": [2: 20]]
    // 2 Espressos, at price '10' each
    
    /*
     data = [
        ["Categories", "Coffee", "Pastries", "Soft Drinks"], //Section 0 - Category
        [ItemData(Espresso), ItemData(Mocha), ItemData(Cappuccino)], //Section 1 - Coffee
        [ItemData(), ItemData(), ItemData()], //Section 2 - Pastries
        [ItemData(), ItemData(), ItemData()], //Section 3 - Soft Drinks
     ]
     */
    
    //MARK: TODO
    /*
     - Transform the above data array into a 2D array:-
     - [1][0] would be section 1 (Coffee), item 0 (Espresso)
     - [1][2] would be section 1 (Coffee), item 2 (Cappuccino)
     */
    
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
        setupTableLayout()
        customiseNavigationBar()
        customiseTabBar()
    }
    
    @objc func hideSection() {
        hideSections = !hideSections
        mainTable.reloadData()
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
        
        customHeader.addSubview(headerButton)
        headerButton.centerYAnchor.constraint(equalTo: customHeader.centerYAnchor).isActive = true
        headerButton.rightAnchor.constraint(equalTo: customHeader.rightAnchor, constant: -40).isActive = true
        headerButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
        headerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
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
        
        mainTable.register(CategoryItemCell.self, forCellReuseIdentifier: "categoryCellId")
        mainTable.register(CoffeeItemCell.self, forCellReuseIdentifier: "itemCellId")
        mainTable.register(BasicItemCell.self, forCellReuseIdentifier: "basicCellId")
        mainTable.register(AdvancedItemCell.self, forCellReuseIdentifier: "advancedCellId")
        
        //view.addSubview(mainTable)
        view.insertSubview(mainTable, belowSubview: headerShadowView)
        NSLayoutConstraint.activate([
            mainTable.topAnchor.constraint(equalTo: customHeader.bottomAnchor),
            mainTable.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainTable.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainTable.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    //Override Status Bar Style
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension MenuTabTableController: UITableViewDataSource, UITableViewDelegate {

    //TableView Delegates
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell: CategoryItemCell? = tableView.dequeueReusableCell(withIdentifier: "categoryCellId") as? CategoryItemCell
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            return cell!
        }
        
        if indexPath.section == 1 {
            let cell: CoffeeItemCell? = tableView.dequeueReusableCell(withIdentifier: "itemCellId") as? CoffeeItemCell
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            cell?.data = self.cellData[indexPath.section][indexPath.row] as! CoffeeData
            cell?.cellDelegate = self
            cell?.index = indexPath
            return cell!
        }
            
        else if indexPath.section == 5 || indexPath.section == 2 {
            let cell: AdvancedItemCell? = tableView.dequeueReusableCell(withIdentifier: "advancedCellId") as? AdvancedItemCell
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            cell?.data = self.cellData[indexPath.section][indexPath.row] as! CoffeeData
            cell?.cellDelegate = self
            return cell!
        }
        
        else {
            let cell: BasicItemCell? = tableView.dequeueReusableCell(withIdentifier: "basicCellId") as? BasicItemCell
            cell?.backgroundColor = .clear
            cell?.selectionStyle = .none
            cell?.contentView.isUserInteractionEnabled = false
            cell?.data = self.cellData[indexPath.section][indexPath.row] as! CoffeeData
            cell?.cellDelegate = self
            return cell!
        }
    }
    
    //MARK: Cell Planning
    //Section 0 = Categories (scroll view)
    //Section 1 = Coffees (name, price, desc, strength image)
    //Section 2 = Pastries (name, price, desc)
    //Section 3 = Soft Drinks (name, price)
    //Section 4 = Teas (name, price)
    //Section 5 = Smoothies (name, description, price)
    //Section 6 = Muffins (name, price)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return tableHeaders.count
       
        return self.cellData[0].count
        
        //return sections.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = TableSectionHeaderView()
        headerView.titleHeaderTitle.text = self.cellData[0][section] as! String
        //headerView.titleHeaderTitle.text = sections[section]
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 100
        }
        else {
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        ref.child("categories").child(sections[section]).observe(.value) { (snapshot) in
//            for child in snapshot.children.allObjects as! [DataSnapshot] {
//                print("Keys: \(child.key)")
//            }
//        }
        
        //return self.rows.count
        
        if section == 0 {
            // If the section is the 'Category' section, then return one row
            return 1
        } else {
            // Otherwise return the number of arrays found under each section
            // e.g. indexPath.section.child-count
            return self.cellData[section].count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section != 0 && indexPath.section != 3 && indexPath.section != 4 && indexPath.section != 6 {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        
        else if indexPath.section == 0 {
            //hide the other sections
            mainTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        //Return a height of 130 for the Category section
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
}





























/*
 private func initFirebase() {
 
     //Reference the Firebase Database
     ref = Database.database().reference()
     
     //Get the sections from the database
     ref.child("categories").observe(.value) { (snapshot) in
         let info = snapshot.value as! NSDictionary
         //self.sections = info.allKeys as! [String]
         
         //self.emptyDict = info as! Dictionary<String, String>
         
         for child in snapshot.children.allObjects as! [DataSnapshot] {
             //print("Child Keys: \(child.key)")
             //print("\(child.childSnapshot(forPath: ""))")
             self.sections.append(child.key)
             for nestedChild in child.children.allObjects as! [DataSnapshot] {
                 //print("Nested Child Keys: \(nestedChild.key)")
                 self.rows.append(nestedChild.key)
             }
         }
         
         self.mainTable.reloadData()
         //print(self.sections)
         //print(self.rows)
     }
     
     //Get the rows from the database
     ref.child("categories").child("Smoothies").observe(.value) { (snapshot) in
         let info = snapshot.value as! NSDictionary
         self.rows = info.allKeys as! [String]
         self.mainTable.reloadData()
         //print(self.rows)
     }
     
     /*
     // Write Data
     //ref.child("categories/coffee/Oliver").setValue("Green")
     
     // Read Data
     self.ref.child("categories/coffee/cappuccino/description").observeSingleEvent(of: .value) { (snapshot) in
         let description = snapshot.value as? String
         //print(description)
     }
     
     self.ref.child("categories/coffee/cappuccino").observeSingleEvent(of: .value) { (snapshot) in
         let data = snapshot.value as? [String:Any]
         //print(data)
     }
     
     // Observe Data Changes
     self.databaseHandle = self.ref.child("categories/coffee").observe(.childAdded) { (snapshot) in
         let addition = snapshot.value
         //print(addition)
     }
     
     self.databaseHandle = self.ref.child("categories/coffee").observe(.childChanged) { (snapshot) in
         let change = snapshot.value
         //print(change)
     }
      */
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
