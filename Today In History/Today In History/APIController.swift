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

    func getEvents(completion: @escaping CompletionHandler = { _ in }) {
        
        var requestURL = URLRequest(url: baseURL!)
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
}
