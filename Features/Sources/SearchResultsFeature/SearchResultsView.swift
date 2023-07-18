//
//  SearchResultsView.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import ExamineImageFeature
import Kingfisher
import Models
import FavoritesFeature
import SharedViews
import SwiftUI

public struct SearchResultsView: View {
    @ObservedObject var viewModel: SearchResultsViewModel

    public init(
        viewModel: SearchResultsViewModel = SearchResultsViewModel()
    ) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    FavoritesView(viewModel: FavoritesViewModel(favoritesStore: viewModel.favoritesStore))
                } label: {
                    Text("Recently Viewed")
                }
                .padding()

                if !viewModel.isSearching {
                    ForEach(viewModel.allMedia) { media in
                        Button(action: {
                            viewModel.fullScreenImage = media
                        }) {
                            KFImage(media.link)
                                .placeholder {
                                    MediaLoadingView()
                                }
                                .onFailure { e in
                                    // TODO: Better error handling
                                    print("Error loading image: \(media.link.absoluteString): \(e)")
                                }
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .cornerRadius(20.0)
                        }
                    }
                    .listRowInsets(
                        .init(top: 0, leading: 0, bottom: 20, trailing: 0)
                    )
                    .listRowBackground(Color.clear)
                    .listStyle(.plain)
                } else {
                    if viewModel.searchText.isEmpty {
                        Text("Loading...")
                            .italic()
                    } else {
                        Text("Searching \(viewModel.searchText)...")
                            .italic()
                    }
                }
            }
            .onAppear {
                if viewModel.allMedia.count == 0 && viewModel.searchText == "" {
                    // Load a search to avoid showing an empty screen initially
                    viewModel.perfromImageSearch()
                }
            }
            .fullScreenCover(item: $viewModel.fullScreenImage) { media in
                ExamineImageView(
                    viewModel: ExamineImageViewModel(media: media, favoritesStore: viewModel.favoritesStore)
                )
            }
            .alert(
                item: $viewModel.alert,
                content: { alertMessage in
                    Alert(
                        title: Text(alertMessage.title),
                        message: Text(alertMessage.message)
                    )
                }
            )
        }
        .searchable(text: $viewModel.searchText)
        .onSubmit(of: .search, viewModel.perfromImageSearch)
    }
}
