//
//  ContentView.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import SwiftUI
import CoreLocation

struct ContentView: View {

	@StateObject private var viewModel: LocationViewModel = LocationViewModel()
	@StateObject private var weatherVM: WeatherViewModel = WeatherViewModel()

	var body: some View {
		VStack {

			Text("Nearby LOG").font(.headline).bold()
				.padding(.top)

			if viewModel.viewState == .needsPermission {
				PermissionView(onEnable: viewModel.enableLocation)
			} else if viewModel.viewState == .loading {
				LoadingView()
			} else if viewModel.viewState == .ready {
				LocationReadyView(
					latitudeText: viewModel.latitudeText,
					longitudeText: viewModel.longitudeText,
					onRefresh: viewModel.refreshBtn,
					onSave: viewModel.saveCheckIn
				)

				WeatherView(
					weatherVM: weatherVM,
					onRefresh: {
						if let coord = viewModel.lastCoordinate {
							Task {
								await weatherVM.fetchWeather(
									latitude: coord.latitude,
									longitude: coord.longitude
								)
							}
						}
					}
				)
			} else if viewModel.viewState == .denied {
				DeniedView()
			} else if viewModel.viewState == .failed {
				FailedView(
					message: viewModel.errorMessage,
					onTryAgain: viewModel.enableLocation
				)
			}

			Divider().padding(.horizontal)

			CheckInListView(
				checkIn: viewModel.checkIns,
				onClearAll: viewModel.clearAll
			)

		}
		.task(id: viewModel.latitudeText) {
			if let coord = viewModel.lastCoordinate {
				await weatherVM.fetchWeather(
					latitude: coord.latitude,
					longitude: coord.longitude
				)
			}
		}
    }
}

#Preview {
    ContentView()
}
