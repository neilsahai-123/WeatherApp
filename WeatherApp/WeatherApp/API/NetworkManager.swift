//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Ajay Girolkar on 02/04/23.
//

import Foundation

class NetworkManager<T: Codable> {
    static func fetch(for url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(.error(error: error?.localizedDescription ?? "Error")))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(.success(model))
                print("\n\n***** Success got response for URL : \(url) Response = \n \(model) ********\n\n")
            } catch let error {
                print(error.localizedDescription)
                completion(.failure(.decodingError(error: error.localizedDescription)))
                
            }
            
        }.resume()
    }
}

enum NetworkError: Error {
    case invalidResponse
    case invalidData
    case error(error: String)
    case decodingError(error: String)
}
