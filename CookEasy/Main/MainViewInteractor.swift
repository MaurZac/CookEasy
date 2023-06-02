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
    
    var dataResponse = [ArkaElement]()
    
    func getData() {
        remoteDatamanager?.externalGetData()
    }

}

extension MainViewInteractor: MainViewRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
    func remoteDataManagerCallBackData(with Arka: [ArkaElement]) {
        dataResponse = Arka
        presenter?.interPushDataPresenter(receivedData: dataResponse)
    }
    
}
