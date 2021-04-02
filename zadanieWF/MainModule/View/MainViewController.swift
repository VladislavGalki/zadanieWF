//
//  MainView.swift
//  zadanieWF
//
//  Created by Владислав Галкин on 31.03.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MainPresenterProtocol!
    var startScreen: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: MainViewCell.privateIdentifier.self, bundle: nil), forCellReuseIdentifier: MainViewCell.privateIdentifier)
        tableView.separatorStyle = .none
        searchBar.delegate = self
        presenter.getWeatherStartScreen()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if startScreen {
            return presenter.weatherList.count
        }else{
            return presenter.searchCountryWeather.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainViewCell.privateIdentifier, for: indexPath) as? MainViewCell else { return UITableViewCell() }
        if startScreen {
            let cityWeatherList = presenter.weatherList[indexPath.row]
            cell.configure(weatherModel: cityWeatherList)
        }else{
            let cityWeatherSearch = presenter.searchCountryWeather[indexPath.row]
            cell.configure(weatherModel: cityWeatherSearch)
        }
        return cell
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var weather: WeatherModelResponse?
        if startScreen {
            weather = presenter.weatherList[indexPath.row]
        }else {
            weather = presenter.searchCountryWeather[indexPath.row]
            
        }
        let detailVC = ModuleBuilder.creatDetailModule(weather: weather)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        presenter.getCityCoordinates(from: searchBar.text!) { placemark in
            guard let placemark = placemark else { return }
            var params: [String:String]
            params = ["lat": String((placemark.location?.coordinate.latitude)!),
                      "lon":  String((placemark.location?.coordinate.longitude)!)]
            self.presenter.getWeatherFromSerachBar(params: params)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.startScreen = true
            self.presenter.searchCountryWeather.removeAll()
            self.tableView.reloadData()
            return
        }
    }
}

extension MainViewController: MainViewProtocol {
    
    func succesStartScreen() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func succesCityWeather() {
        DispatchQueue.main.async {
            self.startScreen = false
            self.tableView.reloadData()
        }
    }
    
    func failure() {
        print(Error.self)
    }
}

