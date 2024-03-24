//
//  FindPageWeatherRouter.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit

protocol FindPageWeatherRouter {
    func openFindPageScene()
    func showAlert(title: String, message: String)
}

final class FindPageWeatherRouterImpl: FindPageWeatherRouter {
    
    weak var sceneController: UIViewController?
    
    func openFindPageScene() {
        sceneController?.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .cancel, handler: nil))
        sceneController?.present(alert, animated: true, completion: nil)
    }
}
