//
//  MainViewCell.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 01.04.2021.
//

import UIKit

class MainViewCell: UITableViewCell {
    
    static let privateIdentifier = "MainViewCell"
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(weatherModel: WeatherModelResponse) {
        cityNameLabel.text = weatherModel.geoObject.locality.name
        tempLabel.text = String(weatherModel.fact.temp) + "C"
        conditionLabel.text = weatherModel.fact.condition
    }
}
