//
//  RootPlatformRawg.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import Foundation

struct RootPlatform: Codable {
  let platform: Platform
  
  enum CodingKeys: String, CodingKey {
    case platform
  }
}

struct Platform: Codable {
  let id: Int
  let name: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case name
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
  }
}
