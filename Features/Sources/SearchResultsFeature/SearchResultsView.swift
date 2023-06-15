//
//  SearchResultsView.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import Kingfisher
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
                    .listRowInsets(.init(.zero))
                    .ignoresSafeArea()
            }
            .listStyle(.plain)
        }
        .ignoresSafeArea()
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
