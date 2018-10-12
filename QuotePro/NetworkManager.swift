//
//  NetworkManager.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import Foundation

enum NetworkManagerAPIError: Error {
  case badURL
  case requestError
  case invalidJSON
  case badCredentials
}

class NetworkManager {
  
  static let shared = NetworkManager()
  
  private let FORISMATIC_URL = "http://api.forismatic.com/api/1.0/?method=getQuote&lang=en&format=json"
  private let IMGUR_URL = "https://api.imgur.com/3/gallery/hOF1g"
  private let DATA_KEY = "data"
  private let IMAGES_COUNT_KEY = "images_count"
  private let IMAGES_KEY = "images"
  private let LINK_KEY = "link"
  private let IMGUR_CLIENT_ID = "a9a2f1a3769a31e"

  private func get (toEndpoint: String, authHeader: Bool, completion: @escaping  (Data?, Error?)->(Void)){

    let url = URL(string: toEndpoint)!
    let request = NSMutableURLRequest(url: url)
    request.httpMethod = "GET"
    
    if authHeader{
      request.setValue("Client-ID \(IMGUR_CLIENT_ID)", forHTTPHeaderField: "Authorization")
    }
      
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")

    let task = URLSession.shared.dataTask(with: request as URLRequest) { (data: Data?, response: URLResponse?, error: Error?) in
      
      guard let data = data else {
        print("no data returned from server \(String(describing: error?.localizedDescription))")
        return
      }
      
      guard let response = response as? HTTPURLResponse else {
        print("no response returned from server \(String(describing: error))")
        completion(nil, NetworkManagerAPIError.requestError)
        return
      }
      guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, Any> else {
        print("data returned is not json, or not valid")
        completion(nil, NetworkManagerAPIError.invalidJSON)
        return
      }
      
      guard response.statusCode == 200 else {
        // handle error
        print("an error occurred mac")
        completion(nil, NetworkManagerAPIError.badCredentials)
        return
      }
      
      // do something with the json object
      completion(data, nil)
      
    }
    
    task.resume()
  }

  func getQuote(completion: @escaping  (Quote?, Error?)->(Void)){

    if let url = URL.init(string: FORISMATIC_URL) {
      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        print(String.init(data: data!, encoding: .ascii) ?? "no data")
        if let newQuote = try? JSONDecoder().decode(Quote.self, from: data!) {
            completion(newQuote, nil)
        }
      })
      task.resume()
    }
  }
  
  func getImageURL(completion: @escaping  (Photo?, Error?)->(Void)){
    get(toEndpoint: IMGUR_URL, authHeader: true) { (data, error) -> (Void) in
      guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: [])  as? [String: Any] else {
        print("data returned is not json, or not valid")
        completion(nil, NetworkManagerAPIError.invalidJSON)
        return
      }
      
      if let json = json{
        guard let dataDictionary = json[self.DATA_KEY] as? [String: Any] else{
            completion(nil, NetworkManagerAPIError.invalidJSON)
            return
        }

        guard let imageArray = dataDictionary[self.IMAGES_KEY] as? [[String: Any]] else{
          completion(nil, NetworkManagerAPIError.invalidJSON)
          return
        }
        let randomIndex = Int(arc4random_uniform(UInt32(imageArray.count)))
        
        let element = imageArray[randomIndex]
        
        guard let link = element[self.LINK_KEY] as? String else{
          completion(nil, NetworkManagerAPIError.invalidJSON)
          return
        }
        let photo = Photo(urlString: link)
        
        completion(photo, nil)
        return
      }
      
    }
    
  }
}
