//
//  ViewController.swift
//  CoreDataTest
//
//  Created by Florian on 16/12/2016.
//  Copyright © 2016 Florian. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet weak var text2: UITextField!
    @IBOutlet weak var text1: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addEntry()
    {
        let context = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "Users", into: context)
        newUser.setValue(text1.text, forKey: "last_name")
        newUser.setValue(text2.text, forKey: "first_name")
        
        do{
            try context.save()
            print("Saved !!!")
        }
        catch {
            print("Error : \(error)")
        }
    }

    func fetchEntry()
    {
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(request)
            if (results.count > 0)
            {
                for result in results
                {
                    if let username = (result as AnyObject).value(forKey: "first_name") as? String
                    {
                        print(username)
                    }
                    if let lastname = (result as AnyObject).value(forKey: "last_name") as? String
                    {
                        print(lastname)
                    }
                }
            }
        }
        catch {
            print("/(error)")
        }
    }
    
    @IBAction func fetch(_ sender: UIButton) {
        fetchEntry()
    }
    
    @IBAction func button(_ sender: UIButton) {
        addEntry()
    }
}

