//
//  SearchResultsTests.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import XCTest

@testable import Models

final class SearchResultsTests: XCTestCase {
    static let searchResultsJSON =
    """
    {
       "data" : [
            \(GalleryTests.galleryJSON)
        ]
    }
    """

    var decoder: JSONDecoder!

    override func setUpWithError() throws {
        decoder = JSONDecoder()
    }

    override func tearDownWithError() throws {
        decoder = nil
    }

    func testDecode() throws {
        let searchResults = try decoder.decode(SearchResults.self, from: Data(SearchResultsTests.searchResultsJSON.utf8))
        XCTAssertEqual(searchResults.data.count, 1)
    }
}
