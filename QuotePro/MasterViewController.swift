//
//  MasterViewController.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

  var objects = [(Quote, Photo)]()


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.


    
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  // MARK: - Segues

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if (segue.identifier == "segueToAddQuote"){
      guard let controller = segue.destination as? AddNewQuoteViewController else{
        return
      }
      controller.delegate = self
    }
    else if (segue.identifier == "segueToShowDetail"){
      guard let controller = segue.destination as? AddNewQuoteViewController else{
        return
      }
      guard let indexPath = tableView.indexPathForSelectedRow else{
       return
      }
      let tuple = objects[indexPath.row]
      controller.quote = tuple.0
      controller.photo = tuple.1
    }
  }

  // MARK: - Table View

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return objects.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    let tuple = objects[indexPath.row]
    cell.textLabel!.text = tuple.0.author
    cell.detailTextLabel!.text = tuple.0.text
    return cell
  }

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
  }
  
  

}

extension MasterViewController: AddNewQuoteViewControllerDelegate{
  func save(quote: Quote, photo: Photo) {
    objects.append((quote, photo))
    DispatchQueue.main.async {
      self.tableView.reloadData()
    }
  }
}
