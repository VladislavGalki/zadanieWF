//
//  NetworkService.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import Foundation

protocol NetworkingProtocol: class {
    func request (path: String, params: [String : String], completion: @escaping (Result<Data?, Error>) -> Void)
}

struct Api {
    static let scheme = "https"
    static let host = "api.weather.yandex.ru"
    static let path = "/v2/forecast"
}

class NetworkService: NetworkingProtocol {
    func request(path: String, params: [String : String], completion: @escaping (Result<Data?, Error>) -> Void) {

        let url = self.url(from: path, params: params)
        var request = URLRequest(url: url)
        request.setValue("0c5e66e2-e040-4219-9830-f2a2b60d080e", forHTTPHeaderField: "X-Yandex-API-Key")
        let task = createDataTask(from: request, completion: completion)
        task.resume()

    }
    
    private func createDataTask(from request: URLRequest ,completion: @escaping (Result<Data?, Error>) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error{
                completion(.failure(error))
            }
                completion(.success(data))
        }
    }
    
    private func url(from path: String, params: [String : String]) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = Api.scheme
        urlComponents.host = Api.host
        urlComponents.path = path
        
        urlComponents.queryItems = params.map{URLQueryItem(name: $0, value: $1)}
        return urlComponents.url!
    }
    
}
