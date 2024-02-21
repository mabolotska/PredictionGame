//
//  Test.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 21/02/24.
//

import UIKit
import SnapKit

// MARK: - Model
struct User {
    var name: String
}

// MARK: - ViewModel
class UserViewModel {
    var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func saveUserName(_ name: String) {
        user.name = name
        UserDefaults.standard.set(name, forKey: "userName")
    }
    
    func loadUserName() -> String? {
        return UserDefaults.standard.string(forKey: "userName")
    }
}

// MARK: - View
class ViewController: UIViewController {
    private let textField = UITextField()
    private let saveButton = UIButton()
    
    var viewModel: UserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupViews()
        bindViewModel()
        
        if let savedName = viewModel.loadUserName() {
            textField.text = savedName
        }
    }
    
    private func setupViews() {
        view.addSubview(textField)
        view.addSubview(saveButton)
        
        textField.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        saveButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
        
        textField.borderStyle = .roundedRect
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(.blue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel = UserViewModel(user: User(name: ""))
    }
    
    @objc func saveButtonTapped() {
        guard let name = textField.text else { return }
        viewModel.saveUserName(name)
    }
}
