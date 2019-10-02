//
//  MediaController.swift
//  Where2Stream
//
//  Created by Landon Epps on 10/2/19.
//  Copyright © 2019 Landon Epps. All rights reserved.
//

import UIKit

class ShowsController {
    
    let baseURL = URL(string: "https://utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com/lookup")!
    var shows: [Show]?
    
    func findShowsWith(searchTerm: String, completionHandler: @escaping () -> Void) {
        if searchTerm.isEmpty {
            print("Search term is blank.")
            return
        }
        
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let searchQuery = URLQueryItem(name: "term", value: searchTerm)
        let countryQuery = URLQueryItem(name: "country", value: "us")
        urlComponents?.queryItems = [searchQuery, countryQuery]
        
        guard let finalURL = urlComponents?.url else {
            print("Could not build URL.")
            return
        }
        
        print(finalURL)
        
        var request = URLRequest(url: finalURL)
        request.addValue("utelly-tv-shows-and-movies-availability-v1.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        request.addValue(Secrets.apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print("Error in getting shows at url: \(finalURL): \n \(error.localizedDescription) \n---\n \(error)")
                completionHandler()
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Unknown response.")
                completionHandler()
                return
            }
            
            guard let data = data else {
                print("No data in response.")
                completionHandler()
                return
            }
            
            print("Status code: \(httpResponse.statusCode)")
            
            do {
                let jd = JSONDecoder()
                self.shows = try jd.decode(UtellyQueryResult.self, from: data).results
                completionHandler()
            } catch {
                print("Cannot decode JSON data.")
                completionHandler()
                return
            }
        }.resume()
    }
    
    func getImageFor(show: Show, completionHandler: @escaping (UIImage?) -> Void) {
        getImageAt(url: show.imageURL) { image in
            completionHandler(image)
        }
    }
    
    func getImageFor(service: StreamingService, completionHandler: @escaping (UIImage?) -> Void) {
        getImageAt(url: service.iconURL) { image in
            completionHandler(image)
        }
    }
    
    func getImageAt(url: URL, completionHandler: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("Error getting image at url: \(url) \n \(error.localizedDescription) \n---\n \(error)")
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                print("No data.")
                completionHandler(nil)
                return
            }
            
            let image = UIImage(data: data)
            completionHandler(image)
        }.resume()
    }
    
}
