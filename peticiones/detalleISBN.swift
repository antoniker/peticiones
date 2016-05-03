//
//  detalleISBN.swift
//  peticiones
//
//  Created by Ing. José Antonio Franco Cortés on 29/04/16.
//  Copyright © 2016 xquared. All rights reserved.
//

import UIKit

var isbn = [String]()

class detalleISBN: UIViewController {


 
    @IBOutlet weak var ingresarISBN: UITextField!
    @IBOutlet weak var resultadoISBN: UITextView!
    @IBOutlet weak var resultadoAutor: UITextView!
    @IBOutlet weak var resultadoImagen: UIImageView!
    
    var nombres = [String]()
    var bandera: Int = 0
    
     let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Buscar ISBN"
        
        /*
        if (shareData.someString != nil)
        {
          ingresarISBN.text = shareData.someString
            bandera = 1
            consultaLibro()
            
        }
        else
        {
            bandera = 0
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    
    func consultaLibro(){
        
        let URLS = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(ingresarISBN.text!)"
        let url = NSURL(string: URLS)
        let datos = NSData(contentsOfURL: url!)
        
        
        do{
            
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            
           
            let dico1 = json as! NSDictionary
          
            if (dico1["ISBN:" + ingresarISBN.text!] != nil)
            {
                
            let dico2 = dico1["ISBN:" + ingresarISBN.text!] as! NSDictionary
            let dico3 = dico2["authors"] as! NSArray
            let dico4 = dico2["title"] as! NSString
            self.resultadoISBN.text = dico4 as String
            
            isbn.append("ISBN:" + ingresarISBN.text!)
            
            NSUserDefaults.standardUserDefaults().setObject(isbn, forKey: "list")
            
            if  (dico2["cover"] != nil) {
                let dico5 = dico2["cover"] as! NSDictionary
                let dico6 = dico5["large"] as! NSString
                let img_url = NSURL(string: dico6 as String)
                let img_datos = NSData(contentsOfURL: img_url!)
                if (img_datos != nil) {
                    if let imagen = UIImage(data: img_datos!) {
                        self.resultadoImagen.image = imagen
                    }
                }
            } else {
                self.resultadoImagen.image = UIImage(named:"nodisponible")
            }
            
            for elemento in dico3 {
                let nombreAutor = (elemento as! NSDictionary)["name"] as!
                String
                
                
                nombres.append(nombreAutor )
              
            }
            
            if (nombres.count == 1){
                self.resultadoAutor.text = "\(nombres)\n"
                
                
            }else{
                self.resultadoAutor.text = "\(nombres)\",\n"
                
            }
                
            }
            else
            {
                print("isbn no existe")
                resultadoISBN.text = "no existe"
                 self.resultadoImagen.image = UIImage(named:"nodisponible")
            }
        }
        catch
        {
            // By default the catch clause defines the variable error as whatever ws thrown
            print("Error is \(error)")
            
        }
        
        
        
    }

    @IBAction func limpiarPantalla(sender: AnyObject) {
        ingresarISBN.text = ""
        resultadoISBN.text = ""
        resultadoImagen.image = nil
        resultadoAutor.text = ""
        nombres = []
        
        print(isbn.count)
    }
    
   
    
    @IBAction func realizar(sender: AnyObject) {
         consultaLibro()
        
    }
    @IBAction func regresarInicio(sender: AnyObject) {
  
       self.shareData.someString = resultadoISBN.text
        
        let mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        let vc : UIViewController = mainStoryboard.instantiateViewControllerWithIdentifier("inicio") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    
    
     /*
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cc = segue.destinationViewController as! ISBN
        let isbn_codigo = ingresarISBN.text
       
    }*/

}


