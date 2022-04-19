//
//  HomeRequest.swift
//  CatFact
//
//  Created by Taha on 18/04/2022.
//

import Foundation
import Alamofire

enum HomeRequest: Endpoint {

    case getFact

    var path: String {
        switch self {
        
        case .getFact:
            return "fact"
        }
    }
    
    var headers: HTTPHeaders {
        let headers = defaultHeaders
        return headers
    }

    var parameters: Parameters? {
        let param = defaultParams
        switch  self {
        case .getFact:
            break
        }

        return param
    }
    
    var method: HTTPMethod {
        switch self {

        case .getFact:
            return .get
            
        }
    }
}
