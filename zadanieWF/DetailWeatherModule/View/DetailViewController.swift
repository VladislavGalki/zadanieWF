//
//  DetailViewController.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    
    var presenter: DetailPresenterProtocol!
    var weather: WeatherModelResponse?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setWeather()
    }
}

extension DetailViewController: DetailViewPresenterProtocol {
    func setWeather(weather: WeatherModelResponse?) {
        nameLabel.text = weather?.geoObject.locality.name
        tempLabel.text = String((weather?.fact.temp)!) + "C"
    }
}
