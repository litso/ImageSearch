//
//  ExamineImageViewModel.swift
//  
//
//  Created by Robert Manson on 6/16/23.
//

import SwiftUI

public final class ExamineImageViewModel: ObservableObject {
    @Published var scale: CGFloat = 1.0
    let imageURL: URL

    public init(imageURL: URL) {
        self.imageURL = imageURL
    }
}
