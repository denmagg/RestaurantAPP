//
//  MenuEditorViewController.swift
//  RestaurantAPP
//
//  Created by Денис Медведев on 16.06.2022.
//

import UIKit

class MenuEditorViewController: UIViewController {
    
    private let testLabel = UILabel()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupSubviews()
        configureLabel()
        setupConstraints()
    }
    
    private func configureView() {
        self.view.backgroundColor = .systemBackground
    }
    
    private func setupSubviews() {
        self.view.addSubview(testLabel)
    }
    
    private func configureLabel() {
        testLabel.text = "Test"
    }
    
    private func setupConstraints() {
        testLabel.translatesAutoresizingMaskIntoConstraints = false
        
        testLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        testLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }

}

