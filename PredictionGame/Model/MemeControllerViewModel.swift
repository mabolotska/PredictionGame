//
//  MemeControllerViewModel.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import UIKit


class MemeControllerViewModel {
 //   var onImageLoaded: (([UIImage?]) -> Void)? //i use (completion: @escaping ([UIImage]) -> Void) instead
    private let numberOfMemesToFetch = 3
    private var meme: Meme?
    var images: [UIImage] = []


    func fetchMemes(completion: @escaping ([UIImage]) -> Void) {
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
              
                for _ in 0..<(self?.numberOfMemesToFetch ?? 0) {
                    let randomIndex = Int.random(in: 0..<memesResponse.data.memes.count)
                    
                    let randomMeme = memesResponse.data.memes[randomIndex]
                    
                    if let memeURL = URL(string: randomMeme.url) {
                        if  let imageData = try? Data(contentsOf: memeURL),
                            let image = UIImage(data: imageData) {
                            self?.images.append(image)
                        }
                    }
                }
                   
                    DispatchQueue.main.async {
                //        self?.onImageLoaded?(image)
                        completion(self?.images ?? [])
                    }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }

//    func setUpTappable(_ image: UIImageView) {
//        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
//        image.addGestureRecognizer(tapGestureRecognizer)
//        image.isUserInteractionEnabled = true
//       
//    }
//    
//    @objc func imageTapped(sender: UITapGestureRecognizer) {
//        imageMeme.backgroundColor = .black
//        imageMemeTwo.backgroundColor = .black
//        imageMemeThree.backgroundColor = .black
//        
//        
//        if let tappedImage = sender.view as? UIImageView {
//            tappedImage.backgroundColor = .gray
//        }
//    }

    
    
      
 }
