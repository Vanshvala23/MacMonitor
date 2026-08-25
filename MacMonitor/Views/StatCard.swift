//
//  StatCard.swift
//  MacMonitor
//
//  Created by Vansh Vala on 25/08/26.
//


import SwiftUI

struct StatCard: View {
    let title: String
    let value: String
    let subtitle: String
    let systemImage: String

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack {
                Image(systemName: systemImage)
                    .font(.title2)

                Text(title)
                    .font(.headline)

                Spacer()
            }

            Text(value)
                .font(.system(size: 32, weight: .bold))

            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(24)
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    StatCard(
        title: "CPU",
        value: "18%",
        subtitle: "Overall usage",
        systemImage: "cpu"
    )
    .frame(width: 400)
    .padding()
}