//
//  Meme.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import Foundation

//struct Meme {
//    struct ArrayElement: Codable {
//        let success: Bool?
//        let data: DataClass?
//    }
//
//    // MARK: - DataClass
//    struct DataClass: Codable {
//        let memes: [Meme]?
//    }
//
//    // MARK: - Meme
//    struct Meme: Codable {
//        let id, name: String?
//        let url: String?
//        let width, height, boxCount, captions: Int?
//
//        enum CodingKeys: String, CodingKey {
//            case id, name, url, width, height
//            case boxCount = "box_count"
//            case captions
//        }
//    }
//
//    typealias Array = [ArrayElement]
//}


import Foundation


    // MARK: - Meme
    struct Meme: Codable {
     //   let id, name: String?
        let urlString: String? // Rename url to urlString
   //     let width, height, boxCount, captions: Int?
        
        var imageUrl: URL? {
            if let urlString = urlString {
                return URL(string: urlString)
            }
            return nil
        }



       
    }


