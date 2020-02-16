//
//  SwipeController.swift
//  GrubHub
//
//  Created by Oliver Green on 26/01/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit

class SwipeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let pages = [
        Page(imageName: "onboard_1", titleText: "Locate.", descriptionText: "GrubHub will detect where you are to make your life easier."),
        Page(imageName: "onboard_2", titleText: "Order.", descriptionText: "Skip the queue and order directly from the app. Get back to more important stuff."),
        Page(imageName: "onboard_3", titleText: "Enjoy.", descriptionText: "Collect reward points that can be used to claim your next order!")
    ]
    
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc private func handlePrevious() {
        let nextIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        handleGetStartedButtonVisibility()
    }
    
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 117/255.0, green: 162/255.0, blue: 249/255.0, alpha: 1.0), for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    @objc private func handleNext() {
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        
        pageControl.currentPage = nextIndex
        
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        handleGetStartedButtonVisibility()
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPage = 0
        pageControl.numberOfPages = pages.count
        pageControl.currentPageIndicatorTintColor = .primaryBlue
        pageControl.pageIndicatorTintColor = UIColor(red: 117/255.0, green: 162/255.0, blue: 249/255.0, alpha: 0.2)
        pageControl.isUserInteractionEnabled = false
        return pageControl
    }()
    
    private var getStartedButton = UIButton()
    private var bottomControlsStackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBottomControls()
        
        collectionView.backgroundColor = UIColor(red: 247/255.0, green: 248/255.0, blue: 250/255.0, alpha: 1.0)
        
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.isPagingEnabled = true
    }
    
    fileprivate func setupBottomControls() {
        
        bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        
        view.addSubview(bottomControlsStackView)
        NSLayoutConstraint.activate([bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70), bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor), bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor), bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50)])
        
        getStartedButton = UIButton(frame: CGRect(x: (view.frame.width/2) - 90, y: 610, width: 180, height: 60))
        getStartedButton.backgroundColor = .green
        getStartedButton.clipsToBounds = true
        getStartedButton.layer.cornerRadius = 30
        getStartedButton.setTitle("Get Started", for: .normal)
        getStartedButton.addTarget(self, action: #selector(handleGetStarted), for: .touchUpInside)
        //getStartedButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        getStartedButton.titleLabel?.font = UIFont(name: "CircularStd-Bold", size: 18)
        //getStartedButton.translatesAutoresizingMaskIntoConstraints = false
        getStartedButton.isHidden = true
        view.addSubview(getStartedButton)
        
        //getStartedButton.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -110).isActive = true
        //getStartedButton.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //getStartedButton.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //getStartedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
                
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.gradientPurple.cgColor, UIColor.gradientBlue.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradient.frame = CGRect(x: 0.0, y: 0.0, width: getStartedButton.frame.size.width, height: getStartedButton.frame.size.height)
        getStartedButton.layer.insertSublayer(gradient, at: 0)
    }
    
    private func handleGetStartedButtonVisibility() {
        if pageControl.currentPage == 2 {
            bottomControlsStackView.isHidden = true
            getStartedButton.isHidden = false
        } else {
            bottomControlsStackView.isHidden = false
            getStartedButton.isHidden = true
        }
    }
    
    @objc private func handleGetStarted() {
        
        //let loadHomeGateway = HomeGateway()
        //loadHomeGateway.modalPresentationStyle = .fullScreen
        //present(loadHomeGateway, animated: true, completion: nil)
        
        //presentViewController(loadHomeGateway)
        
        let homeGatewayView = UINavigationController(rootViewController: HomeGateway())
        homeGatewayView.modalPresentationStyle = .fullScreen
        present(homeGatewayView, animated: true, completion: nil)
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
        
        handleGetStartedButtonVisibility()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return pages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! PageCell
        
        let page = pages[indexPath.item]
        
        cell.page = page
        
//        if (indexPath.item == 2) {
//            getStartedButton.isHidden = false
//        } else {
//            getStartedButton.isHidden = true
//        }
        
        //print(pageControl.currentPage)
        
        //cell.locateImageView.image = UIImage(named: page.imageName)
        //cell.titleTextView.text = page.titleText
        //cell.descriptionTextView.text = page.descriptionText
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: view.frame.height)
        //return CGSize(width: 100, height: 100)
    }
}
