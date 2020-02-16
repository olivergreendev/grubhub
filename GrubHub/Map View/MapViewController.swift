//
//  MapsController.swift
//  GrubHub
//
//  Created by Oliver Green on 02/02/2020.
//  Copyright © 2020 Oliver Green. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // UIApplication.shared.keyWindow?.rootViewController = self
    private var mapView = MKMapView()
    private let locationManager = CLLocationManager()
    private let costaLocation = CLLocationCoordinate2D(latitude: 37.7620, longitude: -122.4348)
    
    private let cellData = CellEntryAPI.getCellData()
    
    private let cardContainer: UIView = {
        // main card
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.clipsToBounds = true
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        view.layer.shadowColor = UIColor.purpleShadow.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 20
        return view
    }()
    
    private let lineView: UIView = {
        // top line
        let view = UIView()
        view.backgroundColor = .placeholderGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 4
        return view
    }()
    
    private let contentContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .placeholderGrey
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var contentTableView: UITableView! = {
        var view = UITableView(frame: .zero, style: .grouped)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(CustomTableViewCell.self, forCellReuseIdentifier: "cellId")
        view.showsVerticalScrollIndicator = false
        view.separatorColor = .clear
        return view
    }()
    
    // Card Swiping
    var visualEffectView = UIVisualEffectView()
    
    var cardTapArea: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    enum CardState {
        case expanded
        case collapsed
    }
    
    var cardVisible = true
    var nextState: CardState {
        return cardVisible ? .collapsed : .expanded
    }
    
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted: CGFloat = 0
    
    var proceedButton = UIButton()
    var didSelectOption = false
    
    @objc private func handleProceed() {
        if didSelectOption {
            let loadAppHome = MainViewController()
            loadAppHome.modalPresentationStyle = .fullScreen
            self.present(loadAppHome, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        mapView.delegate = self
        contentTableView.delegate = self
        contentTableView.dataSource = self
        
        setupMaps()
        checkLocationServices()
        setupCardLayout()
        setupProceedButton()
        
        if !cellData.isEmpty {
            for cell in cellData {
                drawPins(title: cell.title!, subTitle: cell.distance!, location: CLLocationCoordinate2D(latitude: cell.latitude!, longitude: cell.longitude!))
            }
        }
    }
    
    private func setupProceedButton() {
        proceedButton = UIButton(frame: CGRect(x: (view.frame.width) - 110, y: (view.frame.height) - 160, width: 80, height: 80))
        proceedButton.backgroundColor = .green
        proceedButton.clipsToBounds = true
        proceedButton.layer.cornerRadius = proceedButton.frame.size.width / 2
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
        
        //view.addSubview(proceedButton)
        view.insertSubview(proceedButton, belowSubview: cardContainer)
    }
    
    @objc func handleCardTap(recognizer: UITapGestureRecognizer) {
        
        //print(cardContainer.frame)
        
        switch recognizer.state {
        case .ended:
            animatedTransitionIfNeeded(state: nextState, duration: 0.5)
            break
        default:
            break
        }
        
        // LOOK INTO DOING A DIFFERENT TYPE OF ANIMATION
        // ANIMATE THE FRAME.ORIGIN.Y USING animateWithDuration OR SOMETHING
    }
    
    @objc func handleCardPan(recognizer: UIPanGestureRecognizer) {
        
    }
    
    func animatedTransitionIfNeeded(state: CardState, duration: TimeInterval) {
        
        if runningAnimations.isEmpty {
            
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    self.cardContainer.frame.origin.y = self.view.frame.height - 600
                case .collapsed:
                    self.cardContainer.frame.origin.y = self.view.frame.height - 50
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
        }
    }
    
    func setMapRegion(latitude: Double, longitude: Double) {
        // Move the focus of the map view to the selected cell data, e.g. costa
//        let region = MKCoordinateRegion(center: costaLocation, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//        self.mapView.setRegion(region, animated: true)
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    func setupMaps() {
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        if #available(iOS 13.0, *) {
            mapView.overrideUserInterfaceStyle = .light
        }
        view.addSubview(mapView)
        
        let center = CLLocationCoordinate2D(latitude: 51.495910, longitude: -0.858530)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func drawPins(title: String, subTitle: String, location: CLLocationCoordinate2D) {
        
        // if locations are found within the range of the user, dynamically add them to the cellData array
        // if this array is not empty, then draw all the pins for each location on the map
        // something like a for loop that goes through the array, parsing all the required data to a new function called drawPins()
        let pinn = CustomMapPin(pinTitle: "Costa", pinSubTitle: "San Francisco", location: costaLocation)
        //self.mapView.addAnnotation(pinn)
        
        let pin = CustomMapPin(pinTitle: title, pinSubTitle: subTitle, location: location)
        
//        for cell in cellData {
//            print(cell.title)
//        }
        
        mapView.addAnnotation(pin)
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 10000, longitudinalMeters: 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorisation()
        } else {
            // show an alert to the user that they need to turn it on
        }
    }
    
    func checkLocationAuthorisation() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            //centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // show alert with instructions to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            // show an alert letting them know
            break
        case .authorizedAlways:
            break
        }
    }
    
    private func setupCardLayout() {
        
        view.addSubview(cardContainer)
        cardContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        cardContainer.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        cardContainer.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        cardContainer.heightAnchor.constraint(equalToConstant: 600).isActive = true
        //cardContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        // start: 50, target: 600
        
        cardContainer.addSubview(lineView)
        lineView.topAnchor.constraint(equalTo: cardContainer.topAnchor, constant: 10).isActive = true
        lineView.centerXAnchor.constraint(equalTo: cardContainer.centerXAnchor).isActive = true
        lineView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 8).isActive = true
        
        cardContainer.addSubview(contentContainer)
        contentContainer.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20).isActive = true
        contentContainer.leftAnchor.constraint(equalTo: cardContainer.leftAnchor, constant: 15).isActive = true
        contentContainer.rightAnchor.constraint(equalTo: cardContainer.rightAnchor, constant: -15).isActive = true
        contentContainer.bottomAnchor.constraint(equalTo: cardContainer.bottomAnchor).isActive = true
        
        contentContainer.addSubview(contentTableView)
        contentTableView.topAnchor.constraint(equalTo: contentContainer.topAnchor).isActive = true
        contentTableView.leftAnchor.constraint(equalTo: contentContainer.leftAnchor).isActive = true
        contentTableView.rightAnchor.constraint(equalTo: contentContainer.rightAnchor).isActive = true
        contentTableView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor).isActive = true
        
        cardContainer.addSubview(cardTapArea)
        cardTapArea.topAnchor.constraint(equalTo: cardContainer.topAnchor).isActive = true
        cardTapArea.leftAnchor.constraint(equalTo: cardContainer.leftAnchor).isActive = true
        cardTapArea.rightAnchor.constraint(equalTo: cardContainer.rightAnchor).isActive = true
        cardTapArea.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        // Card Tap Gesture Recognition
        let tapCardGesture = UITapGestureRecognizer(target: self, action: #selector(handleCardTap(recognizer:)))
        //let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleCardPan(recognizer:)))
        
        cardTapArea.addGestureRecognizer(tapCardGesture)
        //cardContainer.addGestureRecognizer(panGestureRecognizer)
    }
    
    // Table View Delegates
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        animatedTransitionIfNeeded(state: nextState, duration: 0.5)
        setMapRegion(latitude: cellData[indexPath.row].latitude!, longitude: cellData[indexPath.row].longitude!)
        didSelectOption = true
        proceedButton.isHidden = false
        // parse data on the selected row such that if proceed button is tapped, the correct data is supplied
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath as IndexPath) as! CustomTableViewCell
        cell.entry = cellData[indexPath.row]
        cell.backgroundColor = .white
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let headerTitle = UILabel(frame: headerView.bounds)
                
        headerTitle.text = "Nearby"
        headerTitle.font = UIFont(name: "CircularStd-Book", size: 18)
        headerTitle.textColor = .gray
        
        headerView.addSubview(headerTitle)
        
        return headerView
    }
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: 10000, longitudinalMeters: 10000)
//        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // change authorisation
    }
}

extension MapViewController: MKMapViewDelegate {
    
    // Map View Delegates
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else { return nil }
        
        //var annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom-map-pin")
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "custom-map-pin")
        annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "custom-map-pin")
        annotationView?.image = #imageLiteral(resourceName: "custom-map-pin")
        annotationView?.canShowCallout = true
        
        //annotationView.image = #imageLiteral(resourceName: "custom-map-pin")
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        // Tapped on annotation view
        print("tapped")
    }
}
