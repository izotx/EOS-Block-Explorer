//: Playground - noun: a place where people can play

import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true
///https://api1.eosasia.one/v1/history/get_transaction
//https://github.com/EOSIO/eosjs/issues/287#issuecomment-410788732
struct API{
    
    static let PRODUCER_URL = "https://api1.eosasia.one"
    static let INFO_ENDPOINT = "v1/chain/get_info"
    static let GET_BLOCK_ENDPOINT = "v1/chain/get_block"
    static let GET_TRANSACTION = "v1/history/get_transaction"
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


let session = URLSession.shared
let client = HttpClient(session: session)


func getTransactionActions(_ transactionId:String, completion:@escaping ([Dictionary<String,Any>]?)->Void){
    let urlString = "\(API.PRODUCER_URL)/\(API.GET_TRANSACTION)"
    
    guard let url = URL(string:urlString ) else{
        print("error \(urlString)")
        
        return
    }
    
    let json: [String: Any] = ["id":transactionId]
    let jsonData = try? JSONSerialization.data(withJSONObject: json)
    
    client.post(url: url, body: jsonData) { (data, error) in
        
        guard let data = data, error == nil else {
            print("error=\(error.debugDescription)")
            return
        }
        if let transaction = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)  as? Dictionary<String, Any>, let dict = transaction,let trx = dict["trx"] as? Dictionary<String,Any>,let trx1 = trx["trx"] as? Dictionary<String,Any>, let actions = trx1["actions"] as? [Dictionary<String,Any>]
         {
            completion(actions)
        }
        else{
            completion(nil)
        }
    }
}

getTransactionActions("3852750abc7a2e1b4b5176a89c7f29f327ab97c96ba3bd12ff655b0451fe989c") { (actions) in
        print(actions)
}

