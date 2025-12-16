// FlightRoute.swift
// Copyright (c) 2025 Insoc

import CoreLocation

struct FlightRoute {
    let originName: String
    let originLocation: CLLocation

    let destinationName: String
    let destinationLocation: CLLocation
}

// MARK: - Sample Routes

extension FlightRoute {
    static let denToOrd = FlightRoute(
        originName: "Denver (DEN)",
        originLocation: CLLocation(latitude: 39.8561, longitude: -104.6737),
        destinationName: "Chicago (ORD)",
        destinationLocation: CLLocation(latitude: 41.9742, longitude: -87.9073)
    )

    static let sfoToJfk = FlightRoute(
        originName: "San Francisco (SFO)",
        originLocation: CLLocation(latitude: 37.6213, longitude: -122.3790),
        destinationName: "New York (JFK)",
        destinationLocation: CLLocation(latitude: 40.6413, longitude: -73.7781)
    )

    static let laxToMia = FlightRoute(
        originName: "Los Angeles (LAX)",
        originLocation: CLLocation(latitude: 33.9425, longitude: -118.4081),
        destinationName: "Miami (MIA)",
        destinationLocation: CLLocation(latitude: 25.7959, longitude: -80.2870)
    )
}
