//
//  QuoteBuilderView.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import UIKit

class QuoteBuilderView: UIView {

  @IBOutlet var contentView: UIView!
  
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var quoteLabel: UILabel!
  @IBOutlet weak var imageView: UIImageView!
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit(){
    Bundle.main.loadNibNamed("QuoteBuilderView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }
  @IBAction func getNewQuote(_ sender: Any) {
    NetworkManager.shared.getQuote { (quote, author, error) -> (Void) in

      if let quote = quote, let author = author {
        print("Quote \(quote) -- Author \(author)")
        DispatchQueue.main.async {
          self.quoteLabel.text = quote
          self.authorLabel.text = author
        }
      }
    }
  }

  @IBAction func getNewImage(_ sender: Any) {
    
    NetworkManager.shared.getImageURL { (link, error) -> (Void) in
      
      if let link = link {
        print("Random image url \(link)")
        DispatchQueue.main.async {
          //load image

        }
      }
    }
  }

  @IBAction func saveQuoteImage(_ sender: Any) {
  }
}
