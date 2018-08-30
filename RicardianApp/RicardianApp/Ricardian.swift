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
    let accountName:String
    let actionName:String
}


class RicardianOperations{
    
    func getActionContract(action:Action)->Promise<[String]>{
        return Promise { seal in
            let urlString = "\(API.PRODUCER_URL)/\(API.GET_ABI)"
            let json: Parameters = ["account_name": action.accountName]
            
            
            Alamofire.request(urlString, method: .post, parameters: json, encoding: JSONEncoding.default).responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    guard let json = json  as? [String: Any] else {
                        return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                    }
                    
                    let actionsJSON =  JSON(json)
                    let actions = actionsJSON["abi"]["actions"]
                    let filtered = actions.arrayValue.filter({ (j) -> Bool in
                        j["name"].stringValue == action.actionName
                    })
                    let contracts = filtered.map({ el in
                        return el["ricardian_contract"].stringValue
                    })
                    seal.fulfill(contracts)
                    
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
    
    func getContractsForTransaction(_ transactionId:String)->Promise<[[String]]>{
        
       return getAccounts(transactionId).map { (j) -> [Action] in
             let json =  JSON(j)
             let actions_json = json["trx"]["trx"]["actions"]

            let actions = actions_json.arrayValue.map({ element in
                Action(accountName:  element["account"].stringValue, actionName: element["name"].stringValue)
            })
            return actions
        }.then{ actions -> Promise<[[String]]> in
                var promises = [Promise<[String]>]()
                for action in actions{
                    promises.append(self.getActionContract(action: action))
                }
                return when(fulfilled: promises)
        }
        
        }


}
