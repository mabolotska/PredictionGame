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
       
        return image
    }()
    
    private let agreeBUtton: UIButton = {
        let button = UIButton()
        button.setTitle("👍", for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        return button
    }()
    
    private let disagreeBUtton: UIButton = {
        let button = UIButton()
        button.setTitle("👎", for: .normal)
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(getNewImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupUI()
        
        viewModel.fetchMemes()
              viewModel.onImageLoaded = { [weak self] image in
                  self?.imageMeme.image = image
                  self?.showImage()
              }
      
            
    }
    @objc func getNewImage() {
     
        viewModel.fetchMemes()
    }
    
    func showImage() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
            self.imageMeme.alpha = 0.0
        }) { (completed) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 2, animations: {
                    self.imageMeme.alpha = 1
                }, completion: nil)
            }
        }
    }

}


extension MemeVC {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(guessLabel)
        view.addSubview(imageMeme)
        view.addSubview(disagreeBUtton)
        view.addSubview(agreeBUtton)
        
        guessLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }
        
        imageMeme.snp.makeConstraints { make in
            make.top.equalTo(guessLabel.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(40)
            make.height.equalTo(imageMeme.snp.width)
        }
        agreeBUtton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
        
        disagreeBUtton.snp.makeConstraints { make in
            make.centerY.equalTo(agreeBUtton)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
    }
    
}
