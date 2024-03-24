//
//  FindPageView.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit


final class FindPageView: UIView, UICollectionViewDelegate {
    
    // MARK: - Constants
    private enum Const {
        static let leadingOrTrailingConst: CGFloat = 20
    }
    
    var textChanged: ((String) -> Void)?
    var cellTapped: ((Int) -> Void)?
    var citiesName: [String] = []
    
    // MARK: - private properties
    private let gradientView = CAGradientLayer()
    
    private let searchBar: UISearchBar = {
       let searchBar = UISearchBar()
        
        searchBar.placeholder = "Search Location"
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }()
    
    private let text: UILabel = {
        let text = UILabel()
        text.text = "Write and pick city 👀"
        text.textAlignment = .center
        text.font = UIFont(name: "Optima Regular", size: 25)
        return text
    }()
    
    private let citiesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: .zero)
        collectionSetup()
        gradientSetup()
        searchBarAction()
        viewSetup()
        layoutElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientView.frame = bounds
    }
    
    // MARK: - private methods
    func searchBarAction() {
        searchBar.searchTextField.addAction(UIAction { [weak self] _ in
            guard let text = self?.searchBar.text else { return }
            self?.textChanged?(text)
        }, for: .editingChanged)
    }
    
    private func gradientSetup() {
        gradientView.colors = [UIColor.systemOrange.cgColor, UIColor.lightGray.cgColor]
        layer.addSublayer(gradientView)
        gradientView.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    private func viewSetup(){
        [text,
         searchBar,
         citiesCollectionView
        ].forEach { element in
            addSubview(element)
            element.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func collectionSetup() {
        citiesCollectionView.dataSource = self
        citiesCollectionView.delegate = self
        citiesCollectionView.register(FindPageViewCell.self, forCellWithReuseIdentifier: "id2")
    }
    
    private func layoutElements() {
        NSLayoutConstraint.activate([
            text.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            text.leadingAnchor.constraint(equalTo: leadingAnchor,constant: Const.leadingOrTrailingConst),
            text.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -Const.leadingOrTrailingConst),
            
            searchBar.topAnchor.constraint(equalTo: text.bottomAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            
            citiesCollectionView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            citiesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Const.leadingOrTrailingConst),
            citiesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Const.leadingOrTrailingConst),
            citiesCollectionView.bottomAnchor.constraint(equalTo: keyboardLayoutGuide.topAnchor)
        ])
    }
    
}

extension FindPageView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return citiesName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "id2", for: indexPath) as? FindPageViewCell else { return FindPageViewCell()  }
        let itemsForCell = citiesName[indexPath.item]
        cell.updateInfo(namesOfCitites: itemsForCell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: bounds.width, height: citiesCollectionView.frame.height/5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        citiesCollectionView.deselectItem(at: indexPath, animated: true)
        cellTapped?(indexPath.item)
    }
    
    
}

extension FindPageView {
    func setCitiesNames(citiesNames: [String]) {
        self.citiesName = citiesNames
        
        citiesCollectionView.reloadData()
    }
}
