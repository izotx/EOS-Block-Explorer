//
//  BlockchainClasses.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import Foundation

struct BlockInfo:Decodable{
    let block_num:Int
    let previous:String
    let producer:String
    let producer_signature:String
    let transactions:[Transaction]
}

struct Transaction:Decodable{
    let status:String
}

struct API{
    static let PRODUCER_URL = "https://api.eosnewyork.io"
    static let INFO_ENDPOINT = "v1/chain/get_info"
    static let GET_BLOCK_ENDPOINT = "v1/chain/get_block"
}


struct ChainInfo:Decodable{
    let lastBlock:Int
    enum CodingKeys : String, CodingKey {
        case lastBlock = "last_irreversible_block_num"
    }
}

class APIOperations
{
    
    var client:HttpClient!
    var counter = 0
    var max = 20
    var array = [BlockInfo]()
    var pending = [String:Bool]()
    
    
    init(_ client:HttpClient){
        self.client = client
    }
    
    func getGeneralInfo(completion:@escaping (ChainInfo?)->Void){
        let urlString = "\(API.PRODUCER_URL)/\(API.INFO_ENDPOINT)"
        
        guard let url = URL(string:urlString ) else{
            print("error \(urlString)")
            
            return
        }
        client.post(url: url, body: nil) { (data, error) in
            
            guard let data = data, error == nil else {
                print("error=\(error.debugDescription)")
                return
            }
            
            guard let info = try? JSONDecoder().decode(ChainInfo.self, from: data) else{
                print("debug description")
                return
            }
            //        print(info)
            completion(info)
        }
    }
    
    func getBlockContents(block:String,  completion: @escaping (BlockInfo?)->Void){
        let urlString = "\(API.PRODUCER_URL)/\(API.GET_BLOCK_ENDPOINT)"
        
        guard let url = URL(string:urlString ) else{
            print("error \(urlString)")
            
            return
        }
        
        let json: [String: Any] = ["block_num_or_id":block]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        client.post(url: url, body: jsonData) { (data, error) in
            guard let data = data, error == nil else {
                print("error=\(error.debugDescription)")
                return
            }
            
            let info = try! JSONDecoder().decode(BlockInfo.self, from: data)
            print("Block")
            print(info.block_num)
            completion(info)
        }
    }
    
    
    func downloadBlockData(blockid:String){
        print("Downloading")
        print(array.count)
        print("\n \n")
        
        if array.count == max{
            
            return
        }
        pending[blockid] = true
        
        getBlockContents(block:blockid) { (info) in
            if let info = info{
                //remove from pending
                //add to array
                //Call download 20
                print("Downloaded \(info.block_num)")
                self.array.append(info)
                self.downloadBlockData(blockid: info.previous)
            }else{
                //Don't call anything
                print("Some Error")
            }
        }
    }

    
    
}


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
            
            if let data = data, let body_response = String(data: data, encoding: String.Encoding.utf8) {
                print(body_response)
            }
            
            callback(data, error)
        }
        task.resume()
    }
}
