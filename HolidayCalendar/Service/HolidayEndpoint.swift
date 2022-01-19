//
//  HolidayEndpoint.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/18/22.
//

import Foundation

enum HolidayEndpoint {
    case holiday(country: String)
}

let year = "2022"
let apiKey = "b9adba4c0395ebdaa4bf7c865d72f0674f409e9e"
//https://calendarific.com/api/v2/holidays?&api_key=b9adba4c0395ebdaa4bf7c865d72f0674f409e9e&country=US&year=2022
extension HolidayEndpoint: EndpointProtocol {
    var baseURL: String {
        return "https://calendarific.com"
    }
    
    var path: String {
        return "/api/v2/holidays"
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .holiday(let country):
            return [URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "year", value: year)]
        }
        

    }
    
    var request: URLRequest? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        urlComponents?.queryItems = parameters
        
        if let urlString = urlComponents?.url {
            var request = URLRequest(url: urlString)
            request.httpMethod = httpMethod.rawValue
            request.allHTTPHeaderFields = httpHeader
            return request
        }
        return nil
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var httpHeader: [String : String] {
        return ["Content-Type":"application/json"]
    }
    
    
}
