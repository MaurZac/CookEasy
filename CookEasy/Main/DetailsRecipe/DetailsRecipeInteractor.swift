//
//  DetailsRecipeInteractor.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/27/23.
//  
//

import Foundation

class DetailsRecipeInteractor: DetailsRecipeInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: DetailsRecipeInteractorOutputProtocol?
    var localDatamanager: DetailsRecipeLocalDataManagerInputProtocol?
    var remoteDatamanager: DetailsRecipeRemoteDataManagerInputProtocol?

}

extension DetailsRecipeInteractor: DetailsRecipeRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
