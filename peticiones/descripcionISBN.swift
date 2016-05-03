//
//  descripcionISBN.swift
//  peticiones
//
//  Created by Ing. José Antonio Franco Cortés on 02/05/16.
//  Copyright © 2016 xquared. All rights reserved.
//

import UIKit



class descripcionISBN: UIViewController {
    
    var isbnbase: String!
    @IBOutlet weak var isbnPrincipal: UITextView!
    @IBOutlet weak var tituloLibro: UITextView!
    @IBOutlet weak var nombreAutor: UITextView!
    @IBOutlet weak var imagenLibro: UIImageView!
    var nombres = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
      self.title = "descripción ISBN"
        let str = isbnbase
        let index1 = str.startIndex.advancedBy(5)
        let substring1 = str.substringFromIndex(index1)
        isbnPrincipal.text = substring1
         consultaLibro()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func regresarInicio(sender: AnyObject) {
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("inicio") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    func consultaLibro(){
        
        let URLS = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(isbnPrincipal.text!)"
        let url = NSURL(string: URLS)
        let datos = NSData(contentsOfURL: url!)
        
        
        do{
            
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            
            
            let dico1 = json as! NSDictionary
            
            if (dico1["ISBN:" + isbnPrincipal.text!] != nil)
            {
                
                let dico2 = dico1["ISBN:" + isbnPrincipal.text!] as! NSDictionary
                let dico3 = dico2["authors"] as! NSArray
                let dico4 = dico2["title"] as! NSString
                self.tituloLibro.text = dico4 as String
                
                if  (dico2["cover"] != nil) {
                    let dico5 = dico2["cover"] as! NSDictionary
                    let dico6 = dico5["large"] as! NSString
                    let img_url = NSURL(string: dico6 as String)
                    let img_datos = NSData(contentsOfURL: img_url!)
                    if (img_datos != nil) {
                        if let imagen = UIImage(data: img_datos!) {
                            self.imagenLibro.image = imagen
                        }
                    }
                } else {
                    self.imagenLibro.image = UIImage(named:"nodisponible")
                }
                
                for elemento in dico3 {
                    let nombreAutor = (elemento as! NSDictionary)["name"] as!
                    String
                    
                    nombres.append(nombreAutor )
                
                }
                
                if (nombres.count == 1){
                    self.nombreAutor.text = "\(nombres)\n"
                    
                    
                }else{
                    self.nombreAutor.text = "\(nombres)\",\n"
                    
                }
                
            }
            else
            {
                print("isbn no existe")
                tituloLibro.text = "no existe"
                self.imagenLibro.image = UIImage(named:"nodisponible")
            }
        }
        catch
        {
            // By default the catch clause defines the variable error as whatever ws thrown
            print("Error is \(error)")
            
        }
        
        
        
    }

    

}
