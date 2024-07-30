//
//  AdView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 28/7/24.
//

import SwiftUI

struct AdView: View {
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .opacity(Constants.backgroundOpacity)
                .ignoresSafeArea()
            ProgressView()
                .scaleEffect(Constants.loaderScale)
        }
    }
}

// MARK: - Extensions

extension AdView {
    struct Constants {
        static let backgroundOpacity: CGFloat = 0.5
        static let loaderScale: CGFloat = 2.0
        static let backgroundColor = Color(hex: "#BEC8FF")
    }
}

#Preview {
    AdView()
}
