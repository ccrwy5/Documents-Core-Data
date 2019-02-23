//
//  ViewController.swift
//  DocumentsChallenge
//
//  Created by Chris Rehagen on 1/31/19.
//  Copyright © 2019 Chris Rehagen. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    
    @IBOutlet weak var documentsTableView: UITableView!
    
    
    var documents: [DocumentCoreData] = []
    let date = DateFormatter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        date.dateStyle = .medium
        date.timeStyle = .medium
        documentsTableView.dataSource = self
        documentsTableView.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "DocumentCoreData")
        do {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let results = try context.fetch(fetchRequest)
            documents = results as! [DocumentCoreData]
        }
        catch {
            print("Test- failed on 43")
        }
        documentsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let selected = documentsTableView.indexPathForSelectedRow, let destination = segue.destination as? TextEntryViewController {
            let doc = documents[selected.row]
            destination.document = doc
        }
    }
}


/* same as last challenge */

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prototypeCell", for: indexPath) as! TableViewCell
        let document = documents[indexPath.row]
        
        cell.nameLabel.text = "Name: \(document.title ?? "title")"
        cell.sizeLabel.text = "Size: \(document.size) bytes"
        cell.timeLabel.text = "Last modified: \(date.string(from: document.date!))"
        return cell
    }
}

/* same as last challenge */
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
  
}




