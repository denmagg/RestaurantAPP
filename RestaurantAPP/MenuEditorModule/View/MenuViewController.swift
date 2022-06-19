//
//  MenuViewController.swift
//  RestaurantAPP
//
//  Created by Денис Медведев on 16.06.2022.
//

import UIKit
import SnapKit

final class MenuViewController: UIViewController {
    
    private let leftViewController = MenuEditorViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupLeftViewController()
    }
    
    private func configureView() {
        view.backgroundColor = .darkGray
    }
    
    private func setupLeftViewController() {
        addChild(leftViewController)
        view.addSubview(leftViewController.view)
        leftViewController.view.backgroundColor = .green
        leftViewController.didMove(toParent: self)
        
        leftViewController.view.translatesAutoresizingMaskIntoConstraints = false

        leftViewController.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leftViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        leftViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        leftViewController.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true

//FIXME: Cделать последний констрейнт через SnapKit
//        leftViewController.view.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.width.equalTo(view.snp.width).multipliedBy(0.5)
//        }
    }
}

