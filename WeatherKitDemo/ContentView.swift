// ContentView.swift
// Copyright (c) 2025 Insoc

import SwiftUI
import WidgetKit

struct ContentView: View {

    // MARK: Internal

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    // Route Picker
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Select Flight")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)

                        Picker("Route", selection: $selectedRouteIndex) {
                            ForEach(routes.indices, id: \.self) { index in
                                Text(routes[index].name).tag(index)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding(.horizontal)

                    // Weather Card
                    if viewModel.isLoading {
                        ProgressView("Loading weather...")
                            .frame(maxWidth: .infinity, minHeight: 200)
                    } else if let error = viewModel.errorMessage {
                        ContentUnavailableView {
                            Label("Weather Unavailable", systemImage: "exclamationmark.icloud")
                        } description: {
                            Text(error)
                        } actions: {
                            Button("Retry") {
                                Task {
                                    await viewModel.loadWeather(for: selectedRoute)
                                }
                            }
                        }
                    } else if
                        let origin = viewModel.originWeather,
                        let destination = viewModel.destinationWeather {
                        RouteWeatherCardView(
                            route: selectedRoute,
                            originWeather: origin,
                            destinationWeather: destination
                        )
                        .padding(.horizontal)
                    } else {
                        ContentUnavailableView {
                            Label("No Weather Data", systemImage: "cloud")
                        } description: {
                            Text("Pull to refresh or tap below to load weather.")
                        } actions: {
                            Button("Load Weather") {
                                Task {
                                    await viewModel.loadWeather(for: selectedRoute)
                                }
                            }
                            .buttonStyle(.borderedProminent)
                        }
                    }

                    Spacer()
                }
                .padding(.top)
            }
            .navigationTitle("SwiftAir")
            .refreshable {
                await viewModel.loadWeather(for: selectedRoute)
            }
            .onChange(of: selectedRouteIndex) {
                Task {
                    await viewModel.loadWeather(for: selectedRoute)
                    saveRouteForWidget()
                }
            }
            .task {
                await viewModel.loadWeather(for: selectedRoute)
                saveRouteForWidget()
            }
        }
    }

    // MARK: Private

    @State private var viewModel = RouteWeatherViewModel()
    @State private var selectedRouteIndex = 0

    private let routes: [(name: String, route: FlightRoute)] = [
        ("DEN → ORD", .denToOrd),
        ("SFO → JFK", .sfoToJfk),
        ("LAX → MIA", .laxToMia)
    ]

    private var selectedRoute: FlightRoute {
        routes[selectedRouteIndex].route
    }

    private func saveRouteForWidget() {
        let snapshot = RouteSnapshot(from: selectedRoute)
        snapshot.save()
        WidgetCenter.shared.reloadTimelines(ofKind: "SwiftAirRouteWeather")
    }
}

#Preview {
    ContentView()
}
