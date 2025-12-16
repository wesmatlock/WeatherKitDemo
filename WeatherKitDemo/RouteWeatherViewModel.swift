// RouteWeatherViewModel.swift
// Copyright (c) 2025 Insoc

import Foundation
import WeatherKit

@Observable
final class RouteWeatherViewModel {

    // MARK: Internal

    var originWeather: (CurrentWeather, [DayWeather])?
    var destinationWeather: (CurrentWeather, [DayWeather])?

    var errorMessage: String?
    var isLoading = false

    func loadWeather(for route: FlightRoute) async {
        isLoading = true
        errorMessage = nil

        do {
            async let origin = weatherManager.weather(for: route.originLocation)
            async let destination = weatherManager.weather(for: route.destinationLocation)

            originWeather = try await origin
            destinationWeather = try await destination
        } catch {
            errorMessage = "Weather unavailable for this route."
        }

        isLoading = false
    }

    // MARK: Private

    private let weatherManager = WeatherManager()

}
