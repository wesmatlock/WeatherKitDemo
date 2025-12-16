// RouteSnapshot.swift
// Copyright (c) 2025 Insoc

import CoreLocation
import Foundation

/// A lightweight, Codable snapshot of a flight route for sharing between app and widget via App Group.
struct RouteSnapshot: Codable {
    let originName: String
    let originLatitude: Double
    let originLongitude: Double

    let destinationName: String
    let destinationLatitude: Double
    let destinationLongitude: Double

    var originLocation: CLLocation {
        CLLocation(latitude: originLatitude, longitude: originLongitude)
    }

    var destinationLocation: CLLocation {
        CLLocation(latitude: destinationLatitude, longitude: destinationLongitude)
    }
}

// MARK: - Convenience Initializer

extension RouteSnapshot {
    init(from route: FlightRoute) {
        originName = route.originName
        originLatitude = route.originLocation.coordinate.latitude
        originLongitude = route.originLocation.coordinate.longitude
        destinationName = route.destinationName
        destinationLatitude = route.destinationLocation.coordinate.latitude
        destinationLongitude = route.destinationLocation.coordinate.longitude
    }
}

// MARK: - Sample Data

extension RouteSnapshot {
    static func sample() -> RouteSnapshot {
        RouteSnapshot(
            originName: "Denver (DEN)",
            originLatitude: 39.8561,
            originLongitude: -104.6737,
            destinationName: "Chicago (ORD)",
            destinationLatitude: 41.9742,
            destinationLongitude: -87.9073
        )
    }
}

// MARK: - App Group Storage

extension RouteSnapshot {
    private static let appGroupID = "group.net.insoc.WeatherKitDemo"
    private static let storageKey = "activeRoute"

    /// Saves the route snapshot to App Group UserDefaults for widget access.
    func save() {
        guard let data = try? JSONEncoder().encode(self) else { return }
        UserDefaults(suiteName: Self.appGroupID)?.set(data, forKey: Self.storageKey)
    }

    /// Loads the route snapshot from App Group UserDefaults.
    static func load() -> RouteSnapshot? {
        guard
            let data = UserDefaults(suiteName: appGroupID)?.data(forKey: storageKey),
            let snapshot = try? JSONDecoder().decode(RouteSnapshot.self, from: data)
        else {
            return nil
        }
        return snapshot
    }
}




