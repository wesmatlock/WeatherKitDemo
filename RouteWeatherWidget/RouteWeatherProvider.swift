// RouteWeatherProvider.swift
// Copyright (c) 2025 Insoc

import CoreLocation
import WeatherKit
import WidgetKit

struct RouteWeatherProvider: TimelineProvider {

    // MARK: Internal

    func placeholder(in context: Context) -> RouteWeatherEntry {
        RouteWeatherEntry(
            date: Date(),
            route: RouteSnapshot.sample(),
            originWeather: nil,
            destinationWeather: nil
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (RouteWeatherEntry) -> Void) {
        Task {
            let entry = await loadEntry()
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<RouteWeatherEntry>) -> Void) {
        Task {
            let entry = await loadEntry()

            let nextUpdate = Calendar.current
                .date(byAdding: .minute, value: 30, to: Date())!

            completion(Timeline(entries: [entry], policy: .after(nextUpdate)))
        }
    }

    func loadEntry() async -> RouteWeatherEntry {
        guard let route = RouteSnapshot.load() else {
            return RouteWeatherEntry(
                date: Date(),
                route: RouteSnapshot.sample(),
                originWeather: nil,
                destinationWeather: nil
            )
        }

        let originLocation = CLLocation(
            latitude: route.originLatitude,
            longitude: route.originLongitude
        )

        let destinationLocation = CLLocation(
            latitude: route.destinationLatitude,
            longitude: route.destinationLongitude
        )

        do {
            async let origin = weatherService.weather(for: originLocation)
            async let destination = weatherService.weather(for: destinationLocation)

            let originWeather = try await origin.currentWeather
            let destinationWeather = try await destination.currentWeather

            return RouteWeatherEntry(
                date: Date(),
                route: route,
                originWeather: originWeather,
                destinationWeather: destinationWeather
            )
        } catch {
            return RouteWeatherEntry(
                date: Date(),
                route: route,
                originWeather: nil,
                destinationWeather: nil
            )
        }
    }

    // MARK: Private

    private let weatherService = WeatherService.shared

}
