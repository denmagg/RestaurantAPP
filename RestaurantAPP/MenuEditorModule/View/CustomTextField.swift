//
//  CustomTextField.swift
//  RestaurantAPP
//
//  Created by Денис Медведев on 18.06.2022.
//

import UIKit

class CustomTextField: UITextField {
    
    enum Consts {
        static let cornerRadius: CGFloat = 10
        static let borderColor = CGColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1.0)
        static let borderWidth: CGFloat = 1.0
    }

    required init(placeholder: String) {
        super.init(frame: .zero)
        
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.layer.masksToBounds = true
        self.layer.cornerRadius = Consts.cornerRadius
        self.layer.borderColor = Consts.borderColor
        self.layer.borderWidth = Consts.borderWidth
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
