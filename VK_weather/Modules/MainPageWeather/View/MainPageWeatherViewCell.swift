//
//  MainPageWeatherViewCell.swift
//  VK_weather
//
//  Created by Егор Иванов on 21.03.2024.
//

import UIKit


final class MainPageWeatherViewCell: UICollectionViewCell {
    
    // MARK: - private properties
    private enum Const {
        static let heightImage: CGFloat = 60
        static let widthImage: CGFloat = 60
        static let leadingOrTrailingConst: CGFloat = 40
    }
    
    private let  collectionTemperature: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    private let  collectionDate: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    private let collectionImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        viewSetup()
        layoutObjects()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private properties
    private func viewSetup() {
        [collectionTemperature,
         collectionDate,
         collectionImage
        ].forEach { element in
            contentView.addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func layoutObjects() {
        NSLayoutConstraint.activate([
            collectionDate.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Const.leadingOrTrailingConst),
            collectionDate.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            collectionDate.trailingAnchor.constraint(equalTo: collectionImage.leadingAnchor),
            
            
            collectionTemperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Const.leadingOrTrailingConst),
            collectionTemperature.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            collectionTemperature.leadingAnchor.constraint(equalTo: collectionImage.trailingAnchor),
            
            collectionImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            collectionImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            collectionImage.widthAnchor.constraint(equalToConstant: Const.widthImage),
            collectionImage.heightAnchor.constraint(equalToConstant: Const.heightImage)
        ])
    }
}

// MARK: - extension for info
extension MainPageWeatherViewCell {
    func updateInfo(description: MainPageWeatherForeCastResponse.Weather) {
        guard let weatherInfo = description.weather.first else { return }
        guard let temperature = description.main.temp else { return }
        
        let date = Date(timeIntervalSince1970: description.dt)
        let hourString = dataFormatter.string(from: date)
        
        collectionDate.text = hourString
        collectionTemperature.text = "\(temperature)°C"
        collectionImage.image = UIImage(named: weatherInfo.icon ?? "")
    }
}
