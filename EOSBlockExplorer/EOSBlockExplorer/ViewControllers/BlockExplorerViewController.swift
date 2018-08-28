//
//  BlockExplorerViewController.swift
//  EOSBlockExplorer
//
//  Created by Janusz Local Admin on 8/28/18.
//  Copyright © 2018 izotx. All rights reserved.
//

import UIKit

class BlockExplorerViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class Blockchain{
    var blocks:Int?
    
}


class BlockDataSource:UITableViewDataSource{
    var blockchain = Blockchain()
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return dataStore.allFlavors().count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let flavor = dataStore.allFlavors()[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("IceCreamListCell", forIndexPath: indexPath)
        cell.textLabel?.text = flavor
        return cell
    }
    
}
