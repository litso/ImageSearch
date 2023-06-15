//
//  Media.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import Foundation

public struct Media: Identifiable, Decodable {
    public let id: String
    public let link: URL
    public let animated: Bool
    public let height: Int
    public let width: Int
}
