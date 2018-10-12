//
//  Quote.swift
//  QuotePro
//
//  Created by Bennett on 2018-09-12.
//  Copyright © 2018 Bennett. All rights reserved.
//

import Foundation
class Quote : Codable{
  var text: String?
  var author: String?

  enum CodingKeys : String, CodingKey {
    case text = "quoteText"
    case author = "quoteAuthor"
    
  }
}
