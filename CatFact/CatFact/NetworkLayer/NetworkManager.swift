//
//  NetworkManager.swift
//  CatFact
//
//  Created by Taha on 18/04/2022.
//

import Foundation
import Alamofire
import Combine

protocol NetworkProtocol: AnyObject {
    func callRequest<T>(_ object: T.Type, endpoint: Endpoint) -> Future<T, NetworkError> where T: Codable
}

class AlamofireManager: NetworkProtocol {
    
    func callRequest<T>(_ object: T.Type, endpoint: Endpoint)  -> Future<T, NetworkError> where T : Decodable, T : Encodable {
        
        return Future({ promise in
            AF.request(endpoint)
            .responseDecodable(decoder: JSONDecoder(), completionHandler: { (response: DataResponse<T, AFError>) in
                do {
                    guard let statusCode = response.response?.statusCode else {return}
                        switch statusCode {
                        case 200:
                            let model = try JSONDecoder().decode(T.self, from: response.data!)
                            promise(.success(model))
                        case 403:
                            promise(.failure(NetworkError.forbidden))
                        default:
                            promise(.failure(NetworkError.somethingWentWrong))
                    }
                } catch {
                        promise(.failure(NetworkError.somethingWentWrong))
                }
            })
        })
        
    }
    
}
