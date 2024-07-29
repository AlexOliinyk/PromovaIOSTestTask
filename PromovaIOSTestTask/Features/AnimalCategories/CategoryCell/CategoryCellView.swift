//
//  CategoryCellView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import SwiftUI

struct CategoryCellView: View {
    
    let animalFact: AnimalFact
    
    var body: some View {
        ZStack {
            rowContent()

            if animalFact.status == .comingSoon {
                ComingSoonView()
            }
        }
        .frame(height: Constants.Cell.height)
        .cornerRadius(Constants.Cell.cornerRadius)
    }

    private func rowContent() -> some View {
        HStack(alignment: .top, spacing: .zero) {
            image()
            content()
            Spacer(minLength: Constants.Content.trailingPadding)
        }
        .background(Constants.Colors.background)
    }

    private func image() -> some View {
        ImagePlaceholder(url: animalFact.image)
            .aspectRatio(contentMode: .fill)
            .frame(width: Constants.Picture.width, height: Constants.Picture.height)
            .cornerRadius(Constants.Picture.cornerRadius)
            .padding([.top, .leading, .bottom], Constants.Picture.padding)
    }

    private func content() -> some View {
        VStack(alignment: .leading) {
            Text(animalFact.title)
                .font(Constants.Fonts.title)
                .foregroundColor(Constants.Colors.title)
            Text(animalFact.description)
                .font(Constants.Fonts.description)
                .foregroundColor(Constants.Colors.description)
            Spacer()

            if animalFact.status == .paid {
                premiumLabel()
            }
        }
        .lineLimit(Constants.Content.lineLimit)
        .padding(.vertical, Constants.Content.verticalPadding)
        .padding(.leading, Constants.Content.leadingPadding)
    }
    
    private func premiumLabel() -> some View {
        HStack {
            Text("\(Image(systemName: Constants.Picture.premiumBadge)) \(Constants.Content.premiumLabelText)")
                .foregroundColor(Constants.Colors.premiumLabel)
        }
    }
}

// MARK: - Extensions

extension CategoryCellView {
    
    struct Constants {
        struct Colors {
            static let title: Color = .black
            static let description: Color = .black.opacity(0.5)
            static let placeholder: Color = .gray.opacity(0.7)
            static let premiumLabel: Color = .blue
            static let background: Color = .white
        }

        struct Picture {
            static let width: CGFloat = 120.0
            static let height: CGFloat = 90.0
            static let padding: CGFloat = 5.0
            static let cornerRadius: CGFloat = 6.0
            static let premiumBadge: String = "lock.fill"
        }

        struct Fonts {
            static let title: Font = .custom("Basic", size: 17.0)
            static let description: Font = .custom("Basic", size: 12.0)
        }

        struct Content {
            static let verticalPadding: CGFloat = 10.0
            static let trailingPadding: CGFloat = 16.0
            static let leadingPadding: CGFloat = 16.0
            static let lineLimit: Int = 2
            static let premiumLabelText: String = "Premium"
        }

        struct Cell {
            static let height: CGFloat = 100.0
            static let cornerRadius: CGFloat = 6.0
        }
    }
}

struct Constants {
    static let backgroundColor: Color = Color("#BEC8FF")
}


#Preview {
    ZStack {
        Color.gray
            .ignoresSafeArea(.all, edges: .all)
        VStack {
            CategoryCellView(animalFact: .mockFree)
            CategoryCellView(animalFact: .mockPaid)
            CategoryCellView(animalFact: .mockComingSoon)
        }
        .padding(.horizontal)
    }
}
