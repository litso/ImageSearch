//
//  Media.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import Foundation

public struct Media: Identifiable, Codable {
    public let id: String
    public let link: URL
    public let animated: Bool
    public let height: Int
    public let width: Int
}

public extension Media {
    static func mock() -> Media {
        .init(
            id: "123",
            link: URL(string: "https://i.imgur.com/zF8rUNX.jpg")!,
            animated: false,
            height: 100,
            width: 100
        )
    }
}
