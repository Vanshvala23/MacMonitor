//
//  PlaceholderView.swift
//  MacMonitor
//
//  Created by Vansh Vala on 25/08/26.
//


import SwiftUI

struct PlaceholderView: View {
    let title: String

    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "hammer")
                .font(.system(size: 40))

            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)

            Text("This section is coming soon.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}