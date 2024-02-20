//
//  MemeVC.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import UIKit

class MemeVC: UIViewController {
    let viewModel: MemeControllerViewModel
    init(_ viewModel: MemeControllerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     let guessLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()

    
    private let imageMeme: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .gray
        return image
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
                self.viewModel.onImageLoaded = { [weak self] logoImage in
                    DispatchQueue.main.async {
                        self?.imageMeme.image = logoImage
                    }
                }
    }


}


extension MemeVC {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(guessLabel)
        view.addSubview(imageMeme)
        
        guessLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        
        imageMeme.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(80)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(imageMeme.snp.width)
        }
    }
    
}
