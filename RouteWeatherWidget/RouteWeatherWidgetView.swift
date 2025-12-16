// RouteWeatherWidgetView.swift
// Copyright (c) 2025 Insoc

import SwiftUI
import WeatherKit
import WidgetKit

struct RouteWeatherWidgetView: View {
    let entry: RouteWeatherEntry

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            CityRow(name: entry.route.originName, weather: entry.originWeather, isOrigin: true)
            CityRow(name: entry.route.destinationName, weather: entry.destinationWeather, isOrigin: false)

            Spacer()

            Text("Weather data provided by Apple Weather.")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .padding()
    }
}

struct CityRow: View {
    let name: String
    let weather: CurrentWeather?
    let isOrigin: Bool

    var body: some View {
        HStack {
            Image(systemName: isOrigin ? "airplane.departure" : "airplane.arrival")
                .font(.caption)
                .foregroundStyle(isOrigin ? .blue : .green)

            Text(name)
                .font(.caption.bold())
                .lineLimit(1)

            Spacer()

            if let weather {
                Image(systemName: weather.symbolName)
                    .symbolRenderingMode(.multicolor)
                Text(weather.temperature.formatted())
                    .font(.caption)
            } else {
                Text("--")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
