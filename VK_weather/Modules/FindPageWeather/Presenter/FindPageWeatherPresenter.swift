//
//  FindPageWeatherPresenter.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit

protocol FindPageWeatherPresenterDelegate: AnyObject {
    func didSelectLocation(lat: Double, lon: Double)
}

final class FindPageWeatherPresenter: FindPageOutput {
    
    weak var view: FindPageInput?
    
    private let service: FindPageService
    private let router: FindPageWeatherRouter
    private let canCloseModule: Bool
    private var response: CityResponse?
    
    private weak var delegate: FindPageWeatherPresenterDelegate?
    
    init(
        service: FindPageService,
        router: FindPageWeatherRouter,
        delegate: FindPageWeatherPresenterDelegate,
        canCloseModule: Bool
    ) {
        self.router = router
        self.service = service
        self.delegate = delegate
        self.canCloseModule = canCloseModule
    }
    
    func viewDidLoad() {
        view?.setBackButtonVisibility(canCloseModule)
    }
    
    func textChanged(cityName: String) {
        guard !cityName.isEmpty else { 
            view?.setCities(cities: [])
            return
        }
        
        service.getCity(city: cityName) { [weak self] result in
            guard let self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let cities):
                    self.response = cities
                    let citiesNames = cities.compactMap({ response in
                        return "\(response.name) \(response.country)"
                    })
                    self.view?.setCities(cities: citiesNames)
                case .failure(let error):
                    if case .cancelled = error { return }
                    self.router.showAlert(title: "Произошла ошибка", message: "Попробуйте позже")
                }
            }
        }
    }
    
    func cellTapped(index: Int) {
        guard let data = response?[index] else { return }
        delegate?.didSelectLocation(lat: data.lat, lon: data.lon)
        router.openFindPageScene()
    }
}
