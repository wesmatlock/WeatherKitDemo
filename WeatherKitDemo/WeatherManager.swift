// WeatherManager.swift
// Copyright (c) 2025 Insoc

import CoreLocation
import WeatherKit

actor WeatherManager {

    // MARK: Internal

    func weather(for location: CLLocation) async throws -> (CurrentWeather, [DayWeather]) {
        let weather = try await service.weather(
            for: location,
            including: .current, .daily
        )

        return (
            weather.0,
            Array(weather.1.forecast.prefix(5))
        )
    }

    // MARK: Private

    private let service = WeatherService.shared

}

enum WeatherError: Error {
    case unavailable
}
