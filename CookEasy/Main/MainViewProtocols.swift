//
//  MainViewProtocols.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation
import UIKit

protocol MainViewViewProtocol: class {
    // PRESENTER -> VIEW
    var presenter: MainViewPresenterProtocol? { get set }
}

protocol MainViewWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createMainViewModule() -> UIViewController
}

protocol MainViewPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: MainViewViewProtocol? { get set }
    var interactor: MainViewInteractorInputProtocol? { get set }
    var wireFrame: MainViewWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol MainViewInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
}

protocol MainViewInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MainViewInteractorOutputProtocol? { get set }
    var localDatamanager: MainViewLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MainViewRemoteDataManagerInputProtocol? { get set }
}

protocol MainViewDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MainViewRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MainViewRemoteDataManagerOutputProtocol? { get set }
}

protocol MainViewRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
}

protocol MainViewLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
