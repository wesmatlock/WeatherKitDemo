// RouteWeatherEntry.swift
// Copyright (c) 2025 Insoc

import WeatherKit
import WidgetKit

struct RouteWeatherEntry: TimelineEntry {
    let date: Date
    let route: RouteSnapshot
    let originWeather: CurrentWeather?
    let destinationWeather: CurrentWeather?
}
