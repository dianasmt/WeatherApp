//
//  WeatherViewModel.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 26.05.22.
//

import Foundation
import UIKit

protocol WeatherViewModelProtocol: UITableViewDelegate, UITableViewDataSource {
    var didContentChanged: (() -> Void)? { get set }
    var dedRecieveWeather: ((WeatherResponce) -> Void)? { get set }
    func requestWeatherForLocation()
}

final class WeatherViewModel: NSObject, WeatherViewModelProtocol {
    
    var didContentChanged: (() -> Void)?
    var dedRecieveWeather: ((WeatherResponce) -> Void)?
    
    private lazy var networkService: NetworkServiceProtocol = NetworkService()
    private lazy var locationService: LoacationManagerProtocol = LocationManager()
    
    private var weatherResponse: WeatherResponce?
        
    func requestWeatherForLocation() {
        guard let coordinates = locationService.getLocation() else { return }
        networkService.getWeatherResponce(for: coordinates) { [weak self] weatherResponse in
            guard let responseModel = weatherResponse else { return }
            self?.dedRecieveWeather?(responseModel)
            self?.weatherResponse = weatherResponse
        }
    }
}

extension WeatherViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let response = weatherResponse, let dailyResponse = response.daily else { return 0}
        
        if section == 0 {
            return 1
        }
        return dailyResponse.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let response = weatherResponse, let dailyResponse = response.daily, let hourlyResponse = response.hourly else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: HourlyTableViewCell.identifier, for: indexPath) as? HourlyTableViewCell else { return UITableViewCell() }
            cell.configure(with: hourlyResponse)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DailyTableViewCell.identifier, for: indexPath) as? DailyTableViewCell else { return UITableViewCell() }
        
        cell.configure(with: dailyResponse[indexPath.row] )
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
