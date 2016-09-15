//
//  ViewController.swift
//  MMCoreDataProject
//
//  Created by Michael Maczynski on 9/14/16.
//  Copyright © 2016 jhhs. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    
    var appDel: AppDelegate = AppDelegate()
    var context: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: NSManagedObjectContextConcurrencyType.MainQueueConcurrencyType)
    
    @IBAction func saveButton(sender: UIButton) {
        let newString = NSEntityDescription.insertNewObjectForEntityForName("StringEntity", inManagedObjectContext: context) as NSManagedObject
        newString.setValue(textField.text, forKey: "string")
        
        do {
            try context.save()
            
            let alert = UIAlertController(title: "Success", message: "Saved successfully", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } catch _ {
            print("Error")
        }
        
        
    }
    
    
    @IBAction func loadButton(sender: UIButton) {
        
        let request = NSFetchRequest(entityName: "StringEntity")
        request.resultType = NSFetchRequestResultType.DictionaryResultType
        
        var results: [AnyObject]?
        
        do
        {
            results = try context.executeFetchRequest(request)
        } catch _ {
            results = nil
            print("Error: Didn't load")
        }
        
        if results?.count > 0 {
            let string1 = results?.last?.valueForKey("string")! as? NSString
            displayLabel.text = "\(string1!)"
        }
        
    }
    
    @IBOutlet var displayLabel: UILabel!
    @IBOutlet var textField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    appDel = UIApplication.sharedApplication().delegate as! AppDelegate
    context = appDel.managedObjectContext
        
    }


}

