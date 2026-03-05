//
//  PermissionView.swift
//  WeatherApp
//
//  Created by Isai Magdaleno Almeraz Landeros on 28/02/26.
//

import SwiftUI

struct PermissionView: View {

	let onEnable: ()->Void

    var body: some View {
		VStack(spacing: 12) {
			Text("We need Permissions to save the location")
				.multilineTextAlignment(.center)
			Button("Enable Location") {
				self.onEnable()
			}
			.buttonStyle(.borderedProminent)
			.padding()
		}
		.padding(.horizontal)
    }
}
