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
    func presenterPushDataView(received: [ArkaElement])
}

protocol MainViewWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    static func createMainViewModule() -> UIViewController
    func presentNewViewDetail(from view: MainViewViewProtocol, withData: ArkaElement )

}

protocol MainViewPresenterProtocol: class {
    // VIEW -> PRESENTER
    var view: MainViewViewProtocol? { get set }
    var interactor: MainViewInteractorInputProtocol? { get set }
    var wireFrame: MainViewWireFrameProtocol? { get set }
    
    func viewDidLoad()
    func showDetailView(with data: ArkaElement)
}

protocol MainViewInteractorOutputProtocol: class {
// INTERACTOR -> PRESENTER
    func interPushDataPresenter(receivedData: [ArkaElement])
}

protocol MainViewInteractorInputProtocol: class {
    // PRESENTER -> INTERACTOR
    var presenter: MainViewInteractorOutputProtocol? { get set }
    var localDatamanager: MainViewLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MainViewRemoteDataManagerInputProtocol? { get set }
    
    func getData() 
}

protocol MainViewDataManagerInputProtocol: class {
    // INTERACTOR -> DATAMANAGER
}

protocol MainViewRemoteDataManagerInputProtocol: class {
    // INTERACTOR -> REMOTEDATAMANAGER
    var remoteRequestHandler: MainViewRemoteDataManagerOutputProtocol? { get set }
    func externalGetData()
    
}

protocol MainViewRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func remoteDataManagerCallBackData(with Arka: [ArkaElement])
}

protocol MainViewLocalDataManagerInputProtocol: class {
    // INTERACTOR -> LOCALDATAMANAGER
}
