//
//  Gallery.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import Foundation

public struct Gallery: Identifiable {
    public let id: String
    public let title: String
    public let media: [Media]
}

extension Gallery: Decodable {
    public enum CodingKeys: String, CodingKey {
        case id
        case title
        case media = "images"
    }
}
