//
//  FindPageService.swift
//  VK_weather
//
//  Created by Егор Иванов on 23.03.2024.
//

import UIKit

enum ApiErrorForCity: Error{
    case badUrl
    case emptyData
    case wrongData
    case custom(Error)
    case cancelled
}

protocol FindPageService {
    func getCity(city: String, completion: @escaping (Result<CityResponse, ApiErrorForCity>) -> ())
}

final class FinPageServiceImpl: FindPageService {
    
    private enum Constants {
        static let baseUrl = "https://api.openweathermap.org"
        static let apiKey = "18869d26c6503e1e1020f847c736fef7"
    }
    
    private var dataTask: URLSessionDataTask?
    
    func getCity(city: String, completion: @escaping (Result<CityResponse, ApiErrorForCity>) -> ()) {
        dataTask?.cancel()
        
        var urlComponents = URLComponents(string: "\(Constants.baseUrl)/geo/1.0/direct")
        
        urlComponents?.queryItems = [
            .init(name: "q", value: city),
            .init(name: "limit", value: "5"),
            .init(name: "appid", value: Constants.apiKey)
        ]
        
        guard let url = urlComponents?.url else {
            return completion(.failure(.badUrl))
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error as? URLError {
                if error.code != .cancelled {
                    return completion(.failure(.custom(error)))
                } else {
                    return completion(.failure(.cancelled))
                }
            }
            guard let data else {
                return completion(.failure(.emptyData))
            }
            do {
                let coordinates = try JSONDecoder().decode(CityResponse.self, from: data)
                completion(.success(coordinates))
            } catch {
                return completion(.failure(.wrongData))
            }
        }
        dataTask.resume()
        self.dataTask = dataTask
    }
}
