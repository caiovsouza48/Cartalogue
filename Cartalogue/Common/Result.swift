//
//  File.swift
//  Cartalogue
//
//  Created by Caio de Souza on 26/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
