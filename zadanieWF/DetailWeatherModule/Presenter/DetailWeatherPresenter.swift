//
//  DetailWeatherPresenter.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import Foundation

protocol DetailViewPresenterProtocol: class{
    func setWeather(weather: WeatherModelResponse?)
}

protocol DetailPresenterProtocol: class {
    func setWeather()
    init(view: DetailViewPresenterProtocol, weather: WeatherModelResponse?)
}

class DetailWeatherPresenter: DetailPresenterProtocol {

    weak var view: DetailViewPresenterProtocol?
    var weather: WeatherModelResponse?
    
    required init(view: DetailViewPresenterProtocol, weather: WeatherModelResponse?) {
        self.view = view
        self.weather = weather
    }
    
    func setWeather() {
        self.view?.setWeather(weather: weather)
    }
}
