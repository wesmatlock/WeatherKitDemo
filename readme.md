# SwiftAir WeatherKit Demo ✈️  
### Origin vs Destination Weather with SwiftUI & WidgetKit

This repository contains a small but realistic SwiftUI demo app built around a fictional airline called **SwiftAir**.

The goal isn’t to build a weather app.  
The goal is to show how **route-based weather** fits into a passenger experience — comparing **origin vs destination conditions** in a way that’s calm, glanceable, and actually useful.

This project accompanies the blog post:

👉 https://wesleymatlock.com  
👉 https://medium.com/@wesleymatlock

---

## What This Project Demonstrates

This repo focuses on a few very specific ideas that come up in real airline-style apps:

- Using **WeatherKit** to fetch weather for known locations (airports), not just the user’s current GPS position  
- Comparing **origin vs destination weather** side by side instead of dumping generic forecasts  
- Structuring WeatherKit access behind a dedicated service layer  
- Coordinating multiple weather requests safely using Swift concurrency  
- Building a **WidgetKit Home Screen widget** that mirrors the route-based weather context  
- Sharing data between the app and widget using **App Groups**  
- Choosing conservative widget refresh behavior that’s App Review–friendly  

There’s intentionally no networking abstraction layer, no persistence framework, and no UI polish beyond what’s needed to illustrate the patterns.

---

## Project Structure

At a high level, the project is split into two targets:

- **SwiftAirApp**
  - SwiftUI views for the route weather card
  - `WeatherManager` actor for WeatherKit access
  - `RouteWeatherViewModel` coordinating origin and destination requests
  - Simple route models using airport coordinates

- **SwiftAirWidgets**
  - WidgetKit timeline provider
  - Route snapshot decoding via App Group `UserDefaults`
  - Medium and small Home Screen widget layouts

The widget does **not** reuse app view models or in-memory state. Everything is passed through a snapshot model on purpose.

---

## Requirements

- iOS 18+
- Xcode 16+
- An Apple Developer account with **WeatherKit enabled**
- App Groups configured for the app and widget targets

No third-party dependencies are used.

---

## WeatherKit Setup Notes

To run this project successfully, you’ll need to:

1. Enable **WeatherKit** for your App ID in the Apple Developer Portal  
2. Add the WeatherKit capability to both the app and widget targets  
3. Ensure the `com.apple.developer.weatherkit` entitlement is present  
4. Use valid coordinates (the sample uses real airport locations)

WeatherKit attribution is required anywhere weather data appears:

> **“Weather data provided by Apple Weather.”**

If this is missing or hidden, App Review may flag it.

---

## Widget Refresh Behavior

The widget refreshes on a **30-minute cadence** by design.

This keeps:
- Background network usage reasonable  
- Battery impact low  
- Timeline behavior easy to explain during App Review  

This widget is meant to provide **situational awareness**, not live weather tracking.

---

## Why Route-Based Weather?

Passengers don’t think in latitude and longitude.  
They think in routes.

This project treats weather as travel context:
- Where am I leaving from?
- Where am I landing?
- What does that probably mean for my flight?

That framing drives every architectural and UI decision in this repo.

---

## Disclaimer

This is a demo project intended for learning and exploration.

It is **not** a production airline app, and it skips concerns like:
- Authentication
- Localization
- Accessibility polish
- Persistence
- Error analytics

Those are deliberately out of scope so the WeatherKit and WidgetKit patterns stay clear.

---

## Feedback & Experiments

If you build your own variation — different widget sizes, Lock Screen widgets, Live Activities, or alternate refresh strategies — I’d genuinely love to see it.


Weather will always win sometimes — but the UI doesn’t have to be chaotic.
