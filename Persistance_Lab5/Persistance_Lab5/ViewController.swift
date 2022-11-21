//
//  ViewController.swift
//  Persistance_Lab5
//
//  Created by Neha Patel on 2022-11-20.
//

import UIKit
import CoreData

class ViewController: UIViewController {

  
       
       @IBOutlet var lineFields:[UITextField]!
       
    override func viewDidLoad()
        {
            super.viewDidLoad()
           
            let fileURL = self.dataFileURL()

            if (FileManager.default.fileExists(atPath: fileURL.path!))
            {
                if let array = NSArray(contentsOf: fileURL as URL) as? [String]
                {
                    for i in 0..<array.count
                    {
                        lineFields[i].text = array[i]
                    }
                }
                                    
            }

            let app = UIApplication.shared
            
            
            NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)),
                name: UIScene.willDeactivateNotification, object: nil)
        
            
        }
        
        func dataFileURL() -> NSURL
        {
            let urls = FileManager.default.urls(for:.documentDirectory, in: .userDomainMask)
            var url:NSURL?
            
            // create a blank path
            url = URL(fileURLWithPath: "") as NSURL?
            do
            {
                url = urls.first?.appendingPathComponent("data.plist") as NSURL?
            }
            catch
            {
               print("Error is \(error)")
            }
            
            return url!
        }
        
        @objc func applicationWillResignActive(notification: NSNotification)
        {
            print("in appication will resign active")
            
            let fileURL = self.dataFileURL()
            
            let array: NSMutableArray = []
            
            for line in self.lineFields
            {
                array.add(line.text!)
            }
           
            array.write(to: fileURL as URL, atomically: true)
        }

    }


