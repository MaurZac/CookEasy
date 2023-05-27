//
//  MainViewPresenter.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation

class MainViewPresenter  {
    
    // MARK: Properties
    weak var view: MainViewViewProtocol?
    var interactor: MainViewInteractorInputProtocol?
    var wireFrame: MainViewWireFrameProtocol?
    
}

extension MainViewPresenter: MainViewPresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        print("hola desde el presenter")
    }
}

extension MainViewPresenter: MainViewInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
