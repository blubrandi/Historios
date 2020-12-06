//
//  Event.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import Foundation

struct Results: Codable {
    var date: String?
    var url: String?
    var data: [Event]?
    
    enum CodingKeys: String, CodingKey {
        case date
        case url = "wikipedia"
        case data = "events"
    }
    
}

struct Event: Codable {
    var year: String?
    var text: String?
    var links: [Link]?
    
    enum CodingKeys: String, CodingKey {
        case year
        case text = "description"
        case links = "wikipedia"
    }
}

struct Link: Codable {
    var title: String?
    var url: URL?

    enum CodingKeys: String, CodingKey {
        case title
        case url = "wikipedia"
    }
}
