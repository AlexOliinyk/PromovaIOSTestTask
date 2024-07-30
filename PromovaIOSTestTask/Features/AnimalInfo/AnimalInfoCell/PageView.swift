//
//  PageView.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 30/7/24.
//

import SwiftUI

import SwiftUI

struct PageView<Content: View>: View {
    let pageCount: Int
    @Binding var currentIndex: Int
    let content: Content
    
    @GestureState private var translation: CGFloat = .zero
    
    init(
        pageCount: Int,
        currentIndex: Binding<Int>,
        @ViewBuilder content: () -> Content
    ) {
        self.pageCount = pageCount
        self._currentIndex = currentIndex
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: .zero) {
                content.frame(width: geometry.size.width)
            }
            .frame(width: geometry.size.width * CGFloat(pageCount), alignment: .leading)
            .offset(x: -CGFloat(currentIndex) * geometry.size.width)
            .offset(x: translation)
            .gesture(
                DragGesture()
                    .updating($translation) { value, state, _ in
                        state = value.translation.width
                    }
                    .onEnded { value in
                        let offset = value.translation.width / geometry.size.width
                        let newIndex = (CGFloat(currentIndex) - offset).rounded()
                        currentIndex = min(max(Int(newIndex), 0), pageCount - 1)
                    }
            )
            .animation(.easeInOut, value: currentIndex)
        }
    }
}
