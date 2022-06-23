//
//  NetworkService.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 23.05.22.
//

import Foundation
import CoreLocation

protocol NetworkServiceProtocol {
    func getWeatherResponce(for coordinates: CLLocationCoordinate2D, completion: @escaping ((WeatherResponce?) -> Void))
}

final class NetworkService: NSObject, CLLocationManagerDelegate, NetworkServiceProtocol {
    
    func getWeatherResponce(for coordinates: CLLocationCoordinate2D, completion: @escaping ((WeatherResponce?) -> Void)) {
        let params: [URLQueryItem] = [URLQueryItem(name: "lat", value: String(coordinates.latitude)),
                                      URLQueryItem(name: "lon", value: String(coordinates.longitude)),
                                      URLQueryItem(name: "exclude", value: "minutely"),
                                      URLQueryItem(name: "units", value: "metric"),
                                      URLQueryItem(name: "appid", value: "8f2c2a9856f6696c61f99b0dba6a1fe7")]
        var url = URLComponents(string: "https://api.openweathermap.org/data/2.5/onecall")
        url?.queryItems = params
        guard let url = url?.url else { return }
        let weatherRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: weatherRequest) { data, response, error in
            guard let data = data, error == nil else {
                print("\(error?.localizedDescription ?? "error")")
                return
            }
            
            do {
                if let result = try? JSONDecoder().decode(WeatherResponce.self, from: data) {
                    completion(result)
                } else {
                    completion(nil)
                }
            }
        }.resume()
    }
}

