//
//  DetailsRecipeProtocols.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/27/23.
//  
//

import Foundation
import UIKit

protocol DetailsRecipeViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: DetailsRecipePresenterProtocol? { get set }
    func showDataInLabel(data: ArkaElement)
}

protocol DetailsRecipeWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createDetailsRecipeModule(with data: ArkaElement) -> UIViewController
}

protocol DetailsRecipePresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: DetailsRecipeViewProtocol? { get set }
    var interactor: DetailsRecipeInteractorInputProtocol? { get set }
    var wireFrame: DetailsRecipeWireFrameProtocol? { get set }
    var datoArkaReceived: ArkaElement? { get set }
    func viewDidLoad()
}

protocol DetailsRecipeInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol DetailsRecipeInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: DetailsRecipeInteractorOutputProtocol? { get set }
    var localDatamanager: DetailsRecipeLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DetailsRecipeRemoteDataManagerInputProtocol? { get set }
}

protocol DetailsRecipeDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol DetailsRecipeRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: DetailsRecipeRemoteDataManagerOutputProtocol? { get set }
}

protocol DetailsRecipeRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol DetailsRecipeLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
