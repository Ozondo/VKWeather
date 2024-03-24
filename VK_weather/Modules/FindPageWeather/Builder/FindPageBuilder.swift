//
//  FindPageBuilder.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit

struct FindPageBuilder {
    static func build(
        delegate: FindPageWeatherPresenterDelegate,
        canCloseModule: Bool
    ) -> UIViewController {
        let service = FinPageServiceImpl()
        let router = FindPageWeatherRouterImpl()
        let presenter = FindPageWeatherPresenter(
            service: service,
            router: router,
            delegate: delegate,
            canCloseModule: canCloseModule
        )
        let view = FindPageViewController(presenter: presenter)
        
        presenter.view = view
        router.sceneController = view
        
        return view
    }
}
