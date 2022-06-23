//
//  DailyTableViewCell.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 16.05.22.
//

import UIKit

final class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var highTemperatureLabel: UILabel!
    @IBOutlet var lowTemperatureLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    static let identifier = "\(DailyTableViewCell.self)"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(DailyTableViewCell.self)", bundle: nil)
    }
    
    func configure(with model: Daily) {
        self.lowTemperatureLabel.textAlignment = .center
        self.highTemperatureLabel.textAlignment = .center
        self.iconImageView.contentMode = .scaleAspectFit
        
        self.lowTemperatureLabel.text = "\(Int(model.temp?.min ?? 0))°"
        self.highTemperatureLabel.text = "\(Int(model.temp?.max ?? 0))°"
        self.dayLabel.text = getDayForDate(Date(timeIntervalSince1970: model.dt ?? 0))

        model.weather?.forEach({ weather in
            guard let icon = weather.description?.lowercased() else { return }
            
            if (icon.contains("light rain")) {
                self.iconImageView.image = UIImage(named: "light rain")
            } else if (icon.contains("rain")) {
                self.iconImageView.image = UIImage(named: "rain")
            } else if (icon.contains("clear")) {
                self.iconImageView.image = UIImage(named: "sun")
            } else {
                self.iconImageView.image = UIImage(named: "cloudy")
            }
        })
    }
    
    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else { return ""}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM EEEE"
        return formatter.string(from: inputDate)
    }
}
