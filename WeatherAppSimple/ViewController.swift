//
//  ViewController.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 6.04.22.
//

import UIKit
import CoreLocation

class ViewController: UIViewController{
    
    private var viewModel: WeatherViewModelProtocol = WeatherViewModel()
    
    @IBOutlet private weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(HourlyTableViewCell.nib(), forCellReuseIdentifier: HourlyTableViewCell.identifier)
        tableView.register(DailyTableViewCell.nib(), forCellReuseIdentifier: DailyTableViewCell.identifier)
        tableView.delegate = viewModel
        tableView.dataSource = viewModel
        viewModel.didContentChanged = {
            self.tableView.reloadData()
        }
        viewModel.requestWeatherForLocation()
        bindViewModel()
        setUpColor()
    }
    
    private func bindViewModel() {
        viewModel.dedRecieveWeather = { [weak self] weatherModel in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.tableHeaderView = self.createTableHeader(weatherModel: weatherModel)
                self.tableView.reloadData()
            }
        }
    }
    
    private func setUpColor() {
        view.backgroundColor = UIColor(red: 58.00 / 255.00, green: 50.00 / 255.00, blue: 1.00, alpha: 1.0)
        tableView.backgroundColor = .clear
    }
    
    private func createTableHeader(weatherModel: WeatherResponce) -> UIView {
        let headerView = UIView(frame: CGRect(x: 0.0, y: 0.0,
                                              width: view.frame.size.width,
                                              height: view.frame.size.height / 4))
        
        
        let locationLabel = UILabel(frame: CGRect(x: 10.0, y: 10.0,
                                                  width: view.frame.size.width - 20.0,
                                                  height: headerView.frame.size.height / 5))
        let iconView = UIImageView(frame: CGRect(x: view.frame.width / 2 - 25, y: 10.0 + locationLabel.frame.height,
                                                 width: 50.0,
                                                 height: 50.0))
        let temperatureLabel = UILabel(frame: CGRect(x: 10.0, y: 20.0 + locationLabel.frame.size.height + 30,
                                                     width: view.frame.size.width - 20.0,
                                                     height: headerView.frame.size.height / 2))
        headerView.addSubview(locationLabel)
        headerView.addSubview(iconView)
        headerView.addSubview(temperatureLabel)
        
        locationLabel.textAlignment = .center
        temperatureLabel.textAlignment = .center
        
        temperatureLabel.font = UIFont(name: "Helvetica-Bold", size: 32)
        iconView.image = UIImage(named: "sun")
        
        if let currentWeather = weatherModel.current, let currentWeatherTemp = currentWeather.temp {
            locationLabel.text = weatherModel.timezone
            if let iconImageName = currentWeather.weather?.description {
                iconView.image = UIImage(named: iconChoose(with: iconImageName))
                temperatureLabel.text = "\(Int(currentWeatherTemp))°"
            }
        }
        return headerView
    }
    
    private func iconChoose(with description: String) -> String {
        if (description.contains("light rain")) {
            return "light rain"
        } else if (description.contains("rain")) {
            return "rain"
        } else if (description.contains("clear")) {
            return "sun"
        } else {
            return "cloudy"
        }
    }
    
}
