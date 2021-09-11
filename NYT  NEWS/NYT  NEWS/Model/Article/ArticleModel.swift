//
//  ArticleModel.swift
//  NYT  NEWS
//
//  Created by AH MARWAN  on 10/09/21.
//

import Foundation

// MARK: - ArticleModel
struct ArticleModel: Codable {
    let status, copyright: String?
    let numResults: Int?
    let results: [Result]?

    enum CodingKeys: String, CodingKey {
        case status, copyright
        case numResults = "num_results"
        case results
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        numResults = try values.decodeIfPresent(Int.self, forKey: .numResults)
        results = try values.decodeIfPresent([Result].self, forKey: .results)
    }
    
}
