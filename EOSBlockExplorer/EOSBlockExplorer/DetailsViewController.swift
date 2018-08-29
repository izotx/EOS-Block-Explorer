//
//  ViewController.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit

extension DetailsViewController{
    //Just for testing purposes
    func loadLocalData()->Block?{
        let blockops = BlockchainOperations()
        let urlpath     = Bundle.main.path(forResource: "block_info", ofType: "json")
        let url         = NSURL.fileURL(withPath: urlpath!)
        let blockData = try? Data(contentsOf: url)
        guard let data = blockData else{
                print("data doesn't exist!")
            //Throw Error here!
            return nil
        }
        
        guard let block = blockops.decodeJSONBlockData(data) else{
                print("Wrong data format")
            //Throw Error here!
            return nil
        }
        return block
    }
}



class DetailsViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!

    //Current Block Data
    private var block:Block?
    private var datasource:BlockDataSource?
    
    func updateBlockInfo(_block:Block){
        self.block = _block
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if let b = loadLocalData()
        {
            updateBlockInfo(_block: b)
        }
        
        datasource = BlockDataSource()
        
        if let b = self.block{
            self.title = "Block \(b.block_num)"
            datasource?.info = b.getKeyValues()
            print("Info")
            print(datasource?.info)
        }else{
            print("block not loaded")
        }

//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: CellIds.BlockDetailsCell.rawValue)
        tableView.dataSource = datasource
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class BlockDataSource: NSObject,UITableViewDataSource{
    var info = [BlockDetail]()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
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
        cell.textLabel?.text = "aaa "
        //Return general information
        if indexPath.section == 0{
            let record = info[indexPath.row]
            cell.detailTextLabel?.text = record.key
            cell.textLabel?.text = record.value
            
        }
        
        
        //We will have different Cells. Basic ones will contain key/value info
        
        
        
        return cell
    }
}



