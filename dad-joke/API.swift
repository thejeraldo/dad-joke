//
//  API.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import Foundation
import Alamofire

protocol APIProtocol: URLRequestConvertible {
  var url: URL { get }
  var path: String { get }
  var method: HTTPMethod { get }
  var headers: HTTPHeaders { get }
  var parameters: Parameters { get }
  
  func asURLRequest() throws -> URLRequest
}

extension APIProtocol {
  
  var url: URL { URL(string: "https://icanhazdadjoke.com")! }
  
  var path: String { return "" }
  
  var method: HTTPMethod { return .get }
  
  var headers: HTTPHeaders {
    var headers = HTTPHeaders()
    headers.add(HTTPHeader.accept("application/json"))
    headers.add(HTTPHeader.userAgent("Dad Jokes (https://github.com/thejeraldo)"))
    return headers
  }
  
  var parameters: Parameters { [:] }
  
  func asURLRequest() throws -> URLRequest {
    var url = self.url
    url.appendPathComponent(self.path)
    var req = URLRequest(url: url)
    req.httpMethod = self.method.rawValue
    req.allHTTPHeaderFields = self.headers.dictionary
    req = try URLEncoding.default.encode(req, with: self.parameters)
    return req
  }
}

enum API: APIProtocol {
  case random
}
