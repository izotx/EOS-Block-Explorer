//
//  Block+CoreDataProperties.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 10/2/18.
//  Copyright © 2018 izotx. All rights reserved.
//
//

import Foundation
import CoreData


extension Block {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Block> {
        return NSFetchRequest<Block>(entityName: "Block")
    }

    @NSManaged public var block_num: Int64
    @NSManaged public var previous: String?
    @NSManaged public var content_string: String?
    @NSManaged public var producer: String?
    @NSManaged public var producer_signature: String?
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Block {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}


extension Block{
   
}

