//
//  AnimalFacts+Preview.swift
//  PromovaIOSTestTask
//
//  Created by Oleksandr Oliinyk on 29/7/24.
//

import Foundation

extension AnimalFact {
    
    static var mockFree: AnimalFact {
        AnimalFact(
            id: UUID(),
            title: "Free content",
            description: "Free",
            image: "https://picsum.photos/315/234",
            order: 1,
            status: .free,
            content: Content.freeMock
        )
    }
    
    static var mockPaid: AnimalFact {
        AnimalFact(
            id: UUID(),
            title: "Paid content",
            description: "Paid",
            image: "https://picsum.photos/315/234",
            order: 2,
            status: .paid,
            content: Content.paidMock
        )
    }
    
    static var mockComingSoon: AnimalFact {
        AnimalFact(
            id: UUID(),
            title: "Coming Soon content",
            description: "Coming Soon ...",
            image: "https://picsum.photos/315/234",
            order: 3,
            status: .comingSoon,
            content: Content.paidMock
        )
    }
}

extension Content {
    
    static var freeMock: [Content] {
        [
            Content(
                fact: "some FREE fact about animal",
                image: "https://picsum.photos/315/234", 
                id: UUID()
            ),
            Content(
                fact: "some very interesting FREE fact about animal",
                image: "https://picsum.photos/315/234",
                id: UUID()
            ),
        ]
    }
    
    static var paidMock: [Content] {
        [
            Content(
                fact: "some PAID fact about animal",
                image: "https://picsum.photos/315/234",
                id: UUID()
            ),
            Content(
                fact: "some very interesting PAID fact about animal",
                image: "https://picsum.photos/315/234",
                id: UUID()
            ),
        ]
    }
}
