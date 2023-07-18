//
//  FavoritesStore.swift
//  
//
//  Created by Robert Manson on 7/10/23.
//

import Foundation

public final class FavoritesStore: ObservableObject {
    @Published public var recentMedia: [Media]

    private let saveToDisk: (_ media: [Media]) throws -> Void
    private let readFromDisk: () throws -> [Media]


    public static func saveToUserDefaults(_ media: [Media]) throws -> Void {
        let encodedData = try JSONEncoder().encode(media)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: "favorites")
    }

    public static func readFromUserDefaults() throws -> [Media] {
        let userDefaults = UserDefaults.standard
        if let savedData = userDefaults.object(forKey: "favorites") as? Data {
            let savedFavorites = try JSONDecoder().decode([Media].self, from: savedData)
            return savedFavorites
        }

        return []
    }

    public init(
        saveToDisk: @escaping (_ media: [Media]) throws -> Void = FavoritesStore.saveToUserDefaults,
        readFromDisk: @escaping () throws -> [Media] = FavoritesStore.readFromUserDefaults
    ) {
        self.saveToDisk = saveToDisk
        self.readFromDisk = readFromDisk

        recentMedia = (try? readFromDisk()) ?? []
    }

    public func upsert(_ recent: Media) throws {
        if let index = recentMedia.firstIndex(where: { $0.link.absoluteURL == recent.link.absoluteURL }) {
            recentMedia[index] = recent
        } else {
            recentMedia.insert(recent, at: 0)
        }

        try saveToDisk(recentMedia)
    }

    public func delete(_ media: Media) throws {
        recentMedia.removeAll(where: { $0.id == media.id })
        try saveToDisk(recentMedia)
    }
}

public extension FavoritesStore {
    static func mock(
        initialMedia: [Media] = []
    ) -> FavoritesStore {
        .init(
            saveToDisk: { _ in return },
            readFromDisk: {
                initialMedia
            }
        )
    }
}
