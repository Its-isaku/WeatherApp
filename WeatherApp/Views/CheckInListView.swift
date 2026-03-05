//
//  CheckInListView.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import SwiftUI

struct CheckInListView: View {

	let checkIn: [CheckInModel]
	let onClearAll: ()->Void

	var body: some View {
		VStack {
			VStack {
				Text("Check-Ins").font(.headline)
				Button("Clear All"){
					self.onClearAll()
				} .disabled(checkIn.count == 0)

				if checkIn.count == 0 {
					Text("No check-ins yet")
						.foregroundColor(.secondary)
						.font(.subheadline)
				} else {
					List(checkIn) { item in
						VStack(alignment: .leading, spacing: 4) {
							HStack {
								Text(item.timestamp, style: .time)
									.font(.subheadline).bold()
								Text(item.timestamp, style: .date)
									.font(.caption)
									.foregroundColor(.secondary)
							}
							Text("Lat: \(item.latitude)  Long: \(item.longitude)")
								.font(.caption)
								.foregroundColor(.secondary)
						}
						.padding(.vertical, 2)
					}
					.listStyle(.plain)
				}
			}
		}
    }
}
