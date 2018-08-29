//
//  networking.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import Foundation

/**Based on Network Unit Testing in Swift*/
class HttpClient {
    typealias completeClosure = ( _ data: Data?, _ error: Error?)->Void
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func post( url: URL, body:Data?, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = body
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, error)
        }
        task.resume()
    }
}
