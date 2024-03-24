//
//  FindPageViewCell.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit


final class FindPageViewCell: UICollectionViewCell {
    
    private let  cityName: UILabel = {
        let text = UILabel()
        text.textAlignment = .center
        text.text = "cityName"
        text.numberOfLines = 0
        text.font = UIFont(name: "Optima Regular", size: 20)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        viewSetup()
        layoutObjects()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func viewSetup() {
        [cityName].forEach { element in
            contentView.addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func layoutObjects() {
        NSLayoutConstraint.activate([
            cityName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}

extension FindPageViewCell {
    func updateInfo(namesOfCitites: String) {
        cityName.text = namesOfCitites
    }
}
