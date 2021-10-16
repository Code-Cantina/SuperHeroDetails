//
//  NetworkManager.swift
//  CantinaHero
//
//  Created by Danny Copeland on 8/20/21.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseUrl = "https://superheroapi.com/api/"
    let cache = NSCache<NSString, UIImage>()
    
    private let heroApiToken = "" // GET Your Own Key from https://superheroapi.com
    
    //https://superheroapi.com/api/access-token/search/name
    
    private init() {}

    // method to get search results for provided string
    func fetchSearchResults(for heroName: String, completed: @escaping (Swift.Result<SuperHero, HeroDataError>) -> Void) {
        let endPoint = "/search/"
        let fullUrl = baseUrl + "\(heroApiToken)\(endPoint)\(heroName)"
        
        guard let url = URL(string: fullUrl) else {
            completed(.failure(.invalidHeroName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error { //if the error exists
                completed(.failure(.unableToComplete))
                return
            }
           
            //if the response is not nil, set it to response var.. check response status code for 200, else do the block
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                //something other than 200.. or nil response?
                completed(.failure(.invalidResponse))
                return
            }
            //check the data if we make it here
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
           
            //parse the data
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let heros = try decoder.decode(SuperHero.self, from: data)
                
                completed(.success(heros))
                
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume() //start the network call
    }
    
    // method to fetch image
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return //since we have the cached image return
        }
        
        //intentionally not handling errors for hero images, since the place holder image will be used
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
            }
            
            self.cache.setObject(image, forKey: cacheKey) //set the image cache
            completed(image)
            
        }
        task.resume()
    }

}


enum HeroDataError: String, Error {
    case invalidHeroName = "This hero name created and invalid request. Please try again"
    case unableToComplete = "Unable to completed request, check internet connection."
    case invalidResponse = "Invalid response from server."
    case invalidData = "The data received from server is invalid"
}
