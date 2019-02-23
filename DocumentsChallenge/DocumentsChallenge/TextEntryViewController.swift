//
//  TextEntryViewController.swift
//  DocumentsChallenge
//
//  Created by Chris Rehagen on 1/31/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//

import UIKit
import CoreData

class TextEntryViewController: UIViewController {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    var document: DocumentCoreData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let document = document else {
            print("Testing - Failed on line 23")
            return
        }
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func changeTitle(_ sender: Any) {
        self.title = titleTextField.text
    }
    
    
    @IBAction func handleSave(_ sender: Any) {
        guard let title = titleTextField.text, title.count > 0,
              let description = descriptionTextField.text, description.count > 0
        else {
            print("Testing - Fail on line 43")
            return
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "DocumentCoreData", in: viewContext)
        let coreData = DocumentCoreData(entity: entity!, insertInto: viewContext)
        
        
        coreData.title = title
        coreData.descriptionBox = description
        coreData.date = Date()
        coreData.size = Double(description.lengthOfBytes(using: .utf8))
        
        navigationController?.popViewController(animated: true)
    }
    
}



