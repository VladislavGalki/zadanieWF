//
//  WeatherModel.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import Foundation

struct WeatherModelResponse: Decodable {
    let fact: FactModel
    let geoObject: GeoObject
    
    enum CodinKeys: String, CodingKey {
        case geoObject = "geo_object"
    }
}

struct FactModel: Decodable {
    let temp: Int
    let condition: String
}

struct GeoObject: Decodable {
    let locality: Locality
}

struct Locality: Decodable {
    let id: Int
    let name: String
}
