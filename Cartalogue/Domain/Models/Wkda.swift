//
//  Wkda.swift
//  Cartalogue
//
//  Created by Caio de Souza on 23/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import UIKit

struct Wkda : InitializableWithData, InitializableWithJson, CustomStringConvertible{
    
    var id: String
    var name: String
    
    var description: String{
        return "***** Wdka Object ****\n • ID: \(id)\n • Name: \(name)"
    }
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
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
        guard let id = json["id"] as? String,
            let name = json["name"] as? String else{
                throw NSError.createPraseError()
        }
        self.id = id
        self.name = name
    }
}

extension Wkda: Equatable {
    public static func == (lhs: Wkda, rhs: Wkda) -> Bool {
        return lhs.id == rhs.id &&
               lhs.name == rhs.name
    }
}

