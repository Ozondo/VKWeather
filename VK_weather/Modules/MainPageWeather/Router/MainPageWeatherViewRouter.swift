//
//  MainPageWeatherViewRouter.swift
//  VK_weather
//
//  Created by Егор Иванов on 20.03.2024.
//

import UIKit

protocol MainPageWeatherViewRouter {
    func showAlert(title: String, message: String)
    func openFindPageScene(delegate: FindPageWeatherPresenterDelegate, canCloseModule: Bool)
}

final class MainPageWeatherViewRouterImpl: MainPageWeatherViewRouter {
    
    weak var sceneController: UIViewController?
    
    func openFindPageScene(
        delegate: FindPageWeatherPresenterDelegate,
        canCloseModule: Bool
    ) {
        let findPageVC = FindPageBuilder.build(delegate: delegate, canCloseModule: canCloseModule)
        sceneController?.navigationController?.pushViewController(findPageVC, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        sceneController?.present(alert, animated: true, completion: nil)
    }
}
