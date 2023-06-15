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
    var page = 0
    private var cancellable: AnyCancellable?
    private let imgurClient: ImgurClient

    init(imgurClient: ImgurClient) {
        self.imgurClient = imgurClient
    }

    public init() {
        self.imgurClient = ImgurClient()
    }

    func loadMedia() {
        cancellable = imgurClient.searchMedia(query: "cats", page: page)
            .sink(
                receiveCompletion: { [weak self] completion in
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
                    self?.allMedia.append(contentsOf: media)
                    self?.page += 1
                }
            )
    }
}
