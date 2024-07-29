//
//  ComingSoonView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import SwiftUI

struct ComingSoonView: View {
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .opacity(Constants.backgroundOpdacity)
            image()
        }
    }

    private func image() -> some View {
        HStack {
            Spacer()
            Image(Constants.image)
                .resizable()
                .scaledToFit()
        }
    }
}

// MARK: - Extensions

extension ComingSoonView {
    struct Constants {
        static let backgroundColor: Color = .black
        static let backgroundOpdacity: CGFloat = 0.6
        static let image: String = "comingSoon"
    }
}

// MARK: - Preview

#Preview {
    ComingSoonView()
        .frame(height: 100)
        .padding(.horizontal)
}
