//
//  ColorClient.swift
//  colorbox
//
//  Created by Nick O'Neill on 3/2/16.
//  Copyright © 2016 That Thing in Swift. All rights reserved.
//

import Foundation

class ColorClient {
    static let sharedClient = ColorClient()

    func getColors(completion: ([ColorBox]) -> ()) {
        get(clientURLRequest("videosrc/colors.json")) { (success, object) in
            var colors: [ColorBox] = []

            if let object = object as? Dictionary<String, AnyObject> {
                if let results = object["results"] as? [Dictionary<String, AnyObject>] {
                    for result in results {
                        if let color = ColorBox(json: result) {
                            colors.append(color)
                        }
                    }
                }
            }

            completion(colors)
        }
    }

    private func get(request: NSMutableURLRequest, completion: (success: Bool, object: AnyObject?) -> ()) {
        dataTask(request, method: "GET", completion: completion)
    }

    private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: NSURL(string: "https://thatthinginswift.com/"+path)!)

        return request
    }

    private func dataTask(request: NSMutableURLRequest, method: String, completion: (success: Bool, object: AnyObject?) -> ()) {
        request.HTTPMethod = method

        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())

        session.dataTaskWithRequest(request) { (data, response, error) -> Void in
            if let data = data {
                let json = try? NSJSONSerialization.JSONObjectWithData(data, options: [])
                if let response = response as? NSHTTPURLResponse where 200...299 ~= response.statusCode {
                    completion(success: true, object: json)
                } else {
                    completion(success: false, object: json)
                }
            }
        }.resume()
    }
}