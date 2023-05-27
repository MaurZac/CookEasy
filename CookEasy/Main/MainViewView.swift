//
//  MainViewView.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation
import UIKit

class MainViewView: UITabBarController {

    // MARK: Properties
    var presenter: MainViewPresenterProtocol?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        configuareUi()
    }
    
    
    func configuareUi(){
//       searchBarController.delegate = self
//       navigationItem.searchController = searchBarController
        navigationItem.titleView?.backgroundColor = .yellow
        view.backgroundColor = .systemGray6
        
        let vc1 = FirtsViewController()
        let vc2 = SecondViewController()
        let vc3 = ThirdViewController()
        
        vc1.title = "Home"
        vc2.title = "Details"
        vc3.title = "Map"
        self.setViewControllers([vc1,vc2,vc3], animated: true)
        self.tabBar.backgroundColor = .systemGray6
        guard let items = self.tabBar.items else { return }
        let images = ["person.circle","ticket","house"]
        for x in 0..<items.count {
            items[x].image = UIImage(systemName: images[x])
        }
     
    }
}

extension MainViewView: MainViewViewProtocol {
    // TODO: implement view output methods
}

class FirtsViewController: UIViewController{
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Log in", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20), ]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = 15
        button.setTitleColor(.white, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red: 28/255, green: 40/255, blue: 51/255, alpha: 1).cgColor
        button.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        view.addSubview(loginBtn)
        loginBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        loginBtn.widthAnchor.constraint(equalToConstant: 180).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc func goToLogin() {
        print("btnactive")
    }
    
    
    

}
class SecondViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        
    }
}
class ThirdViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray3
        
    }
}
