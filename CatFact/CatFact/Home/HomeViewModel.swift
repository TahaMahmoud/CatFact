//
//  HomeViewModel.swift
//  CatFact
//
//  Created by Taha on 18/04/2022.
//

import Foundation
import Combine

protocol HomeViewModelOutput {
    
}

protocol HomeViewModelInput {
    func viewDidLoad()
    func getNewFactTapped()
}

class HomeViewModel: HomeViewModelInput, HomeViewModelOutput {

    
    @Published var fact: String?

    @Published var indicator: Bool?
    @Published var error: String?
    
    var subscriptions = Set<AnyCancellable>()

    private let homeInteractor: HomeInteractorProtocol
    
    init(homeInteractor: HomeInteractorProtocol = HomeInteractor(networkManager: AlamofireManager())) {
        self.homeInteractor = homeInteractor
    }
    
    func viewDidLoad() {
        fetchFact()
    }
    
    func fetchFact() {
        indicator = true

        DispatchQueue.global().async {
            
            sleep(2) // Simuation Network Waiting
            
            self.homeInteractor.fetchFact()
                .sink(receiveCompletion: { [weak self] (completion) in
                    
                    self?.indicator = false
                    
                    switch completion {
                    case let .failure(error):
                        self?.error = error.localizedDescription
                    case .finished:
                        break
                }
                }) { [weak self] fact in
                    self?.fact = fact.fact
                }
                .store(in: &self.subscriptions)
            
        }

    }
    
    func getNewFactTapped() {
        fetchFact()
    }
    
}
