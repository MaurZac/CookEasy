//
//  MainViewView.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation
import UIKit
import MapKit
import CoreLocation

class MainViewView: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableVi: UITableView!
    // MARK: Properties
    var locationManager = CLLocationManager()
    
    
    var presenter: MainViewPresenterProtocol?
    var datResView = [ArkaElement]()
    var datResViewFiltered = [ArkaElement]()
    var searching = false
    var usrLat = 0.0
    var usrLon = 0.0
    var totalDistance = 0.0
    
   
    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        datResViewFiltered = datResView
        //delegados
        tableVi.dataSource = self
        tableVi.delegate = self
        searchBar.delegate = self
        navigationItem.title = "Easy Cook"
        tableVi.separatorStyle = .none
        
        self.tableVi.register(RecipeTableViewCell.self, forCellReuseIdentifier: RecipeTableViewCell.identifier)
        presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
        
        locationManager.delegate = self
           determineMyCurrentLocation()
       }
  

    
    

    
   func determineMyCurrentLocation() {
          locationManager = CLLocationManager()
          locationManager.delegate = self
          locationManager.desiredAccuracy = kCLLocationAccuracyBest
          locationManager.requestAlwaysAuthorization()
      
       DispatchQueue.global().async {
           if CLLocationManager.locationServicesEnabled() {
               self.locationManager.startUpdatingLocation()
               //self.locationManager.startUpdatingHeading()
           }
       }
      }
      
   
      func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          let userLocation:CLLocation = locations[0] as CLLocation
          
          // Call stopUpdatingLocation() to stop listening for location updates,
          // other wise this function will be called every time when user location changes.
          
         // manager.stopUpdatingLocation()
          usrLat = userLocation.coordinate.latitude
          usrLon = userLocation.coordinate.longitude
          print("user latitude = \(userLocation.coordinate.latitude)")
          print("user longitude = \(userLocation.coordinate.longitude)")
      }
    
    func calculateDistance(userLon: Double, userLat: Double, destineLon: Double, destineLat: Double){
        let coordinate0 = CLLocation(latitude: userLat, longitude: userLon)
        let coordinate1 = CLLocation(latitude: destineLat, longitude: destineLon)
        let distanceIn = coordinate0.distance(from: coordinate1)
        let res = distanceIn / 1000
        let roundedDistance = Double(res).rounded(toPlaces: 1)
        totalDistance = roundedDistance
        print("distancia \(roundedDistance)")
    }
      
      func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
      {
          print("Error \(error)")
      }
 
}



extension MainViewView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var datarecipes = 0
        if searching {
            datarecipes = datResViewFiltered.count
        }else{
            datarecipes = datResView.count
        }
        return datarecipes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVi.dequeueReusableCell(withIdentifier: RecipeTableViewCell.identifier, for: indexPath as IndexPath) as! RecipeTableViewCell
        
        if searching {
            cell.photoImg.downloaded(from: datResViewFiltered[indexPath.row].photoURL)
            cell.photoImg.layer.cornerRadius = 15
            cell.nameLabel.text = datResViewFiltered[indexPath.row].title
            calculateDistance(userLon: usrLon, userLat: usrLat, destineLon: datResViewFiltered[indexPath.row].longitude, destineLat: datResViewFiltered[indexPath.row].latitude)
        }else {
            cell.photoImg.downloaded(from: datResView[indexPath.row].photoURL)
            cell.photoImg.layer.cornerRadius = 15
            cell.nameLabel.text = datResView[indexPath.row].title
            calculateDistance(userLon: usrLon, userLat: usrLat, destineLon: datResView[indexPath.row].longitude, destineLat: datResView[indexPath.row].latitude)
        }

        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if searching {
            presenter?.showDetailView(with: datResViewFiltered[indexPath.row])
        }else{
            presenter?.showDetailView(with: datResView[indexPath.row])
        }
        
    }
}
extension MainViewView: UISearchBarDelegate {
    
    //user start to writing
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searching = true
        datResViewFiltered = datResView
        print("testo:\(searchText)")
        if searchText == ""{
            tableVi.reloadData()
        }else{
            datResViewFiltered = datResView.filter({ (title) in
                return title.title.contains(searchText)
            })
        }
        self.tableVi.reloadData()
    }
}


extension MainViewView: MainViewViewProtocol {
   
    
    // TODO: implement view output methods
    func presenterPushDataView(received: [ArkaElement]) {
        self.datResView = received
        DispatchQueue.main.async {
            self.tableVi.reloadData()
        }
    }
}

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
extension Double {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}



