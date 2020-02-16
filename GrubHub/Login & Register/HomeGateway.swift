//
//  HomeGateway.swift
//  GrubHub
//
//  Created by Oliver Green on 27/01/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class HomeGateway: UIViewController {
    
    private var loginButton = UIButton()
    
    @objc private func handleLogin() {
        let loginViewController = Login()
        self.navigationController?.show(loginViewController, sender: self)
    }
    
    private var registerButton = UIButton()
    
    @objc private func handleRegister() {
        // segue into the next navigation screen, don't load a new navigation controller
        let signUpViewController = SignUp()
        self.navigationController?.show(signUpViewController, sender: self)
    }
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "homegateway_logo"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .defaultBackground
        
        setupImages()
        setupButtons()
        
        /*
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
         */
    }
    
    fileprivate func setupImages() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "homegateway_bg")
        backgroundImage.contentMode = UIView.ContentMode.center
        self.view.insertSubview(backgroundImage, at: 0)
        
        let logoImageContainerView = UIView()
                
        view.addSubview(logoImageContainerView)
        logoImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        logoImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        logoImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        logoImageContainerView.addSubview(logoImageView)
        
        logoImageView.centerXAnchor.constraint(equalTo: logoImageContainerView.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        
        logoImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    fileprivate func setupButtons() {
        
        loginButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 90, y: 450, width: 180, height: 60))
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 30
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginButton.showsTouchWhenHighlighted = true
        //loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        loginButton.titleLabel?.font = UIFont(name: "CircularStd-Bold", size: 18)
        //loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.isHidden = false
        view.addSubview(loginButton)
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: loginButton.frame.size.width, height: loginButton.frame.size.height)
        loginButton.layer.insertSublayer(gradient, at: 0)
        
        registerButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 90, y: 520, width: 180, height: 60))
        registerButton.backgroundColor = .white
        registerButton.setTitleColor(.darkBlue, for: .normal)
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 30
        registerButton.setTitle("Register", for: .normal)
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        //registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        registerButton.titleLabel?.font = UIFont(name: "CircularStd-Bold", size: 18)
        registerButton.showsTouchWhenHighlighted = true
        //registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.isHidden = false
        view.addSubview(registerButton)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
