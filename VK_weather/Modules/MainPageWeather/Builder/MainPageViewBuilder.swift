//
//  MainPageViewBuilder.swift
//  VK_weather
//
//  Created by Егор Иванов on 20.03.2024.
//

import UIKit

struct MainPageViewBuilder {
    static func build() -> UIViewController {
        let service = MainPageWeatherServiceImpl()
        let router = MainPageWeatherViewRouterImpl()
        let coreDataService = MainPageWeatherCoreDataServiceImpl()
        let presenter = MainPageWeatherPresenter(
            service: service,
            coreDataService: coreDataService,
            router: router
        )
        let view = MainPageWeatherViewController(mainPagePresenter: presenter)
        
        presenter.view = view
        router.sceneController = view
        
        return view
    }
}
