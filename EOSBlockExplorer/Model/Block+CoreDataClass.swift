//
//  Block+CoreDataClass.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 10/2/18.
//  Copyright © 2018 izotx. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

//@objc(Block)
public class Block: NSManagedObject, Codable {
    enum BlockKeys: String, CodingKey { // declaring our keys
        case block = "block_num"
        case previous = "previous"
        case producer = "producer"
        case signature = "producer_signature"
        
        
    }
    
    public required init(from decoder: Decoder) throws {
       
        let delegate = UIApplication.shared.delegate as?  AppDelegate
        var container = try decoder.container(keyedBy: BlockKeys.self)
        let entity = NSEntityDescription.entity(forEntityName: "Block", in: (delegate?.persistentContainer.viewContext)!)
        var container1 = try decoder.unkeyedContainer()
        print(container1)

        super.init(entity: entity!, insertInto:(delegate?.persistentContainer.viewContext)! )
        self.block_num =  try container.decode(Int64.self, forKey: .block)
        self.previous =  try container.decode(String.self, forKey: .previous)
      

    }
    
    
    
}
