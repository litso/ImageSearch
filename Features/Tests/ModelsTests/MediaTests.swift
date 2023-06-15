//
//  MediaTests.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import XCTest

@testable import Models

final class MediaTests: XCTestCase {
    static let mediaJSON =
    """
    {
       "account_id" : null,
       "account_url" : null,
       "ad_type" : 0,
       "ad_url" : "",
       "animated" : false,
       "bandwidth" : 4399269,
       "comment_count" : null,
       "datetime" : 1686780084,
       "description" : "This guy. Big boy, Boo Bay, Garfield, Buggy. He’s been with me for 8 glorious years. Yesterday due to cancer, kidney failure, thyroid issues, heart problems, we helped him cross the rainbow bridge. He was lethargic and anorexic during the end. He was 17.",
       "downs" : null,
       "edited" : "0",
       "favorite" : false,
       "favorite_count" : null,
       "has_sound" : false,
       "height" : 2048,
       "id" : "xF3gwO1",
       "in_gallery" : false,
       "in_most_viral" : false,
       "is_ad" : false,
       "link" : "https://i.imgur.com/xF3gwO1.jpg",
       "nsfw" : null,
       "points" : null,
       "score" : null,
       "section" : null,
       "size" : 209489,
       "tags" : [],
       "title" : null,
       "type" : "image/jpeg",
       "ups" : null,
       "views" : 21,
       "vote" : null,
       "width" : 1536
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
        let media = try decoder.decode(Media.self, from: Data(MediaTests.mediaJSON.utf8))

        XCTAssertEqual(media.id, "xF3gwO1")
        XCTAssertFalse(media.animated)
        XCTAssertEqual(
            media.link.absoluteString,
            "https://i.imgur.com/xF3gwO1.jpg"
        )
    }
}	
