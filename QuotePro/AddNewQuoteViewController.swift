//
//  AddNewQuoteView.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import UIKit

class AddNewQuoteViewController: UIViewController {
  @IBOutlet weak var quoteBuilderView: QuoteBuilderView!
  
  override func viewDidLoad() {
    getNewQuote(self)
    getNewImage(self)
  }

  
  // MARK: IB Actions
  @IBAction func getNewQuote(_ sender: Any) {
    NetworkManager.shared.getQuote { (quote,  error) -> (Void) in
      
      if let quote = quote {
        print("Quote \(quote.text) -- Author \(quote.author)")

        self.quoteBuilderView.setupWithQuote(quote: quote)

      }
    }
  }
  
  @IBAction func getNewImage(_ sender: Any) {
    
    NetworkManager.shared.getImageURL { (photo, error) -> (Void) in
      
      if let photo = photo {
        print("Random image url \(photo.urlString)")

          //load image
        self.quoteBuilderView.setupWithPhoto(photo: photo)

      }
    }
  }
  
  
  @IBAction func saveQuoteImage(_ sender: Any) {
  }

}
