//
//  MainViewWireFrame.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation
import UIKit

class MainViewWireFrame: MainViewWireFrameProtocol {

    class func createMainViewModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "navigation")
        if let view = navController.children.first as? MainViewView {
            let presenter: MainViewPresenterProtocol & MainViewInteractorOutputProtocol = MainViewPresenter()
            let interactor: MainViewInteractorInputProtocol & MainViewRemoteDataManagerOutputProtocol = MainViewInteractor()
            let localDataManager: MainViewLocalDataManagerInputProtocol = MainViewLocalDataManager()
            let remoteDataManager: MainViewRemoteDataManagerInputProtocol = MainViewRemoteDataManager()
            let wireFrame: MainViewWireFrameProtocol = MainViewWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "MainViewView", bundle: Bundle.main)
    }
    
    func presentNewViewDetail(from view: MainViewViewProtocol, withData: ArkaElement) {
        //crear nuevo modulo y llamado
        let newDetailView = DetailsRecipeWireFrame.createDetailsRecipeModule(with: withData)
        //createDetailModule(with: withData)
        if let newView =  view as? UIViewController{
            newView.navigationController?.pushViewController(newDetailView, animated: true)
        }
    }
    
}
