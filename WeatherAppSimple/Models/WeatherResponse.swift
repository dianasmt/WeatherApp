//
//  WeatherResponse.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 21.05.22.
//

import Foundation

struct WeatherResponce: Codable {
    
    var timezone: String?
    var current: Current?
    var hourly: [Current]?
    var daily: [Daily]?
}

// MARK: - Current

struct Current: Codable {
    
    var dt: Double?
    var temp: Double?
    var weather: [Weather]?
}

// MARK: - Weather

struct Weather: Codable {
    
    var description: String?
    var icon: String?
}

// MARK: - Daily

struct Daily: Codable {
    
    var dt: Double?
    var temp: Temp?
    var weather: [Weather]?
    
}

// MARK: - Temp

struct Temp: Codable {
    
    var max: Double?
    var min: Double?
    
}
