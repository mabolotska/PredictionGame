//
//  Meme.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import Foundation

//struct Meme {
    struct ArrayElement: Codable {
        let success: Bool?
        let data: DataClass?
    }


struct MemesResponse: Codable {
    let success: Bool
    let data: DataClass
}

struct DataClass: Codable {
    let memes: [Meme]
}

// MARK: - Meme
struct Meme: Codable {
    let id: String
    let name: String
    let url: String
    let width: Int
    let height: Int
    let boxCount: Int
    let captions: Int

    enum CodingKeys: String, CodingKey {
        case id, name, url, width, height, boxCount = "box_count", captions
    }
}
