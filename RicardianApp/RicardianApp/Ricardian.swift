//
//  Ricardian.swift
//  RicardianApp
//
//  Created by Janusz Chudzynski on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import PromiseKit




struct API{
    static let PRODUCER_URL = "https://api1.eosasia.one"
    static let INFO_ENDPOINT = "v1/chain/get_info"
    static let GET_BLOCK_ENDPOINT = "v1/chain/get_block"
    static let GET_TRANSACTION = "v1/history/get_transaction"
    static let GET_ABI = "v1/chain/get_abi"
}

struct Action{
    let name:String
    let action:String
}


class RicardianOperations{
    
    func getActionContract(action:Action)->Promise<Any>{
        return Promise { seal in
            let urlString = "\(API.PRODUCER_URL)/\(API.GET_ABI)"
            let json: Parameters = ["account_name": action.name]
            
            
            Alamofire.request(urlString, method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    guard let json = json  as? [String: Any] else {
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    seal.fulfill(json)
                    
                case .failure(let error):
                    seal.reject(error)
                    
                }
            }

        }
    }
    
    
    func getAccounts(_ transactionId:String)-> Promise<[String:Any]>{
        return Promise { seal in
            let urlString = "\(API.PRODUCER_URL)/\(API.GET_TRANSACTION)"
            let json: Parameters = ["id":transactionId]
            
            Alamofire.request(urlString, method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { (response) in
                 switch response.result {
                 case .success(let json):
                    guard let json = json  as? [String: Any] else {
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    seal.fulfill(json)
                
                    case .failure(let error):
                      seal.reject(error)
                    
                }
            }
        }
    }
    
    func processTransaction(_ transactionId:String){
        
        getAccounts(transactionId).map { (j) -> [Action] in
             let json =  JSON(j)
             let actions_json = json["trx"]["trx"]["actions"]

            let actions = actions_json.arrayValue.map({ element in
                Action(name:  element["account"].stringValue, action: element["name"].stringValue)
            })
            return actions
            }.map{ (actions) in
                var promises = [Promise<Any>]()
                for action in actions{
                    promises.append(self.getActionContract(action: action))
                }
                return when(fulfilled: promises)
            }.map{(contracts) in
                print(contracts)
            }
        
//            .then{ promises in
//
//            }
//            .map{(abi) in
//                //contract abi
//                 let json =  JSON(abi)
//                 let actions = json["abi"]["actions"]
//
//                return actions
//            }
//
//            .done { (a) in
//
//
//            }.catch { (error) in
//
//            }
        

        
//        getAccounts(transactionId).map { (j) -> [Action] in
//            let json =  JSON(j)
//            let actions_json = json["trx"]["trx"]["actions"]
//
//            let actions = actions_json.arrayValue.map({ element in
//                Action(name:  element["account"].stringValue, action: element["name"].stringValue)
//            })
//            print("")
//            print(actions)
//
//            return actions
//            }.then{ actions in
//                var promises = [Promise<Any>]()
//                for action in actions{
//                    promises.append(self.getActionContract(action: action))
//                }
//                return promises
//
//            }.map{(abi) in
//                //contract abi
//                let json =  JSON(abi)
//                let actions = json["abi"]["actions"]
//
//                return actions
//            }
//
//            .done { (a) in
//
//
//            }.catch { (error) in
//
//        }
        

//        getAccounts(transactionId).then { actions -> Void in
//                print(actions)
//            }
        
    }
    
    
    
//
//    func getAccounts(_ transactionId:String)-> Promise<[String]>{
//
//         return Promise { actions in
//
//
//
//                actions.resolve(accounts)
//
//            }
//        }
//    }
    
//func getTransactionActions(_ transactionId:String, completion:@escaping ([Dictionary<String,Any>]?)->Void){
//
//
//    guard let url = URL(string:urlString ) else{
//        print("error \(urlString)")
//
//        return
//    }
//
//
//    let jsonData = try? JSONSerialization.data(withJSONObject: json)
//
//    client.post(url: url, body: jsonData) { (data, error) in
//
//        guard let data = data, error == nil else {
//            print("error=\(error.debugDescription)")
//            return
//        }
//        if let transaction = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments)  as? Dictionary<String, Any>, let dict = transaction,let trx = dict["trx"] as? Dictionary<String,Any>,let trx1 = trx["trx"] as? Dictionary<String,Any>, let actions = trx1["actions"] as? [Dictionary<String,Any>]
//        {
//            completion(actions)
//        }
//        else{
//            completion(nil)
//        }
//    }
//    }

}
