//
//  Transaction+CoreDataProperties.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 10/2/18.
//  Copyright © 2018 izotx. All rights reserved.
//
//

import Foundation
import CoreData


extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var status: String?
    @NSManaged public var content_string: String?
    @NSManaged public var block: Block?

}


