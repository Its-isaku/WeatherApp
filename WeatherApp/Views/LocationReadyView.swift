//
//  LocationReadyView.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import SwiftUI

struct LocationReadyView: View {

	let latitudeText: String
	let longitudeText: String
	let onRefresh: ()->Void
	let onSave: ()->Void

    var body: some View {
		VStack(spacing: 12) {
			VStack(spacing: 4) {
				Text("Latitude \(latitudeText)")
					.font(.subheadline)
				Text("Longitude \(longitudeText)")
					.font(.subheadline)
			}
			.foregroundColor(.secondary)

			HStack {
				Button("Refresh") {
					self.onRefresh()
				}.buttonStyle(.bordered)

				Button("Save Check-In") {
					self.onSave()
				}.buttonStyle(.borderedProminent)
			}
		}
		.padding(.vertical, 8)
    }
}
