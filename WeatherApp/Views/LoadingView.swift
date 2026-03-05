//
//  LoadingView.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
		VStack {
			ProgressView().padding()
			Text("Getting your location...")
				.font(.subheadline)
				.foregroundColor(.secondary)
		}
    }
}
