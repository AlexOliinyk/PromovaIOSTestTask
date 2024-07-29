//
//  ImagePlaceholder.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import SwiftUI

struct ImagePlaceholder: View {
    let url: String

    var body: some View {
        AsyncImage(url: URL(string: url)) { phase in
            switch phase {
            case .empty:
                imagePlaceholder()
            case .failure:
                Image(Constants.placeholderImage)
                    .resizable()
            case let .success(image):
                image.resizable()
            @unknown default:
                EmptyView()
            }
        }
    }

    private func imagePlaceholder() -> some View {
        ZStack {
            Rectangle()
                .fill(Constants.backgroundColor)
            ProgressView()
        }
    }
}

// MARK: - Extensions

extension ImagePlaceholder {
    struct Constants {
        static let placeholderImage: String = "placeholder"
        static let backgroundColor: Color = Color.gray
    }
}
