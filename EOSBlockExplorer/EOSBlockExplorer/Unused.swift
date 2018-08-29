//
//  Unused.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/29/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import Foundation
import UIKit

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
