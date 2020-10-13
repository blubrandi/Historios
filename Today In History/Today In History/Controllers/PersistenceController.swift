//
//  PersistentController.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/10/20.
//

import Foundation

class PersistenceController {
    
    var bookmarkedEvents: [BookmarkedEvent] = []
    
    func createBookmarkedEvent(withText text: String, withYear year: String, withLinks links: [BookmarkedEventLink], isBookmarked: Bool) -> BookmarkedEvent {
        
        let starredEvent = BookmarkedEvent(year: year, text: text, links: links, isBookmarked: true)
        bookmarkedEvents.append(starredEvent)
        
        saveToPersistence()
        
        return starredEvent
    }
    
    private var bookmarkedEventsURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        return dir.appendingPathComponent("BookmarkedEvents.plist")
    }
    
    func saveToPersistence() {
        
        let encoder = PropertyListEncoder()
        
        do {
            let data = try encoder.encode(bookmarkedEvents)
            guard let url = bookmarkedEventsURL else { return }
            try data.write(to: url)
        } catch {
            print("Could not save detected to persistence")
        }
    }
    
     func loadFromPersistence() {
         let fm = FileManager.default
         
         do {
             guard let url = bookmarkedEventsURL,
                   fm.fileExists(atPath: url.path) else { return }
                 let data = try Data(contentsOf: url)
                 let decoder = PropertyListDecoder()
             
             bookmarkedEvents = try decoder.decode([BookmarkedEvent].self, from: data)
             print("Count from persisitence load: ", bookmarkedEvents.count)
         } catch {
             print("Could not load starred events from persistence")
         }
     }
}
