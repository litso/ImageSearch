//
//  SearchResultsViewModel.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import Combine
import Foundation
import ImgurClient
import Models


public class SearchResultsViewModel: ObservableObject {
    struct AlertMessage: Identifiable {
        enum Kind {
            case networkError(Error)
        }
        var id = UUID()
        let kind: Kind

        var title: String {
            switch kind {
            case .networkError:
                return "Error Connecting to Imgur"
            }
        }

        var message: String {
            switch kind {
            case .networkError(let error):
                return error.localizedDescription
            }
        }
    }

    @Published var allMedia = [Media]()
    @Published var alert: AlertMessage?
    @Published var fullScreenImage: Media?
    @Published var searchText = ""
    @Published var isSearching = false

    var page = 0
    private var loadMediaCancellable: AnyCancellable?
    private let imgurClient: ImgurClient
    let favoritesStore: FavoritesStore

    init(
        imgurClient: ImgurClient,
        favoritesStore: FavoritesStore
    ) {
        self.imgurClient = imgurClient
        self.favoritesStore = favoritesStore
    }

    public convenience init() {
        self.init(imgurClient: ImgurClient(), favoritesStore: FavoritesStore())
    }

    func perfromImageSearch() {
        let query = searchText == "" ? "Under Construction" : searchText

        guard !isSearching else {
            return
        }

        isSearching = true
        loadMediaCancellable = imgurClient.searchMedia(query: query, page: page)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isSearching = false
                    switch completion {
                    case .failure(let error):
                        self?.alert = .init(
                            kind: .networkError(error)
                        )
                    case .finished: break
                    }
                },
                receiveValue: { [weak self] searchResults in
                    let media: [Media] = searchResults.data.map {
                        $0.media
                    }.flatMap { $0 }
                    .filter {
                        !$0.animated
                    }
                    self?.allMedia = media
                }
            )
    }
}
