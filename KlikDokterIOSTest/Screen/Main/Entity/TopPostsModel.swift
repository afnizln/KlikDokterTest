//
//  TopPostsModel.swift
//  KlikDokterIOSTest
//
//  Created by Afni Laili on 01/10/23.
//

import Foundation
import SwiftyJSON

struct TopPostsModel {
    var data: [Response] = []
    
    struct Response {
        var title: String
        var body: String
        
        init(_ json: JSON) {
            title = json["title"].stringValue
            body = json["body"].stringValue
        }
    }
    
    init(_ json: JSON) {
        for response in json.arrayValue {
            data.append(Response(response))
        }
    }
    
}
