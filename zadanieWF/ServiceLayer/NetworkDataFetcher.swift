//
//  NetworkDataFetcher.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import Foundation

protocol DataFetcherProtocol {
    func getWeather(params: [String : String], completion: @escaping (WeatherModelResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcherProtocol {
    
    private let networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func getWeather(params: [String : String] ,completion: @escaping (WeatherModelResponse?) -> Void) {
        
        networking.request(path: Api.path, params: params) { result in
            
            switch result {
            case .success(let data):
                let decoded = self.decodeJson(type: WeatherModelResponse.self, from: data)
                completion(decoded)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    private func decodeJson<T: Decodable>(type: T.Type, from: Data?) -> T? {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        guard let data = from , let result = try? decoder.decode(type.self, from: data) else { return nil }
        return result
    }
}
