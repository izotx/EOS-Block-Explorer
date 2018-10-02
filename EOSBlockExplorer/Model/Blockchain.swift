//
//  BlockchainClasses.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import Foundation
import CoreData

protocol Producer{
    var PRODUCER_URL:String {get}
    var INFO_ENDPOINT:String {get}
    var GET_BLOCK_ENDPOINT:String {get}
}

class NewYorkProducer:Producer{
    var PRODUCER_URL = "https://api.eosnewyork.io"
    var INFO_ENDPOINT = "https://api.eosnewyork.io/v1/chain/get_info"
    var GET_BLOCK_ENDPOINT = "https://api.eosnewyork.io/v1/chain/get_block"
}

struct ChainInfo:Decodable{
    let lastBlock:Int
    enum CodingKeys : String, CodingKey {
        case lastBlock = "last_irreversible_block_num"
    }
}


/**Responsible for retrieving EOS blockchain related information */
class BlockchainOperations{
    /**Can be substituted with a mock client*/
    private let client:HttpClient
    private var max:Int!

    
    private var isRunning:Bool = false
    /**Easy to switch block producer*/
    private var producer:Producer!
    
    //Completion blocks
    typealias blocksCompleteClosure = ( _ blocks: Bool, _ error: Error?)->Void
    typealias blockCompleteClosure = ( _ blocks: Block?, _ error: Error?)->Void
    typealias chainCompleteClosure = ( _ chain: ChainInfo?, _ error: Error?)->Void
    
    //Default
    init(){
        let session = URLSession.shared
        self.client = HttpClient(session: session)
        self.producer = NewYorkProducer()
    }
    
    init(session:URLSession,producer:Producer) {
        self.client = HttpClient(session: session)
        self.producer = producer
    }
    
    
    
    func downloadBlocks(_ blocks_num:Int, completion: @escaping blocksCompleteClosure ){
        if isRunning{
//            completion(self.blocks, EOSError.currentlyDownloading)
            print(EOSError.currentlyDownloading)
            return
        }
        
        //Getting n blocks
        max = blocks_num
        
        isRunning = true
        getGeneralInfo { (info,error) in
            
            if let error = error
            {
                print(error)
                self.isRunning = false
                completion(false,error)
                return
            }
            if let info = info {
                let head_id = String(info.lastBlock)
                //Finally start downloading
                self.download(blockid: head_id, count: self.max, { (_blocks, error) in
                    self.isRunning = false
                    completion(_blocks,error)
                })

            }else{
                self.isRunning = false
                completion(false, EOSError.unknownError)
            }
        }
    }
    
    /**Responsible for downloading block with given block id*/
    func download(blockid:String, count:Int, _ completion:@escaping blocksCompleteClosure){
        if count == max{
            completion(true,nil)
            return
        }
        
        getBlockContents(block:blockid) { (info,error) in
            if error != nil{
                completion(false,error)
                return
            }
            
            if let info = info, let previous = info.previous{
               self.download(blockid: previous, count: count + 1, completion)
            }else{
                completion(true,nil)
            }
        }
    }
    
    
    /**Responsible for downloading information about latest information about chain/ block*/
    func getGeneralInfo(completion:@escaping chainCompleteClosure){
        let urlString = self.producer.INFO_ENDPOINT
        
        guard let url = URL(string:urlString ) else{
            print("error \(urlString)")
            
            return
        }
        client.post(url: url, body: nil) { (data, error) in
            
            guard let data = data, error == nil else {
                print("error=\(error.debugDescription)")
                completion(nil, EOSError.invalidResponse)
                return
            }
            
            guard let info = self.decodeJSONChainData(data) else {
                completion(nil,EOSError.parsingJSON)
                return
            }
            

            completion(info,nil)
        }
    }
    

    /**Helper for decoding chain info*/
    func decodeJSONChainData(_ data: Data)->ChainInfo?{
        guard let info = try? JSONDecoder().decode(ChainInfo.self, from: data) else{
            return nil
        }
        
        return info
    }

    
    /**Helper for decoding blocks */
    func decodeJSONBlockData(_ data: Data)->Block?{
       
 
        guard  var info = try? JSONDecoder().decode(Block.self, from: data) else{
            
            return nil
        }
       
        //add raw information to the Block data
//       info.content_string = String(data: data, encoding: .utf8)
        return info
    }
    
    
    func getBlockContents(block:String,  completion: @escaping blockCompleteClosure){
        let urlString = self.producer.GET_BLOCK_ENDPOINT
        
        guard let url = URL(string:urlString ) else{
            print("error \(urlString)")
            completion(nil,EOSError.invalidRequest)
            return
        }
        
        //Pass Block Number/id in JSON
        let json: [String: Any] = ["block_num_or_id":block]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        
        client.post(url: url, body: jsonData) { (data, error) in
            guard let data = data, error == nil else {
                print("error=\(error.debugDescription)")
                completion(nil,error)
                return
            }
            
            DispatchQueue.main.async {
                guard let info = self.decodeJSONBlockData(data) else {
                    completion(nil,EOSError.parsingJSON)
                    return
                }
                completion(info,nil)
            }
        }
    }
}
