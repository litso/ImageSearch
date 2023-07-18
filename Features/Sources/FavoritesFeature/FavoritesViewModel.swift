//
//  FavoritesViewModel.swift
//  
//
//  Created by Robert Manson on 7/10/23.
//

import Models
import SwiftUI

public final class FavoritesViewModel: ObservableObject {
    @Published var fullScreenImage: Media?
    @Published var favoritesStore: FavoritesStore

    public init(favoritesStore: FavoritesStore) {
        self.favoritesStore = favoritesStore
    }

    func loadSaved() {
        // TODO
    }
}
