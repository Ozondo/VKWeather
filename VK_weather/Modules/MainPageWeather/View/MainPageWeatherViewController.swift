//
//  ViewController.swift
//  VK_weather
//
//  Created by Егор Иванов on 20.03.2024.
//

import UIKit
import CoreLocation


final class MainPageWeatherViewController: UIViewController, MainPageInput {

    // MARK: - private properties
    private let mainPagePresenter: MainPageOutput
    private let mainPageView = MainPageWeatherView()
    
    init(mainPagePresenter: MainPageOutput) {
        self.mainPagePresenter = mainPagePresenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainPagePresenter.viewDidLoad()
        setUpNavigationBar()
    }
    
    override func loadView() {
        view = mainPageView
    }
    
    // MARK: - MainPageInput
    var isActivityIndicatorVisible: Bool {
        get { mainPageView.isActivityIndicatorVisible }
        set { mainPageView.isActivityIndicatorVisible = newValue }
    }
    
    func updateWeather(weather: MainPageWeatherForeCastResponse.Weather, city: MainPageWeatherForeCastResponse.City?) {
        mainPageView.updateInfo(weather: weather, city: city)
        navigationItem.title = city?.name
    }
    
    func updateCollection(weather: [MainPageWeatherForeCastResponse.Weather]) {
        mainPageView.updateCollection(weather: weather)
    }
}

extension MainPageWeatherViewController {
    private func setUpNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "magnifyingglass"),
            style: .done,
            target: self,
            action: #selector(rightBarTapped)
        )
        navigationItem.rightBarButtonItem?.tintColor = .black
        
        if let font = UIFont(name: "Optima Regular", size: 25) {
            navigationController?.navigationBar.titleTextAttributes = [
                NSAttributedString.Key.font: font
            ]
        }
    }
    
    @objc func rightBarTapped() {
        mainPagePresenter.rightButtonTapped()
    }
}
