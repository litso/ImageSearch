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

            KFImage(viewModel.imageURL)
                .placeholder {
                    MediaLoadingView()
                }
                .onFailure { e in
                    // TODO: Better error handling
                    print("Error loading image: \(viewModel.imageURL): \(e)")
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
                .toolbar(.visible, for: .automatic)
                .toolbar {
                    Button("Close", action: { })
                }

            VStack() {
                HStack {
                    Spacer()
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
    }
}

struct ExamineImageView_Previews: PreviewProvider {
    static var previews: some View {
        ExamineImageView(
            viewModel: ExamineImageViewModel(
                imageURL: URL(string: "https://i.imgur.com/zF8rUNX.jpg")!
            )
        )
    }
}
