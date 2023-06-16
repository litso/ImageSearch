//
//  SearchResultsView.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import ExamineImageFeature
import Kingfisher
import Models
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
        List {
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
        }
        .fullScreenCover(item: $viewModel.fullScreenImage) { content in
            ExamineImageView(
                viewModel: ExamineImageViewModel(imageURL: content.link)
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
        .onAppear {
            self.viewModel.loadMedia()
        }
    }
}
