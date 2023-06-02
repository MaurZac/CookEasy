//
//  MainViewRemoteDataManager.swift
//  CookEasy
//
//  Created by Mauricio Zarate Chula on 5/26/23.
//  
//

import Foundation

class MainViewRemoteDataManager:MainViewRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: MainViewRemoteDataManagerOutputProtocol?
    
    func externalGetData() {
        print("externalRomateDM")
        guard let url = URL(string: "https://demo2477170.mockable.io/recipes") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let res = try? JSONDecoder().decode(Arka.self, from: data) {
                    self.remoteRequestHandler?.remoteDataManagerCallBackData(with: res)
                } else {
                    print("Invalid Response")
                }
            } else if let error = error {
                print("HTTP Request Failed \(error)")
            }
        }
        task.resume()
    }
    
}
