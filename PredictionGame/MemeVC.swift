//
//  MemeVC.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 20/02/24.
//

import UIKit

class MemeVC: UIViewController {
    lazy var tapGestureRecognizer = UITapGestureRecognizer()
    var memData: MemesResponse?
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
        image.backgroundColor = .black
        return image
    }()
    private let imageMemeTwo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    private let imageMemeThree: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.backgroundColor = .black
        return image
    }()
    
    private let oneStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let agreeButton: UIButton = {
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
  
        //    viewModel.fetchMemes()
        //              viewModel.fetchMemes { [weak self] image in
        //                  self?.imageMeme.image = image[0]
        //                  self?.imageMemeTwo.image = image[1]
        //                  self?.imageMemeThree.image = image[2]
        //                  self?.showImage()
        //              }
        
        
        
        
        setUpTappable(imageMeme)
        setUpTappable(imageMemeTwo)
       setUpTappable(imageMemeThree)
        
    }
    @objc func getNewImage() {
        
        //        viewModel.fetchMemes { [weak self] image in
        //            self?.imageMeme.image = image[0]
        //            self?.imageMemeTwo.image = image[1]
        //            self?.imageMemeThree.image = image[2]
        //            self?.showImage()
        //        }
        
        imageTapped(sender: tapGestureRecognizer)
    }
    
    func showImage() {
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear], animations: {
            self.imageMeme.alpha = 0.0
            self.imageMemeTwo.alpha = 0.0
            self.imageMemeThree.alpha = 0.0
        }) { (completed) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 2, animations: {
                    self.imageMeme.alpha = 1
                    self.imageMemeTwo.alpha = 1
                    self.imageMemeThree.alpha = 1
                }, completion: nil)
            }
        }
    }
    
    
    func setUpTappable(_ image: UIImageView) {
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        image.addGestureRecognizer(tapGestureRecognizer)
        image.isUserInteractionEnabled = true
        
    }
    
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        imageMeme.image = UIImage(named: "1")
        imageMemeTwo.image = UIImage(named: "1")
        imageMemeThree.image = UIImage(named: "1")
        
        
        if let tappedImage = sender.view as? UIImageView {
         //   tappedImage.backgroundColor = .gray
            
            viewModel.fetchMemes { [weak self] image in
                let randomIndex = Int.random(in: 0..<(self?.memData?.data.memes.count ?? 3))
                tappedImage.image = image[randomIndex]
               
            }
        }
    }
    
}
extension MemeVC {
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(guessLabel)
        view.addSubview(oneStack)
        oneStack.addArrangedSubview(imageMeme)
        oneStack.addArrangedSubview(imageMemeTwo)
        oneStack.addArrangedSubview(imageMemeThree)
        view.addSubview(disagreeBUtton)
        view.addSubview(agreeButton)
        
     
        
        guessLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(80)
            make.centerX.equalToSuperview()
        }

        
        oneStack.snp.makeConstraints { make in
            make.top.equalTo(guessLabel.snp.bottom).offset(50)
            make.leading.trailing.equalToSuperview().inset(40)
            make.bottom.equalTo(agreeButton.snp.top).offset(-10)
        }
        agreeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(40)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
        
        disagreeBUtton.snp.makeConstraints { make in
            make.centerY.equalTo(agreeButton)
            make.trailing.equalToSuperview().offset(-40)
            make.height.equalTo(80)
            make.width.equalTo(150)
        }
    }
}
