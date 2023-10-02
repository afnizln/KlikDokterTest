//
//  NetworkServiceMock.swift
//  KlikDokterIOSTestTests
//
//  Created by Afni Laili on 02/10/23.
//

import UIKit
import SwiftyJSON

@testable import KlikDokterIOSTest

class NetworkServiceMock: INetworkService {
    
    var isSuccess: Bool = true
    
    func fetch(url: String, completion: ((Result<SwiftyJSON.JSON, Error>) -> Void)?) {
        
        guard isSuccess else {
            completion?(.failure(MockError.justError))
            return
        }
        
        switch url {
        case MainURL.posts:
            let mockResponse = JSONParser.shared.fetchJSON(jsonFileName: "TopPostsDataMockResponse")
            completion?(.success(mockResponse))
        case MainURL.photos:
            let mockResponse = JSONParser.shared.fetchJSON(jsonFileName: "TopPhotosDataMockResponse")
            completion?(.success(mockResponse))
        default:
            break
        }
    }
}
