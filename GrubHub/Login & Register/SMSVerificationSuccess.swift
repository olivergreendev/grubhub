//
//  SMSVerificationSuccess.swift
//  GrubHub
//
//  Created by Ashley Green on 01/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit
import CoreGraphics

class SMSVerificationSuccess: UIViewController {
    
    private var successButton = UIButton()
    
    @objc private func handleSuccessButton() {
        
        let mapsView = MapViewController()
        mapsView.modalPresentationStyle = .fullScreen
        self.present(mapsView, animated: true, completion: nil)
    }
    
    private let lineView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let successImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "success.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Success!"
        textView.font = UIFont(name: "CircularStd-Bold", size: 31)
        textView.textColor = UIColor(red: 117/255.0, green: 161/255.0, blue: 248/255.0, alpha: 1.0)
        textView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1.0)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "You have successfully verified your account. You can now enjoy the benefits of GrubHub!"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBackground()
        setupLayout()
        setupSuccessButton()
        drawLines()
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
        lineView.frame = CGRect(x: 0, y: 100, width: view.frame.width, height: 50)
    }
    
    private func setupBackground() {
        view.backgroundColor = .defaultBackground
    }
    
    private func setupLayout() {
        
        let topImageContainerView = UIView()
        
        topImageContainerView.backgroundColor = .clear
        
        view.addSubview(topImageContainerView)
        topImageContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        topImageContainerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImageContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topImageContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topImageContainerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        
        topImageContainerView.addSubview(successImageView)
        
        successImageView.centerXAnchor.constraint(equalTo: topImageContainerView.centerXAnchor).isActive = true
        successImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -150).isActive = true
        
        view.addSubview(titleTextView)
        titleTextView.topAnchor.constraint(equalTo: topImageContainerView.bottomAnchor, constant: 0).isActive = true
        titleTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleTextView.heightAnchor.constraint(equalToConstant: 300)
        
        view.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: titleTextView.bottomAnchor).isActive = true
        lineView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        lineView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        view.addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: lineView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    private func setupSuccessButton() {
        
        successButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 90, y: 610, width: 180, height: 60))
        successButton.clipsToBounds = true
        successButton.layer.cornerRadius = 30
        successButton.setTitle("Let's Go!", for: .normal)
        successButton.addTarget(self, action: #selector(handleSuccessButton), for: .touchUpInside)
        successButton.titleLabel?.font = UIFont(name: "CircularStd-Bold", size: 18)
        //getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: successButton.frame.size.width, height: successButton.frame.size.height)
        successButton.layer.insertSublayer(gradient, at: 0)
        
        view.addSubview(successButton)
    }
}
