//
//  EndpointProtocol.swift
//  HolidayCalendar
//
//  Created by mai nguyen on 1/18/22.
//

import Foundation


enum HTTPMethod: String {
    case get = "GET"
}

protocol EndpointProtocol {
    var baseURL: String {get}
    var path: String {get}
    var parameters: [URLQueryItem] {get}
    var request: URLRequest? {get}
    var httpMethod: HTTPMethod {get}
    var httpHeader: [String: String] {get}





}
