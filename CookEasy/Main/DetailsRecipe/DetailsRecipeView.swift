//
//  DetailsRecipeView.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/27/23.
//  
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

class DetailsRecipeView: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {

    // MARK: Properties
    var presenter: DetailsRecipePresenterProtocol?
    private let locationManager = CLLocationManager()
    var latt = 00.00
    var long = 00.00
    var tittleUp = "Details"
    
    let mapConstainer: GMSMapView = {
        let mapConstainer = GMSMapView()
        mapConstainer.contentMode = .scaleAspectFill
        mapConstainer.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        mapConstainer.clipsToBounds = true
        return mapConstainer
     }()
    
    let titlelbl:UILabel = {
    let titlelbl = UILabel()
        titlelbl.font = UIFont.boldSystemFont(ofSize: 22)
        titlelbl.textColor = UIColor(named: "blueOne")
        titlelbl.translatesAutoresizingMaskIntoConstraints = false
        return titlelbl
    }()
    
    let infoAddlbl1:UILabel = {
    let infoAddlbl = UILabel()
        infoAddlbl.font = UIFont.boldSystemFont(ofSize: 20)
        infoAddlbl.textColor = UIColor(named: "countryColor")
        infoAddlbl.translatesAutoresizingMaskIntoConstraints = false
        return infoAddlbl
    }()
    
    let infoAddlbl2:UILabel = {
    let infoAddlbl = UILabel()
        infoAddlbl.font = UIFont.boldSystemFont(ofSize: 18)
        infoAddlbl.textColor = UIColor(named: "titleColor")
        infoAddlbl.translatesAutoresizingMaskIntoConstraints = false
        return infoAddlbl
    }()
    
    let recipeImg:UIImageView = {
    let img = UIImageView()
    img.contentMode = .scaleAspectFit
    img.translatesAutoresizingMaskIntoConstraints = false
    img.layer.cornerRadius = 50
    //img.clipsToBounds = true
    return img
    }()
    
   
    
    
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
       
        presenter?.viewDidLoad()
        mapConstainer.delegate = self
        constraints()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        
        if CLLocationManager.locationServicesEnabled() {
          switch (CLLocationManager.authorizationStatus()) {
            case .notDetermined, .restricted, .denied:
              print("No access")
            case .authorizedAlways, .authorizedWhenInUse:
              print("Access")
              showCurrentLocation()
          }
        } else {
          print("Location services are not enabled")
        }
        
    }

    override func viewWillLayoutSubviews() {
        configNavBarDetail()
    }
    
    func showCurrentLocation() {
        mapConstainer.settings.myLocationButton = true
        let locationObj = locationManager.location!
        let coord = locationObj.coordinate
//        let lattitude =  coord.latitude
//        let longitude = coord.longitude
//        print(" lat in  updating \(lattitude) ")
//        print(" long in  updating \(longitude)")

//        let center = CLLocationCoordinate2D(latitude: locationObj.coordinate.latitude, longitude: locationObj.coordinate.longitude)
        
        let center = CLLocationCoordinate2D(latitude: latt, longitude: long)
        
        
        
        print(latt)
        print(long)
        let marker = GMSMarker()
        marker.position = center
        marker.title = titlelbl.text
        marker.icon = UIImage(named: "pinSelected")
        marker.map = mapConstainer
        let camera: GMSCameraPosition = GMSCameraPosition.camera(withLatitude: latt, longitude: long, zoom: Float(3.0))
        self.mapConstainer.animate(to: camera)
    }
    
    
    func constraints(){

        
        view.addSubview(mapConstainer)

        view.addSubview(titlelbl)
        view.addSubview(infoAddlbl1)
        view.addSubview(infoAddlbl2)
        view.addSubview(recipeImg)
        
        
        mapConstainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        mapConstainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapConstainer.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        titlelbl.topAnchor.constraint(equalTo: mapConstainer.bottomAnchor, constant: 0).isActive = true
        titlelbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        titlelbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        titlelbl.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        //cousine country
        infoAddlbl1.topAnchor.constraint(equalTo: mapConstainer.bottomAnchor, constant: 40).isActive = true
        infoAddlbl1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        infoAddlbl1.widthAnchor.constraint(equalToConstant: 150).isActive = true
        infoAddlbl1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        //description
        infoAddlbl2.topAnchor.constraint(equalTo: mapConstainer.bottomAnchor, constant: 40).isActive = true
        infoAddlbl2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        infoAddlbl2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        //infoAddlbl2.widthAnchor.constraint(equalToConstant: 300).isActive = true
        infoAddlbl2.heightAnchor.constraint(equalToConstant: 200).isActive = true
        infoAddlbl2.lineBreakMode = NSLineBreakMode.byCharWrapping
        infoAddlbl2.textAlignment = .justified
        infoAddlbl2.numberOfLines = 5
        
        recipeImg.topAnchor.constraint(equalTo: infoAddlbl2.bottomAnchor, constant: 5).isActive = true
        recipeImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        recipeImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        recipeImg.widthAnchor.constraint(equalToConstant: 150).isActive = true
        recipeImg.heightAnchor.constraint(equalToConstant: 150).isActive = true
        recipeImg.image = UIImage(named: "recipe")
        recipeImg.layer.cornerRadius = 10
    }
    
    func configNavBarDetail() {
        title = tittleUp
        navigationController?.navigationBar.tintColor = .darkGray
        view.backgroundColor = .tertiarySystemGroupedBackground
    }
}

extension DetailsRecipeView: DetailsRecipeViewProtocol {
    // TODO: implement view output methods
    func showDataInLabel(data: ArkaElement) {
        titlelbl.text = data.title
        infoAddlbl1.text = data.cuisine
        infoAddlbl2.text = data.description
        tittleUp = data.title
        latt = data.latitude
        long = data.longitude
        recipeImg.downloaded(from: data.photoURL)
        recipeImg.layer.cornerRadius = 10
        print("\(latt)")
        print("\(long)")
    }
}


