//
//  FavoritesView.swift
//  
//
//  Created by Robert Manson on 7/10/23.
//

import ExamineImageFeature
import Kingfisher
import Models
import SharedViews
import SwiftUI

public struct FavoritesView: View {
    @ObservedObject public var viewModel: FavoritesViewModel

    public init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        NavigationStack {
            List {
                if viewModel.favoritesStore.recentMedia.isEmpty {
                    Text("Nothing recently viewed yet...")
                } else {
                    ForEach(viewModel.favoritesStore.recentMedia) { media in
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
                }
            }
            .onAppear {
                viewModel.loadSaved()
            }
            .fullScreenCover(item: $viewModel.fullScreenImage) { media in
                ExamineImageView(
                    viewModel: ExamineImageViewModel(media: media, favoritesStore: viewModel.favoritesStore)
                )
            }
            .navigationTitle("Recently Viewed")
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView(
            viewModel: FavoritesViewModel(favoritesStore: FavoritesStore.mock())
        )
    }
}
