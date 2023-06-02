//
//  DetailsRecipeWireFrame.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/27/23.
//  
//

import Foundation
import UIKit

class DetailsRecipeWireFrame: DetailsRecipeWireFrameProtocol {
    
    class func createDetailsRecipeModule(with data: ArkaElement) -> UIViewController {
        print("dataquepaso:\(data)")
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "DetailsRecipeView")
        if let view = navController as? DetailsRecipeView   {
            let presenter: DetailsRecipePresenterProtocol & DetailsRecipeInteractorOutputProtocol = DetailsRecipePresenter()
            let interactor: DetailsRecipeInteractorInputProtocol & DetailsRecipeRemoteDataManagerOutputProtocol = DetailsRecipeInteractor()
            let localDataManager: DetailsRecipeLocalDataManagerInputProtocol = DetailsRecipeLocalDataManager()
            let remoteDataManager: DetailsRecipeRemoteDataManagerInputProtocol = DetailsRecipeRemoteDataManager()
            let wireFrame: DetailsRecipeWireFrameProtocol = DetailsRecipeWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            presenter.datoArkaReceived = data
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "DetailsRecipeView", bundle: Bundle.main)
    }
    
}
