//
//  APIController.swift
//  Today In History
//
//  Created by Brandi Taylor on 10/7/20.
//

import Foundation

class APIController {
    
    var events: [Event] = []
    var event: Event?
    var date: String?
    
    typealias CompletionHandler = (Error?) -> Void
    
    private var baseURL = URL(string: "https://byabbe.se/on-this-day")
    
    func getSelectedEvents(month: String, day: String, completion: @escaping CompletionHandler = { _ in }) {
        
        let selectedDayURL = baseURL?.appendingPathComponent("/\(month)/\(day)/events.json")
        
        let requestURL = URLRequest(url: selectedDayURL!)
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            if error != nil {
                completion(error)
                return
            }
            
            guard let data = data else {
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let events = try decoder.decode(Results.self, from: data)
                self.events = events.data!
                self.date = events.date
                completion(nil)
            } catch {
                completion(error)
                return
            }
        }
        task.resume()
    }
}
