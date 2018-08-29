//
//  Unused.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//
/** Digital wasteland Currently Unused methods and classes that I was planning to include in the app */
import Foundation
import UIKit

struct BlockDetail{
    let key:String
    let value:String
}

extension Block{
    //I am sure there is a better way to retrieve the properties
    func getKeyValues()->[BlockDetail]{
        var info = [BlockDetail]()
        info.append(BlockDetail(key: "Producer", value: self.producer))
        info.append(BlockDetail(key: "Signature", value: self.producer_signature))
        info.append(BlockDetail(key: "Transactions", value: "\(self.transactions.count)"))
        
        return info
    }
}



class BlockDataSource: NSObject,UITableViewDataSource{
    var info = [BlockDetail]()
    var block:Block?
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return info.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        //Just a generic table view cell
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIds.BlockDetailsCell.rawValue, for: indexPath as IndexPath)
        
        //Return general information
        if indexPath.section == 0{
            let record = info[indexPath.row]
            cell.detailTextLabel?.text = record.key
            cell.textLabel?.text = record.value
            
        }
        
        /** TODO: UNUSED
         if indexPath.section == 1{
         let longcell = tableView.dequeueReusableCell(withIdentifier: CellIds.LongTextCell.rawValue, for: indexPath as IndexPath) as! LongTextCell
         longcell.titleLabel.text = "Block Details"
         if let text = block?.content_string {
         longcell.textView.text = text
         }
         
         return longcell
         }
         */
        
        
        
        
        return cell
    }
}

class LongTextCell:UITableViewCell{
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var swltch: UISwitch!
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func switchChanged(_ sender: Any) {
    }
}
