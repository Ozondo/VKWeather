//
//  MainPageWeatherView.swift
//  VK_weather
//
//  Created by Егор Иванов on 20.03.2024.
//

import UIKit

final class MainPageWeatherView: UIView {
    
    var isActivityIndicatorVisible: Bool = false {
        didSet {
            if isActivityIndicatorVisible {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.startAnimating()
            }
            activityIndicator.isHidden = !isActivityIndicatorVisible
        }
    }
    
    // MARK: - Constants
    private enum Const {
        static let topConstCircle: CGFloat = 40
        static let heightCircle: CGFloat = 200
        static let widthCircle: CGFloat = 200
        static let heightImage: CGFloat = 70
        static let widthImage: CGFloat = 70
        static let cornerRadiusCircle: CGFloat = 100
        static let cornerRadiusForCollection: CGFloat = 25
        static let countryBottomConst: CGFloat = -10
        static let labelsTopConst: CGFloat = 15
        static let leadingOrTrailingConst: CGFloat = 20
    }
    
    // MARK: - private properties
    private var listOfWeather: [MainPageWeatherForeCastResponse.Weather] = []
    
    private let gradientView = CAGradientLayer()
    
    private let circle: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let currentImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let currentTemperature: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Optima Regular", size: 50)
        return text
    }()
    
    private let  currentCountry: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    private let  currentWindStatusLabel: UILabel = {
        let text = UILabel()
        text.text = "Wind status💨"
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 14)
        return text
    }()
    
    private let  currentWindStatusValue: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    private let  currentHumidityLabel: UILabel = {
        let text = UILabel()
        text.text = "Humidity💧"
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 14)
        return text
    }()
    
    private let  currentHumidityValue: UILabel = {
        let text = UILabel()
        text.font = UIFont(name: "Optima Regular", size: 20)
        text.textAlignment = .center
        return text
    }()
    
    private let  currentVisabilityLabel: UILabel = {
        let text = UILabel()
        text.text = "Visability👀"
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 14)
        return text
    }()
    
    private let  currentVisabilityValue: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    private let  currentAirPressureLabel: UILabel = {
        let text = UILabel()
        text.text = "Air Pressure☁️"
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 14)
        return text
    }()
    
    private let  currentAirPressureValue: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    private let  labelForForecast: UILabel = {
        let text = UILabel()
        text.text = "Details"
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 14)
        return text
    }()
    
    private let weatherForDaysCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        activityIndicator.isHidden = true
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        collectionSetup()
        gradientSetup()
        viewSetup()
        layoutElements()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = bounds
        circle.layer.cornerRadius = Const.cornerRadiusCircle
        weatherForDaysCollection.layer.cornerRadius = Const.cornerRadiusForCollection
    }
    
    // MARK: - private methods
    
    private func collectionSetup() {
        weatherForDaysCollection.dataSource = self
        weatherForDaysCollection.delegate = self
        weatherForDaysCollection.register(MainPageWeatherViewCell.self, forCellWithReuseIdentifier: "id")
    }
    private func gradientSetup() {
        gradientView.colors = [UIColor.systemOrange.cgColor, UIColor.lightGray.cgColor]
        layer.addSublayer(gradientView)
    }
    private func viewSetup(){
        [circle,
         currentTemperature,
         currentImage,
         currentCountry,
         currentHumidityValue,
         currentVisabilityValue,
         currentWindStatusValue,
         currentAirPressureValue,
         currentHumidityLabel,
         currentVisabilityLabel,
         currentWindStatusLabel,
         currentAirPressureLabel,
         labelForForecast,
         weatherForDaysCollection,
         activityIndicator
        ].forEach { element in
            addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    private func layoutElements(){
        NSLayoutConstraint.activate([
            currentCountry.bottomAnchor.constraint(equalTo: circle.topAnchor, constant: Const.countryBottomConst),
            currentCountry.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            circle.centerXAnchor.constraint(equalTo: centerXAnchor),
            circle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Const.topConstCircle),
            circle.heightAnchor.constraint(equalToConstant: Const.heightCircle),
            circle.widthAnchor.constraint(equalToConstant: Const.widthCircle),
            
            currentImage.topAnchor.constraint(equalTo: circle.topAnchor),
            currentImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentImage.heightAnchor.constraint(equalToConstant: Const.heightImage),
            currentImage.widthAnchor.constraint(equalToConstant: Const.widthImage),
            
            currentTemperature.centerXAnchor.constraint(equalTo: centerXAnchor),
            currentTemperature.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            currentTemperature.widthAnchor.constraint(lessThanOrEqualTo: circle.widthAnchor),
            
            currentWindStatusLabel.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: Const.labelsTopConst),
            currentWindStatusLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            currentWindStatusLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            
            currentWindStatusValue.topAnchor.constraint(equalTo: currentWindStatusLabel.bottomAnchor),
            currentWindStatusValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            currentWindStatusValue.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            currentVisabilityLabel.topAnchor.constraint(equalTo: circle.bottomAnchor, constant: Const.labelsTopConst),
            currentVisabilityLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            currentVisabilityLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            
            currentVisabilityValue.topAnchor.constraint(equalTo: currentVisabilityLabel.bottomAnchor),
            currentVisabilityValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            currentVisabilityValue.leadingAnchor.constraint(equalTo: centerXAnchor),
            
            
            currentHumidityLabel.topAnchor.constraint(equalTo: currentWindStatusValue.bottomAnchor, constant: Const.labelsTopConst),
            currentHumidityLabel.trailingAnchor.constraint(equalTo: centerXAnchor),
            currentHumidityLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            
            currentHumidityValue.topAnchor.constraint(equalTo: currentHumidityLabel.bottomAnchor),
            currentHumidityValue.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            currentHumidityValue.trailingAnchor.constraint(equalTo: centerXAnchor),
            
            currentAirPressureLabel.topAnchor.constraint(equalTo: currentVisabilityValue.bottomAnchor, constant: Const.labelsTopConst),
            currentAirPressureLabel.leadingAnchor.constraint(equalTo: centerXAnchor),
            currentAirPressureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            
            currentAirPressureValue.topAnchor.constraint(equalTo: currentAirPressureLabel.bottomAnchor),
            
            currentAirPressureValue.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            currentAirPressureValue.leadingAnchor.constraint(equalTo: centerXAnchor),
            labelForForecast.centerXAnchor.constraint(equalTo: centerXAnchor),
            labelForForecast.topAnchor.constraint(equalTo: currentAirPressureValue.bottomAnchor, constant: Const.labelsTopConst),
            
            weatherForDaysCollection.topAnchor.constraint(equalTo: labelForForecast.bottomAnchor),
            weatherForDaysCollection.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            weatherForDaysCollection.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            weatherForDaysCollection.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
// MARK: - ViewDataSource
extension MainPageWeatherView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath) as? MainPageWeatherViewCell else { return MainPageWeatherViewCell()  }
        let itemsForCell = listOfWeather[indexPath.item]
        cell.updateInfo(description: itemsForCell)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: bounds.width, height: weatherForDaysCollection.frame.height/8)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
// MARK: - update info from api
extension MainPageWeatherView {
    func updateInfo(weather: MainPageWeatherForeCastResponse.Weather, city: MainPageWeatherForeCastResponse.City?) {
        currentCountry.text = city?.country
        
        if let visibility = weather.visibility {
            currentVisabilityValue.text = "\(visibility) miles"
        } else {
            currentVisabilityValue.text = "- miles"
        }
        
        if let pressure = weather.main.pressure {
            currentAirPressureValue.text = "\(pressure) mb"
        } else {
            currentAirPressureValue.text = "- mb"
        }
        
        if let temperature = weather.main.temp {
            currentTemperature.text = "\(temperature)°C"
        } else {
            currentAirPressureValue.text = "- °C"
        }
        
        if let wind = weather.wind.speed {
            currentWindStatusValue.text = "\(wind) miles"
        } else {
            currentWindStatusValue.text = "- miles"
        }
        
        if let humidity = weather.main.humidity {
            currentHumidityValue.text = "\(humidity)%"
        } else {
            currentHumidityValue.text = "-%"
        }
        
        weather.weather.first.map {
            currentImage.image = UIImage(named: $0.icon ?? "04n")
        }
    }
}

extension MainPageWeatherView {
    func updateCollection(weather: [MainPageWeatherForeCastResponse.Weather]) {
        self.listOfWeather = weather
        
        weatherForDaysCollection.reloadData()
    }
}
