//
//  MainPageWeatherPresenter.swift
//  VK_weather
//
//  Created by Егор Иванов on 20.03.2024.
//

import UIKit
import CoreLocation

final class MainPageWeatherPresenter: NSObject, MainPageOutput {
    weak var view: MainPageInput?
    private let service: MainPageWeatherService
    private let coreDataService: MainPageWeatherCoreDataService
    private let locationManager = CLLocationManager()
    private let router: MainPageWeatherViewRouter
    
    init(
        service: MainPageWeatherService,
        coreDataService: MainPageWeatherCoreDataService,
        router: MainPageWeatherViewRouter
    ) {
        self.service = service
        self.router = router
        self.coreDataService = coreDataService
    }
    
    func viewDidLoad() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        
        if locationManager.authorizationStatus == .denied || locationManager.authorizationStatus == .restricted {
            router.openFindPageScene(delegate: self, canCloseModule: false)
        }
    }
    
    func rightButtonTapped() {
        router.openFindPageScene(delegate: self, canCloseModule: true)
    }
    
    private func getCoordinatesForForeCastCollection(lat: Double, lon: Double) {
        view?.isActivityIndicatorVisible = true
        service.getWeather(lat: lat, lon: lon) { [weak self] result in
            guard let self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let weather):
                    weather.list.first.map {
                        self.view?.updateWeather(weather: $0, city: weather.city)
                    }
                    self.view?.updateCollection(weather: weather.list)
                    
                    DispatchQueue.global(qos: .background).async {
                        self.coreDataService.save(response: weather, lat: lat, lon: lon)
                    }
                case .failure:
                    guard let weather = self.coreDataService.getModel(lat: lat, lon: lon) else {
                        return self.router.showAlert(title: "Произошла ошибка", message: "Попробуйте позже")
                    }
                    weather.list.first.map {
                        self.view?.updateWeather(weather: $0, city: weather.city)
                    }
                    self.view?.updateCollection(weather: weather.list)
                }
                self.view?.isActivityIndicatorVisible = false
            }
        }
    }
}

extension MainPageWeatherPresenter: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else { return }
        
        if (currentLocation.horizontalAccuracy > 0) {
            manager.stopUpdatingLocation()
            getCoordinatesForForeCastCollection(
                lat: Double(currentLocation.coordinate.latitude),
                lon: Double(currentLocation.coordinate.longitude)
            )
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            router.openFindPageScene(delegate: self, canCloseModule: false)
        }
    }
}

extension MainPageWeatherPresenter: FindPageWeatherPresenterDelegate {
    func didSelectLocation(lat: Double, lon: Double) {
        getCoordinatesForForeCastCollection(lat: lat, lon: lon)
    }
}
