//
//  HomeInteractor.swift
//  CatFact
//
//  Created by Taha on 18/04/2022.
//

import Foundation
import Combine

protocol HomeInteractorProtocol: AnyObject {
    func fetchFact() -> Future<Fact, NetworkError>
}

class HomeInteractor: HomeInteractorProtocol {
    
    var networkManager: NetworkProtocol
    
    init(networkManager: NetworkProtocol = AlamofireManager()) {
        self.networkManager = networkManager
    }

    var request: HomeRequest?

    func fetchFact() -> Future<Fact, NetworkError> {
        return networkManager.callRequest(Fact.self, endpoint: HomeRequest.getFact)
    }

}
