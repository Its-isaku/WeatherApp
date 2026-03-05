//
//  FailedView.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import SwiftUI

struct FailedView: View {

	let message: String
	let onTryAgain: ()->Void

    var body: some View {
		VStack(spacing: 12) {
			Text(message)
				.foregroundColor(.secondary)
			Button("Try Again") {
				self.onTryAgain()
			}.buttonStyle(.bordered)
		}
    }
}
