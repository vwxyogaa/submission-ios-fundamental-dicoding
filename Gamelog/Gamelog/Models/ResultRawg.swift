//
//  ResultRawg.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import Foundation

struct ResultRawg: Codable {
  let id: Int64
  let backgroundImage: String
  let name: String
  let released: Date
  let rating: Double
  let genres: [Genres]?
  
  enum CodingKeys: String, CodingKey {
    case id
    case backgroundImage = "background_image"
    case name
    case released
    case rating
    case genres
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int64.self, forKey: .id) ?? 0
    backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage) ?? ""
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    let releasedString = try container.decodeIfPresent(String.self, forKey: .released) ?? ""
    released = releasedString.date(format: .date) ?? Date(timeIntervalSince1970: 0)
    rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0
    genres = try container.decodeIfPresent([Genres].self, forKey: .genres) ?? []
  }
}
