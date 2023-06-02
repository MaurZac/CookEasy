//
//  DetailsRecipePresenter.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/27/23.
//  
//

import Foundation

class DetailsRecipePresenter  {
    
    // MARK: Properties
    weak var view: DetailsRecipeViewProtocol?
    var interactor: DetailsRecipeInteractorInputProtocol?
    var wireFrame: DetailsRecipeWireFrameProtocol?
    var datoArkaReceived: ArkaElement?
}

extension DetailsRecipePresenter: DetailsRecipePresenterProtocol {
    // TODO: implement presenter methods
    func viewDidLoad() {
        if let datoArkaReceived = datoArkaReceived {
            view?.showDataInLabel(data: datoArkaReceived)
        }
    }
}

extension DetailsRecipePresenter: DetailsRecipeInteractorOutputProtocol {
    // TODO: implement interactor output methods
}
