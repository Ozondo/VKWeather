//
//  FindPageViewController.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit

final class FindPageViewController: UIViewController, FindPageInput {
    private let presenter: FindPageWeatherPresenter
    private let findPageView = FindPageView()
    
    init(presenter: FindPageWeatherPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = findPageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .black
        
        findPageView.textChanged = { [weak self] text in
            self?.presenter.textChanged(cityName: text)
        }
        findPageView.cellTapped = { [weak self] index in
            self?.presenter.cellTapped(index: index)
        }
        
        presenter.viewDidLoad()
    }
    
    func setCities(cities: [String]) {
        findPageView.setCitiesNames(citiesNames: cities)
    }
    
    func setBackButtonVisibility(_ isVisible: Bool) {
        navigationItem.hidesBackButton = !isVisible
    }
}
