//
//  QuoteBuilderView.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import UIKit
import Nuke

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
  
  func setupWithQuote(quote: Quote){
    DispatchQueue.main.async {
      self.quoteLabel.text = quote.text
      self.authorLabel.text = quote.author
    }
  }
  
  func setupWithPhoto(photo: Photo){
  
    DispatchQueue.main.async {
      //load image
      guard let url = URL(string: photo.urlString) else{
      return
      }
      Nuke.loadImage(with: url, into: self.imageView)
  
    }
  }
  
  private func commonInit(){
    Bundle.main.loadNibNamed("QuoteBuilderView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = self.bounds
    contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
  }


}
