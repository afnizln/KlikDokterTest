//
//  TopPhotosModel.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 02/10/23.
//

import Foundation
import SwiftyJSON

struct TopPhotosModel {
    var data: [Response] = []
    
    struct Response {
        var title: String
        var imageUrl: String
        
        init(_ json: JSON) {
            title = json["title"].stringValue
            imageUrl = json["url"].stringValue
        }
    }
    
    init(_ json: JSON) {
        for response in json.arrayValue {
            data.append(Response(response))
        }
    }
    
}
