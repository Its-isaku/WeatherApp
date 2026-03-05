//
//  DeniedView.swift
//  WeatherApp
//
//  Shows when location permission is denied, with instructions to fix it
//

import SwiftUI

struct DeniedView: View {

	var body: some View {
		VStack(spacing: 12) {

			Text("Location Access Denied")
				.font(.headline)

			Text("Enable it in Settings > Privacy > Location Services")
				.font(.subheadline)
				.foregroundColor(.secondary)
				.multilineTextAlignment(.center)

			Button("Open Settings") {
				if let url = URL(string: UIApplication.openSettingsURLString) {
					UIApplication.shared.open(url)
				}
			}
			.buttonStyle(.borderedProminent)
		}
		.padding(.horizontal)
	}
}
