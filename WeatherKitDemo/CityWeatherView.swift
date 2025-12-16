// CityWeatherView.swift
// Copyright (c) 2025 Insoc

import SwiftUI
import WeatherKit

struct CityWeatherView: View {
    let cityName: String
    let current: CurrentWeather
    let forecast: [DayWeather]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(cityName)
                .font(.headline)

            HStack {
                Image(systemName: current.symbolName)
                    .font(.title2)
                    .symbolRenderingMode(.multicolor)
                Text(current.temperature.formatted())
                    .font(.title2.bold())
            }

            Text(current.condition.description)
                .font(.subheadline)
                .foregroundStyle(.secondary)

            if let today = forecast.first {
                HStack(spacing: 12) {
                    Label("H \(today.highTemperature.formatted())", systemImage: "arrow.up")
                    Label("L \(today.lowTemperature.formatted())", systemImage: "arrow.down")
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
        }
    }
}
