//
//  JSONParser.swift
//  KlikDokterIOSTestTests
//
//  Created by Afni Laili on 02/10/23.
//

import SwiftyJSON

class JSONParser {
    static let shared = JSONParser()
    
    func fetchJSON(jsonFileName fileName: String) -> JSON {
        let fileUrl = getJSONFileUrl(of: fileName)
        let data = try! Data(contentsOf: fileUrl)
        return try! JSON(data: data)
    }
    
    private func getJSONFileUrl(of fileName: String) -> URL {
        let bundle = Bundle(for: type(of: self))
        return bundle.url(forResource: fileName, withExtension: "json")!
    }
}
