//
//  Manufacturer.swift
//  Cartalogue
//
//  Created by Caio de Souza on 26/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import Foundation

struct APIManufacturer : InitializableWithData, InitializableWithJson {
    var page: Int
    var pageSize: Int
    var totalPageCount: Int
    var wkdaArray : [Wkda] = []
    
    /// Test Purpose Only
    init() {
        self.page = 0
        self.pageSize = 0
        self.totalPageCount = 0
        self.wkdaArray = []
    }
    
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
                throw NSError.createPraseError()
        }
        
        try self.init(json: json)
    }
    
    init(json: [String : Any]) throws {
        guard let page = json["page"] as? Int,
              let pageSize = json["pageSize"] as? Int,
              let totalPageCount = json["totalPageCount"] as? Int,
              let wkdaDictionary = json["wkda"] as? [String:String] else{
            throw NSError.createPraseError()
        }
        self.page = page
        self.pageSize = pageSize
        self.totalPageCount = totalPageCount
        for item in wkdaDictionary{
            wkdaArray.append(Wkda(id: item.key, name: item.value))
        }
    }
    
}
