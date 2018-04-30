//
//  ManufacturerRestAPI.swift
//  Cartalogue
//
//  Created by Caio de Souza on 25/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import UIKit

enum ManufacturerPaths : String{
    case mainTypes = "v1/car-types/main-types"
    case manufacturer = "v1/car-types/manufacturer"
}

class ManufacturerRestAPI: ManufacturerStoreProtocol {

    
    var apiClient : ApiClient!
    
    init() {
        self.apiClient = ApiClientImplementation(urlSessionConfiguration: URLSessionConfiguration.default, completionHandlerQueue: OperationQueue.main)
    }
    
    init(client: ApiClient) {
        self.apiClient = client
    }
    
    func fetchManufacturers(parameters: ListManufacturers.ListManufacturerParameters,
                     completionHandler: @escaping ManufacturerStoreFetchManufacturerAPIManufacturerCompletionHandler) {
        let params : [String: Any?] = ["page" : parameters.page,
                                       "pageSize" : parameters.pageSize]
        
        apiClient.execute(request: DefaultApiRequest(path: ManufacturerPaths.manufacturer.rawValue, parameters: params)) { (result: Result<ApiResponse<APIManufacturer>>) in
            switch result {
            case let .success(response):
                completionHandler(.success(response.entity))
            case let .failure(error):
                completionHandler(.failure(error))
            }
            
        }
    }
    
    func fetchMainTypes(parameters: MainTypes.MainTypesParameters, completionHandler: @escaping ManufacturerStoreFetchManufacturerAPIManufacturerCompletionHandler) {
        let params : [String: Any?] = ["page" : parameters.page,
                                       "pageSize" : parameters.pageSize,
                                       "manufacturer" : parameters.manufacturerID]
        apiClient.execute(request: DefaultApiRequest(path: ManufacturerPaths.mainTypes.rawValue,
                                                     parameters: params)) { (result: Result<ApiResponse<APIManufacturer>>) in
          switch result{
          case let .success(response):
            completionHandler(.success(response.entity))
          case let .failure(error):
            completionHandler(.failure(error))
          }
        }
    }
    
    
    
    

}
