//
//  APIService.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/18/22.
//

import Foundation

typealias NetworkCompletion = (_ data: Data?, _ errorMessage: String?) -> Void

enum NetworkError: String {
    case authError
    case jsonError
    case unknown
}

enum Result {
    case success
    case failure(message: String)
}

class APIService {
    var task: URLSessionDataTask?
    
    func createRequest(client: EndpointProtocol, completion: @escaping NetworkCompletion) {
        guard let request = client.request else {
            return
        }
        print(request.url)
        let config = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: config)
        
        task = urlSession.dataTask(with: request, completionHandler: { data, response, error in
            if error != nil {return }
            
            guard let response = response as? HTTPURLResponse else {
                return
            }
            
            let result = self.checkResponse(httpUrlResponse:response )
            switch result {
            case .success: if let data = data {
                completion(data,nil)
            }
            case .failure(let message):
                completion(nil,message)
                return
            }
            
        })
        task?.resume()
    }
    
    func checkResponse(httpUrlResponse:HTTPURLResponse ) -> Result {
        switch httpUrlResponse.statusCode {
            case 200...299: return .success
        default: return .failure(message: "Ooop! Something went wrong")
        }
    }
    
    func fetchData<T: Decodable>(client: EndpointProtocol, completion: @escaping (T?) -> ()) {
        self.createRequest(client: client) { data, error in
            if data != nil , error == nil {
                let jsonDecoder = JSONDecoder()
                
                do {
                    let object = try jsonDecoder.decode(T.self, from: data!)
                    completion(object)
                } catch {
                    print(NetworkError.jsonError.rawValue)
                    
                }
            }
        }
    }
}
