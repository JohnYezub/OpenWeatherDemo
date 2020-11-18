//
//  ViewModel.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import SwiftUI

// struct to store data
struct dataModel {
    var name: String?
    var wind: String
    var temp: String
    var humidity: String
    var error: String?
    var image: UIImage?
    var description: String
    var country: String?
    init() {        
        self.wind = "--"
        self.temp = "--"
        self.humidity = "--"
        self.description = ""
    }
    
}

//observable model to display data for view

class ViewModel: ObservableObject {
    
    @Published var weather: dataModel = dataModel()
    private let locationManager = LocationManager()
    
    init() {
        locationManager.completeLocation = { [weak self] location, error in
            if let location = location {
                let simpleLocation = SimpleLocation(lat: location.coordinate.latitude, lon: location.coordinate.longitude)
            self?.fetchData(location: simpleLocation)
            }
        }
        
    }
    
    //since we've got location, we fetch data
    private func fetchData(location: SimpleLocation) {
        NetworkService.loadData(type: JSONModel.self, location: location) { [weak self] (result) in
            switch result {
            
            case .success(let weatherData):
                guard let weatherData = weatherData else { print("weatherData is nil"); return }
                self?.weather.temp = String(Int(weatherData.main.temp))
                self?.weather.wind = String(weatherData.wind.speed)
                self?.weather.humidity = String(weatherData.main.humidity)
                self?.weather.name = String(weatherData.name)
                self?.weather.country = String(weatherData.sys.country)
                if weatherData.weather.count > 0 {
                    self?.getIcon(forName: weatherData.weather[0].icon)
                    self?.weather.description = weatherData.weather[0].description
                }
                
            case .failure(_):
                self?.weather.error = "Failed to get network data"
            }
            
        }
    }
    
    //once data receive we call getIcon to load weather icon
    private func getIcon(forName name: String) {
        NetworkService.downloadImageBy(url: name) { [weak self] (result) in
            switch result {            
            case .success(let image):
                self?.weather.image = image
            case .failure(_):
                print("failed to get icon")
            }
        }
    }
    
    //
    //    var publishedAt: String {
    //        //2020-11-11T21:04:00Z
    //        let df = DateFormatter()
    //        df.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    //        df.timeZone = TimeZone(abbreviation: "UTC")
    //
    //        if let date = df.date(from: self.article.publishedAt) {
    //            df.dateStyle = .medium
    //            df.timeStyle = .short
    //            return df.string(from: date)
    //        } else {
    //            return ""
    //        }
    //    }
}
