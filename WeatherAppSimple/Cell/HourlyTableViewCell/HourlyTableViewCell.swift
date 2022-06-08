//
//  HourlyTableViewCell.swift
//  WeatherAppSimple
//
//  Created by Диана Смахтина on 20.05.22.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var models = [Current]()

    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(WeatherCollectionViewCell.nib(), forCellWithReuseIdentifier: "\(WeatherCollectionViewCell.self)")
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    
    static let identifier = "\(HourlyTableViewCell.self)"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(HourlyTableViewCell.self)", bundle: nil)
    }
    
    func configure(with models: [Current]) {
        self.models = models
        collectionView.reloadData()
    }
}

extension HourlyTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(WeatherCollectionViewCell.self)", for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: models[indexPath.row])
        collectionView.backgroundColor = .clear
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.0, height: 130.0)
    }
    
}
