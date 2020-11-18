//
//  NetworkService.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import Foundation
import UIKit

struct SimpleLocation {
    let lat: Double
    let lon: Double
}

class NetworkService {
    
    static func loadData<T: Decodable>(type: T.Type, location: SimpleLocation, completion: @escaping (Result<T?, NetworkError>) -> ()) {
        let location = location
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(location.lat)&lon=\(location.lon)&units=metric&appid=26a00222cc416395251d3abdf412f4c2"
        
        guard let url = URL(string: urlString) else {
            print("URL error in: \(#function)")
            return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if error == nil {
                let decoded = decodeData(type: T.self, data: data)
                DispatchQueue.main.async {
                    completion(.success(decoded))
                }
                
            } else {
                print("Error or data in: \(#function)")
                print(error as Any); print(error!.localizedDescription)
                DispatchQueue.main.async {
                    completion(.failure(.failed))
                }
            }
        }
        task.resume()
        
    }
    
    static func decodeData<T: Decodable>(type: T.Type, data: Data?) -> T? {
        guard let data = data else {print("Error in: \(#function). Data is nil"); return nil }
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(T.self, from: data)
        } catch let error {
            print(#function)
            print(error)
            print(error.localizedDescription)
            return nil
        }
    }
    
    static func downloadImageBy(url: String, completion: @escaping (Result<UIImage, NetworkError>)->Void) {
        let iconURL  = "http://openweathermap.org/img/wn/\(url).png"
        
        guard let url = URL(string: iconURL) else {
            print("failed to produce URL for image")
            completion(.failure(.failed))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completion(.success(image))
                    }
                } else {
                    print("failed to get Image from data")
                    completion(.failure(.failed))
                }
            } else {
                if error != nil {
                    print(error?.localizedDescription as Any)
                    completion(.failure(.failed))
                }
                if data == nil {
                    print("no data for Image")
                    completion(.failure(.failed))
                }
            }
        }
        task.resume()
    }
}

enum NetworkError: Error {
    case failed
}
