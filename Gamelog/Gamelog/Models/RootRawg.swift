//
//  RootRawg.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import Foundation

struct RootRawg: Codable {
  let results: [ResultRawg]
  
  enum CodingKeys: String, CodingKey {
    case results
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    results = try container.decodeIfPresent([ResultRawg].self, forKey: .results) ?? []
  }
}
