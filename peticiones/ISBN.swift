//
//  ISBN.swift
//  peticiones
//
//  Created by Ing. José Antonio Franco Cortés on 29/04/16.
//  Copyright © 2016 xquared. All rights reserved.
//

import UIKit

var listado = [String]()

class ISBN: UITableViewController {
    
    
    @IBOutlet var tabla: UITableView!
   
    @IBAction func nuevaBusqueda(sender: AnyObject) {
      
    }
    
   
    var enviaISBN  = NSString()
     let shareData = ShareData.sharedInstance
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        if NSUserDefaults.standardUserDefaults().objectForKey("list") != nil {
            listado = NSUserDefaults.standardUserDefaults().objectForKey("list") as! [String]
        }
        
        self.tabla.delegate = self
        
      //  isbn.append("hola")
        
        
       /*
        if (shareData.someString != nil){
        print(shareData.someString)
            
            isbn.append(shareData.someString)
        
        }
        */
      
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  /*
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    
    }
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listado.count
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("celda", forIndexPath: indexPath)
        
        cell.textLabel?.text = listado[indexPath.row]
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        _ = tableView.indexPathForSelectedRow!
        if let _ = tableView.cellForRowAtIndexPath(indexPath) {
            self.performSegueWithIdentifier("descripcionLibro", sender: self)
        }
        
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            listado.removeAtIndex(indexPath.section)
            isbn.removeAtIndex(indexPath.section)
            NSUserDefaults.standardUserDefaults().setObject(listado, forKey: "list")
            
                tabla.reloadData()
        }
    }
    
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "descripcionLibro" {
            
            if let destino = segue.destinationViewController  as? descripcionISBN {
                
                let path = tableView.indexPathForSelectedRow
                let cell = tableView.cellForRowAtIndexPath(path!)
              //  destino.isbnbase = "0525451196"
                
                destino.isbnbase = (cell?.textLabel?.text!)!
       
                       //Sending the data here
           
        }

        }
    }
    


    
    override func viewDidAppear(animated: Bool) {
        tabla.reloadData()
    }

}
