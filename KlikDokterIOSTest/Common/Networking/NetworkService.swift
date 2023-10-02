//
//  NetworkService.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 02/10/23.
//

import Foundation
import SwiftyJSON
import Alamofire

protocol INetworkService: AnyObject {
    func fetch(url: String, completion: ((Result<JSON, Error>) -> Void)?)
}

final class NetworkService: INetworkService {
    func fetch(url: String, completion: ((Result<JSON, Error>) -> Void)?) {
        AF.request(url).response { response in
            switch response.result {
            case .success(let result):
                let json = JSON(result)
                completion?(.success(json))
            case .failure(let error):
                completion?(.failure(error))
            }
        }
    }
}
