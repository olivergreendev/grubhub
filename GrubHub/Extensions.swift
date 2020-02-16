//
//  Extensions.swift
//  GrubHub
//
//  Created by Oliver Green on 29/01/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

extension UIColor {
    static var gradientPurple = UIColor(red: 122/255.0, green: 70/255.0, blue: 207/255.0, alpha: 1.0)
    static var gradientBlue = UIColor(red: 117/255.0, green: 163/255.0, blue: 249/255.0, alpha: 1.0)
    static var primaryBlue = UIColor(red: 117/255.0, green: 161/255.0, blue: 248/255.0, alpha: 1.0)
    static var darkBlue = UIColor(red: 36/255.0, green: 52/255.0, blue: 84/255.0, alpha: 1.0)
    static var defaultBackground = UIColor(red: 247/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1.0)
    static var textFieldLightGray = UIColor(red: 236/255.0, green: 236/255.0, blue: 236/255.0, alpha: 1.0)
    static var placeholderGrey = UIColor(red: 212/255.0, green: 212/255.0, blue: 212/255.0, alpha: 1.0)
    static var purpleShadow = UIColor(red: 122/255.0, green: 72/255.0, blue: 208/255.0, alpha: 1.0)
}

extension UIViewController {
    func presentViewController(_ viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewController, animated: false)
    }
    
    func presentNavigationViewController(_ viewController: UINavigationController) {
        let transition = CATransition()
        transition.duration = 0.25
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        present(viewController, animated: false)
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount: CGFloat) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }

    func setLeftIcon(_ icon: UIImage) {

       let padding = 20
        // image size
       let size = 28

       let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+(padding*2), height: size) )
        //outerView.backgroundColor = .red
       let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
       iconView.image = icon
       outerView.addSubview(iconView)

       leftView = outerView
       leftViewMode = .always
     }
}

extension UIView {
    
    func setGradientBackground() {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
        //layer.insertSublayer(gradientLayer, at: 0)
        layer.addSublayer(gradientLayer)
        //self.clipsToBounds = true
    }
    
    func setCurvedGradientBackground() {
        
        /*
        let circularView = UIView()
        addSubview(circularView)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        circularView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        circularView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        circularView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        circularView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        layoutIfNeeded()
        */

        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 1)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradient)

        /*
        let circularPath = CGMutablePath()

        circularPath.move(to: CGPoint.init(x: 20, y: 0))
        circularPath.addLine(to: CGPoint.init(x: self.bounds.width - 20, y: 0))
        circularPath.addQuadCurve(to: CGPoint.init(x: self.bounds.width, y: 20), control: CGPoint.init(x: self.bounds.width, y: 0))
        circularPath.addLine(to: CGPoint.init(x: self.bounds.width, y: self.bounds.height - 20))
        circularPath.addQuadCurve(to: CGPoint.init(x: self.bounds.width - 20, y: self.bounds.height), control: CGPoint.init(x: self.bounds.width, y: self.bounds.height))
        circularPath.addLine(to: CGPoint.init(x: 20, y: self.bounds.height))
        circularPath.addQuadCurve(to: CGPoint.init(x: 0, y: self.bounds.height - 20), control: CGPoint.init(x: 0, y: self.bounds.height))
        circularPath.addLine(to: CGPoint.init(x: 0, y: 20))
        circularPath.addQuadCurve(to: CGPoint.init(x: 20, y: 0), control: CGPoint.init(x: 0, y: 0))

        let maskLayer = CAShapeLayer()
        maskLayer.path = circularPath
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.fillColor = UIColor.red.cgColor
        self.layer.mask = maskLayer
         */
    }
    
    func setCellStyle() {
        //Corner Radius
        layer.cornerRadius = 8
        
        //Shadow
        let cellShadowPath = UIBezierPath(rect: self.bounds)
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        //layer.shadowRadius = 3.0 //5.0
        layer.shadowOpacity = 1.0 //0.2
        layer.shadowPath = cellShadowPath.cgPath
    }
}
