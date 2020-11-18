//
//  JSONModel.swift
//  OpenWeatherDemo
//
//  Created by   admin on 18.11.2020.
//

import Foundation

// MARK: - JSONModel
struct JSONModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let wind: Wind
    let dt: Int
    let sys: Sys
    let name: String
}

// MARK: - Coord
struct Coord: Codable {
    let lon, lat: Double
}

// MARK: - Main
struct Main: Codable {
    let temp: Double
    let humidity: Int
}

// MARK: - Sys
struct Sys: Codable {
    let type, id: Int
    let country: String
}

// MARK: - Weather
struct Weather: Codable {
    let description, icon: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}
