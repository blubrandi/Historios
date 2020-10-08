//
//  Event.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import Foundation

import Foundation

struct Results: Codable {
    var date: String
    var url: String
    var data: Events
}

struct Events: Codable {
    var events: [Event]
    
    enum CodingKeys: String, CodingKey {
        case events = "Events"
    }
}

struct Event: Codable {
    var year: String
    var text: String
    var links: [Link]
}

struct Link: Codable {
    var title: String
    var url: URL

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "link"
    }
}
