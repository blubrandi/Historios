//
//  StarredEvent.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import Foundation

struct BookmarkedEvent: Codable, Equatable {
    
    var year: String
    var date: String
    var text: String
    var links: [Link]
    var isBookmarked: Bool
    var id: String = UUID().uuidString
    
    init(date: String, year: String, text: String, links: [Link], isBookmarked: Bool = true) {
        self.date = date
        self.year = year
        self.text = text
        self.links = links
        self.isBookmarked = isBookmarked
    }
    
    static func == (lhs: BookmarkedEvent, rhs: BookmarkedEvent) -> Bool {
        return lhs.id == rhs.id
    }
}
