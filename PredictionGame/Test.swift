//
//  Test.swift
//  PredictionGame
//
//  Created by Maryna Bolotska on 21/02/24.
// imageView1.image = UIImage(systemName: "plus.circle")

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    // Declare UIImageViews
    let imageView1 = UIImageView()
    let imageView2 = UIImageView()
    let imageView3 = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Set up UIImageViews
//        imageView1.image = UIImage(systemName: "plus.circle")
//        imageView2.image = UIImage(systemName: "plus.circle")
//        imageView3.image = UIImage(systemName: "plus.circle")
        
        imageView1.layer.borderWidth = 3
        imageView2.layer.borderWidth = 3
        imageView3.layer.borderWidth = 3
        imageView1.backgroundColor = .green
        imageView2.backgroundColor = .green
        imageView3.backgroundColor = .green
        
        view.addSubview(imageView1)
        view.addSubview(imageView2)
        view.addSubview(imageView3)
        
        // Set up constraints using SnapKit
        imageView1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(100)
            make.width.height.equalTo(100)
        }
        
        imageView2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView1.snp.bottom).offset(20)
            make.width.height.equalTo(100)
        }
        
        imageView3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView2.snp.bottom).offset(20)
            make.width.height.equalTo(100)
        }
        
        // Add tap gesture recognizers to each UIImageView
        let tapGesture1 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(sender:)))
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(sender:)))
        let tapGesture3 = UITapGestureRecognizer(target: self, action: #selector(imageViewTapped(sender:)))
        
        imageView1.isUserInteractionEnabled = true
        imageView2.isUserInteractionEnabled = true
        imageView3.isUserInteractionEnabled = true
        
        imageView1.addGestureRecognizer(tapGesture1)
        imageView2.addGestureRecognizer(tapGesture2)
        imageView3.addGestureRecognizer(tapGesture3)
    }
    
    @objc func imageViewTapped(sender: UITapGestureRecognizer) {
        // Reset background colors
        imageView1.backgroundColor = .black
        imageView2.backgroundColor = .black
        imageView3.backgroundColor = .black
        
        // Change background color of tapped UIImageView to black
        if let tappedImageView = sender.view as? UIImageView {
            tappedImageView.backgroundColor = .clear
        }
    }
}
