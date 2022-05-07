//
//  DetailRawg.swift
//  Gamelog
//
//  Created by yxgg on 22/04/22.
//

import Foundation

struct DetailRawg: Codable {
  let id: Int
  let backgroundImageAdditional: String
  let backgroundImage: String
  let name: String
  let genres: [Genres]
  let description: String
  let platforms: [RootPlatform]
  let developers: [Developers]
  let publishers: [Publisher]
  let released: Date
  let rating: Double
  let tags: [Tags]
  let website: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case backgroundImageAdditional = "background_image_additional"
    case backgroundImage = "background_image"
    case name
    case genres
    case description = "description_raw"
    case platforms
    case developers
    case publishers
    case released
    case rating
    case tags
    case website
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
    backgroundImageAdditional = try container.decodeIfPresent(String.self, forKey: .backgroundImageAdditional) ?? ""
    backgroundImage = try container.decodeIfPresent(String.self, forKey: .backgroundImage) ?? ""
    name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
    genres = try container.decodeIfPresent([Genres].self, forKey: .genres) ?? []
    description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
    platforms = try container.decodeIfPresent([RootPlatform].self, forKey: .platforms) ?? []
    developers = try container.decodeIfPresent([Developers].self, forKey: .developers) ?? []
    publishers = try container.decodeIfPresent([Publisher].self, forKey: .publishers) ?? []
    let releasedString = try container.decodeIfPresent(String.self, forKey: .released) ?? ""
    released = releasedString.date(format: .date) ?? Date(timeIntervalSince1970: 0)
    rating = try container.decodeIfPresent(Double.self, forKey: .rating) ?? 0
    tags = try container.decodeIfPresent([Tags].self, forKey: .tags) ?? []
    website = try container.decodeIfPresent(String.self, forKey: .website) ?? ""
  }
}
