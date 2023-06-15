//
//  GalleryTests.swift
//  
//
//  Created by Robert Manson on 6/14/23.
//

import XCTest

@testable import Models

final class GalleryTests: XCTestCase {
    static let galleryJSON =
    """
    {
     "account_id" : 14707515,
     "account_url" : "Laurynisabarista",
     "ad_config" : {
        "highRiskFlags" : [],
        "high_risk_flags" : [],
        "nsfw_score" : 0.2,
        "safeFlags" : [
           "album",
           "in_gallery",
           "gallery"
        ],
        "safe_flags" : [
           "album",
           "in_gallery",
           "gallery"
        ],
        "showAdLevel" : 1,
        "show_ad_level" : 1,
        "show_ads" : false,
        "showsAds" : false,
        "unsafeFlags" : [
           "sixth_mod_unsafe",
           "under_10",
           "updated_date"
        ],
        "unsafe_flags" : [
           "sixth_mod_unsafe",
           "under_10",
           "updated_date"
        ],
        "wallUnsafeFlags" : [],
        "wall_unsafe_flags" : []
     },
     "ad_type" : 0,
     "ad_url" : "",
     "comment_count" : 2,
     "cover" : "xF3gwO1",
     "cover_height" : 2048,
     "cover_width" : 1536,
     "datetime" : 1686782854,
     "description" : null,
     "downs" : 0,
     "favorite" : false,
     "favorite_count" : 0,
     "id" : "95Qazcx",
     "images" : [
        \(MediaTests.mediaJSON)
     ],
     "images_count" : 23,
     "in_gallery" : true,
     "in_most_viral" : false,
     "include_album_ads" : false,
     "is_ad" : false,
     "is_album" : true,
     "layout" : "blog",
     "link" : "https://imgur.com/a/95Qazcx",
     "nsfw" : false,
     "points" : 4,
     "privacy" : "hidden",
     "score" : 4,
     "section" : "",
     "tags" : [
        {
           "accent" : "BF63A7",
           "background_hash" : "xeEIpAn",
           "background_is_animated" : false,
           "description" : "Our feline friends",
           "description_annotations" : {},
           "display_name" : "Cats",
           "followers" : 213197,
           "following" : false,
           "is_promoted" : false,
           "is_whitelisted" : false,
           "logo_destination_url" : null,
           "logo_hash" : null,
           "name" : "cats",
           "thumbnail_hash" : null,
           "thumbnail_is_animated" : false,
           "total_items" : 135743
        },
        {
           "accent" : "2E6197",
           "background_hash" : "eWY7qg5",
           "background_is_animated" : false,
           "description" : "",
           "description_annotations" : {},
           "display_name" : "rainbow bridge",
           "followers" : 500,
           "following" : false,
           "is_promoted" : false,
           "is_whitelisted" : false,
           "logo_destination_url" : null,
           "logo_hash" : null,
           "name" : "rainbow_bridge",
           "thumbnail_hash" : null,
           "thumbnail_is_animated" : false,
           "total_items" : 2650
        },
        {
           "accent" : null,
           "background_hash" : "Ouv6Uju",
           "background_is_animated" : false,
           "description" : "Happy Love Your Pets Day!",
           "description_annotations" : {},
           "display_name" : "loveyourpets",
           "followers" : 6418,
           "following" : false,
           "is_promoted" : false,
           "is_whitelisted" : false,
           "logo_destination_url" : null,
           "logo_hash" : null,
           "name" : "loveyourpets",
           "thumbnail_hash" : null,
           "thumbnail_is_animated" : false,
           "total_items" : 13941
        },
        {
           "accent" : "83898E",
           "background_hash" : "c9WHHFu",
           "background_is_animated" : false,
           "description" : "",
           "description_annotations" : {},
           "display_name" : "orange cat",
           "followers" : 162,
           "following" : false,
           "is_promoted" : false,
           "is_whitelisted" : false,
           "logo_destination_url" : null,
           "logo_hash" : null,
           "name" : "orange_cat",
           "thumbnail_hash" : null,
           "thumbnail_is_animated" : false,
           "total_items" : 695
        },
        {
           "accent" : "5B62A5",
           "background_hash" : "iN4Gb0k",
           "background_is_animated" : false,
           "description" : "",
           "description_annotations" : {},
           "display_name" : "loss",
           "followers" : 310,
           "following" : false,
           "is_promoted" : false,
           "is_whitelisted" : false,
           "logo_destination_url" : null,
           "logo_hash" : null,
           "name" : "loss",
           "thumbnail_hash" : null,
           "thumbnail_is_animated" : false,
           "total_items" : 1142
        }
     ],
     "title" : "Mourning a loved one is difficult.",
     "topic" : null,
     "topic_id" : null,
     "ups" : 4,
     "views" : 21,
     "vote" : null
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
        let gallery = try decoder.decode(Gallery.self, from: Data(GalleryTests.galleryJSON.utf8))
        XCTAssertEqual(gallery.id, "95Qazcx")
    }
}
