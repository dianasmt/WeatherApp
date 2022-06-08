//
//  WeatherCollectionViewCell.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 20.05.22.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    
    static let identifier  = "\(WeatherCollectionViewCell.self)"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(WeatherCollectionViewCell.self)", bundle: nil)
    }

    @IBOutlet private weak var iconImageView: UIImageView!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    func configure(with model: Current) {
        self.tempLabel.text = "\(Int(model.temp ?? 0))°"
        self.timeLabel.text = getDayForDate(Date(timeIntervalSince1970: model.dt ?? 0))
        self.iconImageView.contentMode = .scaleAspectFit
        
        model.weather?.forEach({ weather in
            let icon = weather.description?.lowercased()
            if (icon!.contains("light rain")) {
                self.iconImageView.image = UIImage(named: "light rain")
            } else if (icon!.contains("clear")) {
                self.iconImageView.image = UIImage(named: "sun")
            }  else if (icon!.contains("rain")) {
                self.iconImageView.image = UIImage(named: "rain")
            }else {
                self.iconImageView.image = UIImage(named: "cloudy")
            }
        })
    }

    func getDayForDate(_ date: Date?) -> String {
        guard let inputDate = date else { return ""}
        
        let formatter = DateFormatter()
        formatter.dateFormat = "H"
        return formatter.string(from: inputDate)
    }
}
