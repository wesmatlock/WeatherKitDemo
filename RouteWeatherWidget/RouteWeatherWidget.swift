// RouteWeatherWidget.swift
// Copyright (c) 2025 Insoc

import SwiftUI
import WidgetKit

struct RouteWeatherWidget: Widget {
    let kind = "SwiftAirRouteWeather"

    var body: some WidgetConfiguration {
        StaticConfiguration(
            kind: kind,
            provider: RouteWeatherProvider()
        ) { entry in
            RouteWeatherWidgetView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Route Weather")
        .description("Compare origin and destination weather at a glance.")
        .supportedFamilies([.systemSmall, .systemMedium])
    }
}

// MARK: - Previews

#Preview("Medium", as: .systemMedium) {
    RouteWeatherWidget()
} timeline: {
    RouteWeatherEntry(
        date: Date(),
        route: RouteSnapshot.sample(),
        originWeather: nil,
        destinationWeather: nil
    )
}

#Preview("Small", as: .systemSmall) {
    RouteWeatherWidget()
} timeline: {
    RouteWeatherEntry(
        date: Date(),
        route: RouteSnapshot.sample(),
        originWeather: nil,
        destinationWeather: nil
    )
}
