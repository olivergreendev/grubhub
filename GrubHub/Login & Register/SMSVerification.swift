//
//  SMSVerification.swift
//  GrubHub
//
//  Created by Oliver Green on 30/01/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit
import Lottie

class SMSVerification: UIViewController, UITextFieldDelegate {
    
    // 1. Title text view
    // 2. Description text view
    // 3. Create a stack view and equally distribute 5 text fields
    // 4. Limit text field character count to 1
    // 5. Auto-hop to each subsequent text field after previous has been filled
    // 6. Auto-proceed upon last text field being filled; success/error
    // 6.1 Success -> Load new view
    // 6.2 Error -> Turn text fields red, add error label underneath
    // 7. Backspace will clear the text field and go back to the previous text field
    
    private var textField1 = UITextField()
    private var textField2 = UITextField()
    private var textField3 = UITextField()
    private var textField4 = UITextField()
    private var textField5 = UITextField()
    
    private var lottieView: AnimationView = {
        let lottie = AnimationView(name: "loader-4")
        lottie.contentMode = .scaleAspectFill
        lottie.loopMode = .autoReverse
        lottie.isHidden = true
        return lottie
    }()
    
    private let titleText: UITextView = {
        let textView = UITextView()
        textView.text = "Enter the Verification Code"
        //textView.font = UIFont.systemFont(ofSize: 24, weight: .bold)
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
        textView.text = "You should receive a verification code through SMS. Please enter it below."
        //textView.font = UIFont.systemFont(ofSize: 16, weight: .regular)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Stack View
        let stackView = UIStackView()
        stackView.axis = NSLayoutConstraint.Axis.horizontal
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        // TO DO:
        // Use a for loop to create 5 text field instances with the same properties
        // Limit the character count of each text field to 1 character
        
        //Text Field 1
        textField1 = UITextField()
        textField1.backgroundColor = UIColor.textFieldLightGray
        textField1.layer.cornerRadius = 3
        textField1.keyboardType = .phonePad
        textField1.textColor = .darkBlue
        textField1.font = UIFont(name: "CircularStd-Book", size: 31)
        textField1.textAlignment = .center
        textField1.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField1.addTarget(self, action: #selector(textField(_:shouldChangeCharactersIn:replacementString:)), for: UIControl.Event.editingChanged)
        textField1.translatesAutoresizingMaskIntoConstraints = false
        
        //Text Field 2
        textField2 = UITextField()
        textField2.backgroundColor = UIColor.textFieldLightGray
        textField2.layer.cornerRadius = 3
        textField2.keyboardType = .phonePad
        textField2.textColor = .darkBlue
        textField2.font = UIFont(name: "CircularStd-Book", size: 31)
        textField2.textAlignment = .center
        textField2.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField2.translatesAutoresizingMaskIntoConstraints = false
        
        //Text Field 3
        textField3 = UITextField()
        textField3.backgroundColor = UIColor.textFieldLightGray
        textField3.layer.cornerRadius = 3
        textField3.keyboardType = .phonePad
        textField3.textColor = .darkBlue
        textField3.font = UIFont(name: "CircularStd-Book", size: 31)
        textField3.textAlignment = .center
        textField3.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField3.translatesAutoresizingMaskIntoConstraints = false
        
        //Text Field 4
        textField4 = UITextField()
        textField4.backgroundColor = UIColor.textFieldLightGray
        textField4.layer.cornerRadius = 3
        textField4.keyboardType = .phonePad
        textField4.textColor = .darkBlue
        textField4.font = UIFont(name: "CircularStd-Book", size: 31)
        textField4.textAlignment = .center
        textField4.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField4.translatesAutoresizingMaskIntoConstraints = false
        
        //Text Field 5
        textField5 = UITextField()
        textField5.backgroundColor = UIColor.textFieldLightGray
        textField5.layer.cornerRadius = 3
        textField5.keyboardType = .phonePad
        textField5.textColor = .darkBlue
        textField5.font = UIFont(name: "CircularStd-Book", size: 31)
        textField5.textAlignment = .center
        textField5.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textField5.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(textField1)
        stackView.addArrangedSubview(textField2)
        stackView.addArrangedSubview(textField3)
        stackView.addArrangedSubview(textField4)
        stackView.addArrangedSubview(textField5)
        
        //Constraints
        textField1.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField1.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        textField2.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField2.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        textField3.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField3.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        textField4.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField4.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        textField5.heightAnchor.constraint(equalToConstant: 60).isActive = true
        textField5.widthAnchor.constraint(equalToConstant: 60).isActive = true
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200).isActive = true
        
        // Lottie Test
        let loaderView = UIView(frame: CGRect(x: view.frame.width/2 - 50, y: 350, width: 100, height: 20))
        view.addSubview(loaderView)
        
        lottieView.frame = loaderView.bounds
        loaderView.addSubview(lottieView)
        
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
        //textViewContainer.backgroundColor = .lightGray
        
        view.addSubview(textViewContainer)
        textViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        textViewContainer.addSubview(titleText)
        textViewContainer.addSubview(descriptionText)
        
        textViewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        textViewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        textViewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        textViewContainer.bottomAnchor.constraint(equalTo: descriptionText.bottomAnchor).isActive = true
        //textViewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        // setup the constraints for the title and description text objects
        //view.addSubview(titleText)
        titleText.topAnchor.constraint(equalTo: textViewContainer.topAnchor, constant: 80).isActive = true
        titleText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //titleText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        //titleText.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2)
        
        //view.addSubview(descriptionText)
        descriptionText.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 20).isActive = true
        descriptionText.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionText.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //descriptionText.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    @objc func textFieldDidChange(textField: UITextField) {

        let text = textField.text
        
        if text?.count == 1 {
            
            switch textField {
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                textField5.becomeFirstResponder()
            case textField5:
                textField5.resignFirstResponder()
                // CALL THE TWILIO API AND VERIFY THE CODE HERE
                lottieView.isHidden = false
                lottieView.play()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let successView = SMSVerificationSuccess()
                    successView.modalPresentationStyle = .fullScreen
                    self.present(successView, animated: true, completion: nil)
                }
            default:
                break
            }
        }
        
        if text?.count == 0 {
            
            switch textField {
            case textField1:
                textField1.becomeFirstResponder()
            case textField2:
                textField1.becomeFirstResponder()
            case textField3:
                textField2.becomeFirstResponder()
            case textField4:
                textField3.becomeFirstResponder()
            case textField5:
                textField4.becomeFirstResponder()
            default:
                break
            }
        }
        else{

        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        return false
    }
}
