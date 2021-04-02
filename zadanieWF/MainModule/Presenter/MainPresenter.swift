//
//  MainPresenter.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 31.03.2021.
//

import Foundation
import CoreLocation

struct WeatherStartScreen {
    let name: String
    let lat: String
    let lon: String
}

protocol MainViewProtocol: class {
    func succesStartScreen()
    func succesCityWeather()
    func failure()
}

protocol MainPresenterProtocol: class {
    func getWeatherStartScreen()
    func getWeatherFromSerachBar(params: [String : String])
    func getCityCoordinates(from address: String, completion: @escaping (_ location: CLPlacemark?) -> ())
    var weatherList: [WeatherModelResponse] { get set }
    var searchCountryWeather: [WeatherModelResponse] { get set }
    init(view: MainViewProtocol, networkService: NetworkingProtocol)
}

class MainPresenter: MainPresenterProtocol {

    weak var view: MainViewProtocol?
    let networkService: NetworkingProtocol!
    var weatherList = [WeatherModelResponse]()
    var searchCountryWeather = [WeatherModelResponse]()

    private var weatherStartScreen = [WeatherStartScreen(name: "Москва", lat: "55.803257", lon: "37.791148"), WeatherStartScreen(name: "Самара", lat: "53.2006658", lon: "50.1901464"), WeatherStartScreen(name: "Омск", lat: "54.9897924", lon: "73.3743395"), WeatherStartScreen(name: "Ростов", lat: "57.1865303", lon: "39.4245226"), WeatherStartScreen(name: "Пермь", lat: "58.0116897", lon: "56.2322009"), WeatherStartScreen(name: "Пенза", lat: "53.201018", lon: "45.0112849"), WeatherStartScreen(name: "Алтай", lat: "47.8383438", lon: "88.121441"), WeatherStartScreen(name: "Челабяинск", lat: "55.1600386", lon: "61.4005107"), WeatherStartScreen(name: "Томск", lat: "56.4864376", lon: "84.9464296"), WeatherStartScreen(name: "Хабаровск", lat: "48.4808244", lon: "135.0729802")]
    
    required init(view: MainViewProtocol, networkService: NetworkingProtocol) {
        self.view = view
        self.networkService = networkService
    }
    
    func getWeatherStartScreen() {
        let network = NetworkDataFetcher.init(networking: networkService)
        
        for item in self.weatherStartScreen {
            let params = ["lat": item.lat,
                          "lon": item.lon]
            
            network.getWeather(params: params) { [weak self] result in
                guard let self = self else { return }
                guard let result = result else { return }
                self.weatherList.append(result)
                self.view?.succesStartScreen()
            }
        }
    }
    
    func getWeatherFromSerachBar(params: [String : String]) {
        let network = NetworkDataFetcher.init(networking: networkService)
        
        network.getWeather(params: params) { [weak self] result in
            guard let self = self else { return }
            guard let result = result else { return }
            self.searchCountryWeather.append(result)
            self.view?.succesCityWeather()
        }
    }
    
    func getCityCoordinates(from address: String, completion: @escaping (_ location: CLPlacemark?) -> ()) {
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {
            placemarks, error in
            guard let placemarks = placemarks else { completion(nil)
                return }
            let placemark = placemarks.first
            completion(placemark)
        }
    }
}
