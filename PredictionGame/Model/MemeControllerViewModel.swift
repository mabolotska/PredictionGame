//
//  MemeControllerViewModel.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import UIKit


class MemeControllerViewModel {
    var onImageLoaded: ((UIImage?) -> Void)?

    private var meme: Meme?

    func fetchMemes() {
        guard let url = URL(string: "https://api.imgflip.com/get_memes") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            do {
                let memesResponse = try JSONDecoder().decode(MemesResponse.self, from: data)
              
                let randomIndex = Int.random(in: 0..<memesResponse.data.memes.count)
          
                let randomMeme = memesResponse.data.memes[randomIndex]
               
                if let memeURL = URL(string: randomMeme.url) {
                    let imageData = try Data(contentsOf: memeURL)
                    let image = UIImage(data: imageData)
                   
                    DispatchQueue.main.async {
                        self?.onImageLoaded?(image)
                    }
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }

    

 }
