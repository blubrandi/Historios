//
//  StarredEvent.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import Foundation

struct BookmarkedEvent: Codable {
    
    var year: String
    var text: String
    var links: [BookmarkedEventLink]
    var isBookmarked: Bool
    
}

struct BookmarkedEventLink: Codable {
    var title: String
    var url: URL
}
