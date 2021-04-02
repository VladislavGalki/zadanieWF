//
//  ModuleBuiler.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import Foundation
import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
    static func creatDetailModule(weather: WeatherModelResponse?) -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    static func creatDetailModule(weather: WeatherModelResponse?) -> UIViewController {
        let view = DetailViewController()
        let presenter = DetailWeatherPresenter(view: view, weather: weather)
        view.presenter = presenter
        return view
    }

}
