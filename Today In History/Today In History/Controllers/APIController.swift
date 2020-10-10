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
    
    typealias CompletionHandler = (Error?) -> Void
    
    private var baseURL = URL(string: "https://history.muffinlabs.com/date")

    func getEventsForToday(completion: @escaping CompletionHandler = { _ in }) {
        
        let date = Date()
        let monthString = date.monthNumberAsString
        let dayString = date.day
        
        let todayURL = baseURL?.appendingPathComponent("/\(monthString)/\(dayString)")
        
        var requestURL = URLRequest(url: todayURL!)
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            if error != nil {
                print(error)
                print("We hit error")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("We hit data")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                print("We hit decode")
                var events = try decoder.decode(Results.self, from: data)
                self.events = events.data.events
                print("From network call", events.data.events.count)
                print(response)
                
//                print(requestURL)
                completion(nil)
            } catch {
                print("We hit catch")
                print(error)
                completion(error)
                return
            }
        }
        task.resume()
    }
    
    func getSelectedEvents(month: String, day: String, completion: @escaping CompletionHandler = { _ in }) {
        
        let selectedDayURL = baseURL?.appendingPathComponent("/\(month)/\(day)")
        
        var requestURL = URLRequest(url: selectedDayURL!)
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            if error != nil {
                print(error)
                print("We hit error")
                completion(error)
                return
            }
            
            guard let data = data else {
                print("We hit data")
                completion(NSError())
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                print("We hit decode")
                var events = try decoder.decode(Results.self, from: data)
                self.events = events.data.events
                print("From network call", events.data.events.count)
                print(response)
                
//                print(requestURL)
                completion(nil)
            } catch {
                print(requestURL)
                print("We hit catch")
                print(error)
                completion(error)
                return
            }
        }
        task.resume()
    }
}
