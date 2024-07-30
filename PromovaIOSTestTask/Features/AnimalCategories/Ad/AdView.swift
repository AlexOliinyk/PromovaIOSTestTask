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
            Color.white
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
    }
}

#Preview {
    AdView()
}
