//
//  MediaLoadingView.swift
//  
//
//  Created by Robert Manson on 6/15/23.
//

import SwiftUI

struct MediaLoadingView: View {
    @State private var isRotating = 0.0

    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .font(.largeTitle)
            .opacity(0.3)
            .rotationEffect(.degrees(isRotating))
            .onAppear {
                withAnimation(
                    .linear(duration: 3)
                    .repeatForever(autoreverses: false)
                ) {
                    isRotating = 360.0
                }
            }
    }
}
