//
//  ExamineImageView.swift
//  
//
//  Created by Robert Manson on 6/16/23.
//

import Kingfisher
import SharedViews
import SwiftUI

public struct ExamineImageView: View {
    @ObservedObject var viewModel: ExamineImageViewModel
    @Environment(\.dismiss) var dismiss

    public init(viewModel: ExamineImageViewModel) {
        self.viewModel = viewModel
    }

    public var body: some View {
        ZStack {
            Color.primary.edgesIgnoringSafeArea(.all)

            KFImage(viewModel.media.link)
                .placeholder {
                    MediaLoadingView()
                }
                .onFailure { e in
                    // TODO: Better error handling
                    print("Error loading image: \(viewModel.media.link): \(e)")
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .scaleEffect(viewModel.scale, anchor: .center)
                .gesture(
                    MagnificationGesture()
                        .onChanged { [weak viewModel] scale in
                            viewModel?.scale = min(max(scale.magnitude, 0.5), 2.0)
                        }
                )
            VStack() {
                HStack {
                    Spacer()
                    Button {
                        viewModel.toggleFavorite()
                    } label: {
                        if viewModel.isFavorite {
                            Image(systemName: "heart.circle.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        } else {
                            Image(systemName: "heart.circle")
                                .foregroundColor(.white)
                                .font(.system(size: 20, weight: .bold))
                        }
                    }
                    .padding(.trailing)
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20, weight: .bold))
                    }
                }
                Spacer()
            }
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
}

struct ExamineImageView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineImageView(
            viewModel: ExamineImageViewModel(
                media: .mock(),
                favoritesStore: .mock()
            )
        )
    }
}
