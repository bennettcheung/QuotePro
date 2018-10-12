//
//  AddNewQuoteView.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import UIKit

protocol AddNewQuoteViewControllerDelegate {
  func save(quote: Quote, photo: Photo)
}

class AddNewQuoteViewController: UIViewController {
  @IBOutlet weak var quoteBuilderView: QuoteBuilderView!
  var delegate: AddNewQuoteViewControllerDelegate?
  var quote: Quote!
  var photo: Photo!
  
  override func viewDidLoad() {
    if quote != nil && photo != nil{
      self.quoteBuilderView.setupWithQuote(quote: quote)
      self.quoteBuilderView.setupWithPhoto(photo: photo)
      
    }
    else{
      getNewQuote(self)
      getNewImage(self)
    }
  }

  
  // MARK: IB Actions
  @IBAction func getNewQuote(_ sender: Any) {
    NetworkManager.shared.getQuote { (quote,  error) -> (Void) in
      
      if let quote = quote {
//        print("Quote \(quote.text!) -- Author \(quote.author!)")
        self.quote = quote
        self.quoteBuilderView.setupWithQuote(quote: quote)

      }
    }
  }
  
  @IBAction func getNewImage(_ sender: Any) {
    
    NetworkManager.shared.getImageURL { (photo, error) -> (Void) in
      
      if let photo = photo {
        print("Random image url \(photo.urlString)")

        self.photo = photo
      
          //load image
        self.quoteBuilderView.setupWithPhoto(photo: photo)

      }
    }
  }
  
  
  @IBAction func saveQuoteImage(_ sender: Any) {
    if let delegate = delegate{
      delegate.save(quote: self.quote, photo: self.photo)
      
    }
    if let navController = self.navigationController {
      navController.popViewController(animated: true)
    }
  }

  @IBAction func shareQuote(_ sender: Any) {

    //share image
    if let image = quoteBuilderView.snapshot(){
      let items = [image]
      let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
      present(ac, animated: true)
    }
  }
}
