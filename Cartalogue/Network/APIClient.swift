//
//  APIClient.swift
//  Cartalogue
//
//  Created by Caio de Souza on 26/04/2018.
//  Copyright © 2018 Caio de Souza. All rights reserved.
//

import Foundation

// From Clean Architecture MVP

// All entities that model the API responses can implement this so we can handle all responses in a generic way
protocol InitializableWithData {
    init(data: Data?) throws
}

protocol InitializableWithJson {
    init(json: [String: Any]) throws
}


// Can be thrown by InitializableWithData.init(data: Data?) implementations when parsing the data
struct ApiParseError: Error {
    static let code = 999
    
    let error: Error
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    var localizedDescription: String {
        return error.localizedDescription
    }
}

extension Array: InitializableWithData {
    init(data: Data?) throws {
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let jsonArray = jsonObject as? [[String: Any]] else {
                throw NSError.createPraseError()
        }
        
        guard let element = Element.self as? InitializableWithJson.Type else {
            throw NSError.createPraseError()
        }
        
        self = try jsonArray.map( { return try element.init(json: $0) as! Element } )
    }
}

extension NSError {
    static func createPraseError() -> NSError {
        return NSError(domain: "com.cartalogue.APIClient",
                       code: ApiParseError.code,
                       userInfo: [NSLocalizedDescriptionKey: "A parsing error occured"])
    }
}

// This wraps a successful API response and it includes the generic data as well
// The reason why we need this wrapper is that we want to pass to the client the status code and the raw response as well
struct ApiResponse<T: InitializableWithData> {
    let entity: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        do {
            self.entity = try T(data: data)
            self.httpUrlResponse = httpUrlResponse
            self.data = data
        } catch {
            throw ApiParseError(error: error, httpUrlResponse: httpUrlResponse, data: data)
        }
    }
}

protocol ApiRequest {
    var urlRequest: URLRequest { get }
}

struct DefaultApiRequest : ApiRequest{
    let infoDictionary = Bundle.main.infoDictionary!
    let path: String
    var urlRequest: URLRequest{
        get{
            let stringBaseURL = infoDictionary["APP_API_BASE_URL_ENDPOINT"] as! String
            var urlParams = ""
            if let _parameters = parameters{
                urlParams = _parameters.compactMap({ (key, value) -> String in
                    return "\(key)=\(value ?? "")"
                }).joined(separator: "&")
            }
           
            let urlQueryString = "\(stringBaseURL)/\(path)?\(urlParams)"
            
            let url: URL! = URL(string: urlQueryString)
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            
            return request
        }
    }
    var parameters : [String: Any?]?
    
    init(path: String, parameters : [String: Any?]?) {
        self.path = path
        let infoDictionary = Bundle.main.infoDictionary!
        self.parameters = [:]
        self.parameters!.updateValue(infoDictionary["APP_API_BASE_KEY"] as! String, forKey: "wa_key")
        if let _parameters = parameters{
            self.parameters!.merge(_parameters) { $1 }
        }
    }
    
}

protocol ApiClient {
    func execute<T: InitializableWithData>(request: ApiRequest, completionHandler: @escaping (_ result: Result<ApiResponse<T>>) -> Void)
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

// MARK: Error Handler

// Can be thrown when we can't even reach the API
struct NetworkRequestError: Error {
    let error: Error?
    
    var localizedDescription: String {
        return error?.localizedDescription ?? "Network Error - Check your Internet and Try Again"
    }
}

// Can be thrown when we reach the API but the it returns a 4xx or a 5xx
struct ApiError: Error {
    let data: Data?
    let httpUrlResponse: HTTPURLResponse
}

extension URLSession: URLSessionProtocol { }

// MARK: Implementation
class ApiClientImplementation: ApiClient {
    let urlSession: URLSessionProtocol
    
    init(urlSessionConfiguration: URLSessionConfiguration, completionHandlerQueue: OperationQueue) {
        urlSession = URLSession(configuration: urlSessionConfiguration, delegate: nil, delegateQueue: completionHandlerQueue)
    }
    
    // This should be used mainly for testing purposes
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }
    
    // MARK: - ApiClient
    
    func execute<T: InitializableWithData>(request: ApiRequest, completionHandler: @escaping (Result<ApiResponse<T>>) -> Void) {
        let dataTask = urlSession.dataTask(with: request.urlRequest) { (data, response, error) in
            guard let httpUrlResponse = response as? HTTPURLResponse else {
                completionHandler(.failure(NetworkRequestError(error: error)))
                return
            }
            
            let successRange = 200...299
            if successRange.contains(httpUrlResponse.statusCode) {
                do {
                    let response = try ApiResponse<T>(data: data, httpUrlResponse: httpUrlResponse)
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(error))
                }
            } else {
                completionHandler(.failure(ApiError(data: data, httpUrlResponse: httpUrlResponse)))
            }
        }
        dataTask.resume()
    }
}
