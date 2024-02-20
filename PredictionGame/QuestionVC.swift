//
//  ViewController.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 19/02/24.
//

import UIKit
import SnapKit

class QuestionVC: UIViewController, UITextFieldDelegate {
    var completion: ((String) -> ())?
    
    private let guessTextfield: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter prediction"
        
        return textField
    }()
    
    private let guessButton: UIButton = {
        let button = UIButton()
        button.setTitle(" Get A Prediction ", for: .normal)
        button.addTarget(self, action: #selector(goNextVC), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.setTitleColor(UIColor.black, for: .normal)
        button.layer.borderWidth = 3
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @objc func goNextVC() {
       getDataAndBack()
    }

    
    
    
    private func getDataAndBack() {
        let vc = MemeVC()
        
        guard let text = guessTextfield.text, text != "" else {
            
            completion?("no data")
      
            
            navigationController?.pushViewController(vc, animated: true)
            
            return
        }
        
        completion?(text)
        vc.guessLabel.text = text
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension QuestionVC {
    func setupUI() {
        view.backgroundColor = .white
        guessTextfield.delegate = self
        
        view.addSubview(guessTextfield)
        view.addSubview(guessButton)
        
        guessTextfield.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(120)
            make.centerX.equalToSuperview()
        }
        
        guessButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(80)
        }
    }
    
    
}
