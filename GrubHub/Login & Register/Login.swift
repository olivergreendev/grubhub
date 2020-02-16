//
//  Login.swift
//  GrubHub
//
//  Created by Oliver Green on 02/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class Login: UIViewController, UITextFieldDelegate {
    
    deinit {
        print("Login view successfully denitialised")
    }
    
    private let titleText: UITextView = {
        let textView = UITextView()
        textView.text = "Login"
        textView.font = UIFont(name: "CircularStd-Bold", size: 24)
        textView.textColor = .primaryBlue
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let descriptionText: UITextView = {
        let textView = UITextView()
        textView.text = "Please login using your registered phone number."
        textView.font = UIFont(name: "CircularStd-Book", size: 16)
        textView.textColor = .darkBlue
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .left
        textView.textContainerInset = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 40)
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let areaCodeTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 40, y: 260, width: 115, height: 54))
        textField.backgroundColor = .textFieldLightGray
        textField.textColor = .darkBlue
        textField.font = UIFont(name: "CircularStd-Book", size: 15)
        textField.layer.cornerRadius = 3
        textField.keyboardType = .phonePad
        textField.text = "+"
        textField.addTarget(self, action: #selector(areaCodeTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        
        textField.setLeftIcon(#imageLiteral(resourceName: "default-flag"))
        return textField
    }()
    
    private func changeFlag(country: String) -> UIImageView {
        let flagImageView: UIImageView = {
            let imageView = UIImageView()
            let image = UIImage(named: country)
            imageView.image = image
            imageView.frame = CGRect(x: 0, y: 0, width: imageView.image!.size.width, height: imageView.image!.size.height)
            return imageView
        }()
        
        return flagImageView
    }
    
    @objc func areaCodeTextFieldDidChange(_ textField: UITextField) {
        
        if textField.text == "+44" {
            //areaCodeTextField.leftView = changeFlag(country: "great-britain")
            areaCodeTextField.setLeftIcon(#imageLiteral(resourceName: "great-britain"))
        } else if textField.text == "+49" {
            //areaCodeTextField.leftView = changeFlag(country: "germany")
            areaCodeTextField.setLeftIcon(#imageLiteral(resourceName: "germany"))
        } else if textField.text == "+1" {
            //areaCodeTextField.leftView = changeFlag(country: "usa")
            areaCodeTextField.setLeftIcon(#imageLiteral(resourceName: "usa"))
        } else if textField.text == "+82" {
            //areaCodeTextField.leftView = changeFlag(country: "south-korea")
            areaCodeTextField.setLeftIcon(#imageLiteral(resourceName: "south-korea"))
        } else {
            //areaCodeTextField.leftView = changeFlag(country: "default-flag")
            areaCodeTextField.setLeftIcon(#imageLiteral(resourceName: "default-flag"))
        }
        
        if (textField.text?.isEmpty == true) {
            textField.text = "+"
        }
        
        if !areaCodeTextField.text!.isEmpty && !phoneNumberTextField.text!.isEmpty {
            proceedButton.isHidden = false
        } else {
            proceedButton.isHidden = true
        }
    }
    
    private let phoneNumberTextField: UITextField = {
        
        let textField = UITextField(frame: CGRect(x: 160, y: 260, width: 210, height: 54))
        textField.backgroundColor = .textFieldLightGray
        textField.textColor = .darkBlue
        textField.font = UIFont(name: "CircularStd-Book", size: 15)
        textField.layer.cornerRadius = 3
        textField.keyboardType = .phonePad
        textField.addTarget(self, action: #selector(phoneNumberTextFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        textField.setLeftPaddingPoints(20)
        return textField
    }()
    
    @objc func phoneNumberTextFieldDidChange(_ textField: UITextField) {
        // check to make sure the length of the string is correct
        // check to make sure the format of the string is correct
        if !areaCodeTextField.text!.isEmpty && !phoneNumberTextField.text!.isEmpty {
            proceedButton.isHidden = false
        } else {
           proceedButton.isHidden = true
       }
    }
    
    var proceedButton = UIButton()
    
    @objc private func handleProceed() {
        
        if !areaCodeTextField.text!.isEmpty && !phoneNumberTextField.text!.isEmpty {
            let mapsView = MapViewController()
            mapsView.modalPresentationStyle = .fullScreen
            self.present(mapsView, animated: true, completion: nil)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(areaCodeTextField)
        view.addSubview(phoneNumberTextField)
                
        setupBackground()
        setupLayout()
    }
    
    private func setupBackground() {
        view.backgroundColor = .defaultBackground
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "homegateway_bg")
        backgroundImage.contentMode = UIView.ContentMode.center
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    private func setupLayout() {
                
        let textViewContainer = UIView()
        
        view.addSubview(textViewContainer)
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        textViewContainer.addSubview(titleText)
        textViewContainer.addSubview(descriptionText)
        
        textViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        textViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textViewContainer.bottomAnchor.constraint(equalTo: descriptionText.bottomAnchor).isActive = true

        titleText.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 80).isActive = true
        titleText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20).isActive = true
        descriptionText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        proceedButton = UIButton(frame: CGRect(x: (view.frame.width) - 100, y: 330, width: 60, height: 60))
        proceedButton.backgroundColor = .green
        proceedButton.clipsToBounds = true
        proceedButton.layer.cornerRadius = 30
        proceedButton.setTitle("Go", for: .normal)
        proceedButton.addTarget(self, action: #selector(handleProceed), for: .touchUpInside)
        proceedButton.titleLabel?.font = UIFont(name: "CircularStd-Bold", size: 18)
        proceedButton.isHidden = true
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: proceedButton.frame.size.width, height: proceedButton.frame.size.height)
        proceedButton.layer.insertSublayer(gradient, at: 0)
        
        view.addSubview(proceedButton)
    }
    
    private func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.setNavigationBarHidden(false, animated:true)
    }
    
    @objc private func testFunc() {
        print("test tap")
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        let count = textField.text?.count
        
        return count! < 3
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
