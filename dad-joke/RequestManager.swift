//
//  RequestManager.swift
//  dad-joke
//
//  Created by jerald on 7/9/20.
//

import Foundation
import Alamofire
import Combine

protocol RequestManagerProtocol {
  static func request<T: Codable>(api: APIProtocol & URLRequestConvertible, resultType: T.Type)
  -> AnyPublisher<T, AFError>
}

struct RequestManager {
  static func request<T: Codable>(api: APIProtocol & URLRequestConvertible, resultType: T.Type)
  -> AnyPublisher<T, AFError> {
    let publisher = AF.request(api)
      .publishDecodable(type: resultType)
    return publisher.value()
  }
}
