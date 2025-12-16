// RouteWeatherCardView.swift
// Copyright (c) 2025 Insoc

import SwiftUI
import WeatherKit

struct RouteWeatherCardView: View {
    let route: FlightRoute
    let originWeather: (CurrentWeather, [DayWeather])
    let destinationWeather: (CurrentWeather, [DayWeather])

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Image(systemName: "airplane.departure")
                    .foregroundStyle(.blue)
                Spacer()
            }

            CityWeatherView(
                cityName: route.originName,
                current: originWeather.0,
                forecast: originWeather.1
            )

            Divider()

            HStack {
                Image(systemName: "airplane.arrival")
                    .foregroundStyle(.green)
                Spacer()
            }

            CityWeatherView(
                cityName: route.destinationName,
                current: destinationWeather.0,
                forecast: destinationWeather.1
            )

            Divider()

            Link(destination: URL(string: "https://weather.apple.com")!) {
                Text("Weather data provided by Apple Weather.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
