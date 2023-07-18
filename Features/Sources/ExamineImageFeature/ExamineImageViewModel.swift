//
//  ExamineImageViewModel.swift
//  
//
//  Created by Robert Manson on 6/16/23.
//

import Combine
import Models
import SwiftUI

public final class ExamineImageViewModel: ObservableObject {
    struct AlertMessage: Identifiable {
        enum Kind {
            case favoriteError(Error)
        }
        var id = UUID()
        let kind: Kind

        var title: String {
            switch kind {
            case .favoriteError:
                return "Error Saving Favorite"
            }
        }

        var message: String {
            switch kind {
            case .favoriteError(let error):
                return error.localizedDescription
            }
        }
    }

    @Published var scale: CGFloat = 1.0
    @Published private(set) var isFavorite: Bool
    @Published var alert: AlertMessage?
    var anyCancellable: AnyCancellable?
    let media: Media
    let favoritesStore: FavoritesStore

    public init(
        media: Media,
        favoritesStore: FavoritesStore
    ) {
        self.media = media
        self.isFavorite = false
        self.favoritesStore = favoritesStore

        anyCancellable = favoritesStore
            .$recentMedia
            .receive(on: DispatchQueue.main)
            .sink { [weak self] allMedia in
                self?.isFavorite = allMedia.contains(where: { $0.id == media.id })
            }
    }

    func toggleFavorite() {
        do {
            if isFavorite {
                try favoritesStore.delete(media)
            } else {
                try favoritesStore.upsert(media)
            }
        } catch  {
            alert = AlertMessage(kind: .favoriteError(error))
        }
    }
}
