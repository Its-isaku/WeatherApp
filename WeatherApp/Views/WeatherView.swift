//
//  WeatherView.swift
//  WeatherApp
//
//  Displays weather info with loading, success, and error states
//

import SwiftUI

struct WeatherView: View {

	@ObservedObject var weatherVM: WeatherViewModel
	let onRefresh: () -> Void

	var body: some View {
		VStack(spacing: 10) {

			if weatherVM.isLoading {

				ProgressView()
				Text("Loading weather...")
					.font(.caption)
					.foregroundColor(.gray)

			} else if let weather = weatherVM.weather {

				Image(systemName: weather.conditionIcon)
					.symbolRenderingMode(.multicolor)
					.font(.system(size: 40))

				Text(weatherVM.displayTemperature)
					.font(.system(size: 38, weight: .bold, design: .rounded))

				Text(weather.conditionText)
					.font(.subheadline)
					.foregroundColor(.secondary)

				Text("Wind \(String(format: "%.1f", weather.windSpeed)) km/h")
					.font(.caption)
					.foregroundColor(.secondary)

				Picker("Unit", selection: $weatherVM.useCelsius) {
					Text("°C").tag(true)
					Text("°F").tag(false)
				}
				.pickerStyle(.segmented)
				.frame(width: 100)

				if let lastUpdated = weatherVM.lastUpdated {
					Text("Updated \(lastUpdated, style: .time)")
						.font(.caption2)
						.foregroundColor(.gray)
				}

				Button("Refresh Weather") {
					self.onRefresh()
				}.buttonStyle(.bordered)

			} else if weatherVM.errorMessage.isEmpty == false {

				Text(weatherVM.errorMessage)
					.font(.subheadline)
					.foregroundColor(.red)
					.multilineTextAlignment(.center)

				Button("Retry") {
					self.onRefresh()
				}.buttonStyle(.bordered)

			} else {
				ProgressView()
					.padding(.vertical, 16)
			}
		}
		.padding(.vertical, 8)
	}
}
