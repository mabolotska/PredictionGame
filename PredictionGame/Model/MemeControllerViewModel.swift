//
//  MemeControllerViewModel.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import UIKit


class MemeControllerViewModel {
    var onImageLoaded: ((UIImage?)->Void)?
    
    let meme: Meme
    
    init(_ meme: Meme) {
  
        self.meme = meme
        self.loadImage()
    }
    
    private func loadImage() {

        DispatchQueue.global().async { [weak self] in
            if let logoURL = self?.meme.imageUrl,
               let imageData = try? Data(contentsOf: logoURL),
               let logoImage = UIImage(data: imageData) {
                self?.onImageLoaded?(logoImage)
            }
        }
    }
}
