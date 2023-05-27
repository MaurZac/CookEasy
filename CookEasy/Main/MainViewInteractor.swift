//
//  MainViewInteractor.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation

class MainViewInteractor: MainViewInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MainViewInteractorOutputProtocol?
    var localDatamanager: MainViewLocalDataManagerInputProtocol?
    var remoteDatamanager: MainViewRemoteDataManagerInputProtocol?

}

extension MainViewInteractor: MainViewRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
