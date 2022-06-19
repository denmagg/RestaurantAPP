//
//  CategoryButton.swift
//  RestaurantAPP
//
//  Created by Денис Медведев on 18.06.2022.
//

import UIKit
import SnapKit

final class CustomButtonBuilder: UIButton {
    
    enum CustomButtonStyle {
        case selectedCategory
        case plainCategory
        case addCategory
        case deleteCategory
        case ingridient
        case addIngridient
        case loadImage
        case addMeal
    }
    
    private enum Consts {
        enum CategoryButton {
            static let selectedButtonAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "roboto-regular", size: 11)!,
                .foregroundColor: UIColor.white
            ]
            static let plainButtonAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "roboto-regular", size: 11)!,
                .foregroundColor: UIColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1.0)
            ]
            static let cornerRadius: CGFloat = 10
            static let contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            
            static let selectedbackgroundColor = UIColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1.0)
            static let plainBorderColor = CGColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1)
            static let plainBorderWidth = 0.5
            
            static let buttonEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            static let height = 24
        }
        
        enum AddCategoryButton {
            static let buttonAttributes: [NSAttributedString.Key : Any] = [
                .foregroundColor: UIColor.white
            ]
            static let font = UIFont(name: "roboto-regular", size: 11)!
            static let borderColor = CGColor(red: 65/255, green: 144/255, blue: 149/255, alpha: 1)
            static let textColor = UIColor(red: 65/255, green: 144/255, blue: 149/255, alpha: 1)
            static let borderWidth = 0.5
            static let cornerRadius: CGFloat = 10
            static let contentEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
            static let height = 24
            static let imageName = "Plus-In-Circle"
            static let subviewsSpacing = -2
        }
        
        enum DeleteCategoryButton {
            static let buttonAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "roboto-regular", size: 14)!,
                .foregroundColor: UIColor.gray,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ] // .double.rawValue, .thick.rawValue
            static let height = 22
        }
        
        enum IngridientButton {
            static let buttonAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "roboto-regular", size: 11)!,
                .foregroundColor: UIColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1)
            ]
            static let borderColor = CGColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1)
            static let borderWidth: CGFloat = 0.5
            static let cornerRadius: CGFloat = 10
            static let height = 24
            static let contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
        
        enum AddIngridientButton {
            static let buttonAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "roboto-regular", size: 11)!,
                .foregroundColor: UIColor.white
            ]
            static let backgroundColor = UIColor(red: 65/255, green: 144/255, blue: 149/255, alpha: 1)
            static let cornerRadius: CGFloat = 5
            static let height = 24
        }
        
        enum LoadImageButton {
            static let buttonAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont(name: "roboto-regular", size: 20)!,
                .foregroundColor: UIColor.gray,
                .underlineStyle: NSUnderlineStyle.single.rawValue
            ]
            static let height = 22
        }
        
        enum AddMealButton {
            static let buttonAttributes: [NSAttributedString.Key : Any] = [
                .font: UIFont(name: "roboto-regular", size: 22)!,
                .foregroundColor: UIColor.white
            ]
            static let backgroundColor = UIColor(red: 39/255, green: 93/255, blue: 113/255, alpha: 1)
            static let cornerRadius:CGFloat = 10
            static let height = 41
        }
    }
    
    required init(title: String, style: CustomButtonStyle, isSelected: Bool? = nil) {
        super.init(frame: .zero)
        configurateButton(withTitle: title, style: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurateButton(withTitle title: String, style: CustomButtonStyle) {
        switch style {
        case .selectedCategory:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.CategoryButton.selectedButtonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            layer.cornerRadius = Consts.CategoryButton.cornerRadius
            backgroundColor = Consts.CategoryButton.selectedbackgroundColor
            contentEdgeInsets = Consts.CategoryButton.buttonEdgeInsets
            self.snp.makeConstraints { make in make.height.equalTo(Consts.CategoryButton.height)}
        case .plainCategory:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.CategoryButton.plainButtonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            layer.borderColor = Consts.CategoryButton.plainBorderColor
            layer.borderWidth = Consts.CategoryButton.plainBorderWidth
            layer.cornerRadius = Consts.CategoryButton.cornerRadius
            contentEdgeInsets = Consts.CategoryButton.buttonEdgeInsets
            self.snp.makeConstraints { make in make.height.equalTo(Consts.CategoryButton.height)}
        case .addCategory:
            let buttonAttributedTitle = NSMutableAttributedString(string: "", attributes: Consts.AddCategoryButton.buttonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            
            let label = UILabel()
            let imageView = UIImageView()
            
            self.addSubview(label)
            self.addSubview(imageView)
            
            label.text = title
            label.font = Consts.AddCategoryButton.font
            label.textColor = Consts.AddCategoryButton.textColor
            imageView.image = UIImage(named: Consts.AddCategoryButton.imageName)
            
            label.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.leading.equalToSuperview().inset(Consts.CategoryButton.buttonEdgeInsets)
                make.trailing.equalTo(imageView.snp.leading).inset(Consts.AddCategoryButton.subviewsSpacing)
            }
            
            imageView.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.trailing.equalToSuperview().inset(Consts.CategoryButton.buttonEdgeInsets)
            }
            
            layer.borderColor = Consts.AddCategoryButton.borderColor
            layer.borderWidth = Consts.AddCategoryButton.borderWidth
            layer.cornerRadius = Consts.AddCategoryButton.cornerRadius
            self.snp.makeConstraints { make in make.height.equalTo(Consts.AddCategoryButton.height)}
        case .ingridient:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.IngridientButton.buttonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            self.layer.borderColor = Consts.IngridientButton.borderColor
            self.layer.borderWidth = Consts.IngridientButton.borderWidth
            self.layer.cornerRadius = Consts.IngridientButton.cornerRadius
            self.contentHorizontalAlignment = .left
            self.contentEdgeInsets = Consts.IngridientButton.contentEdgeInsets
            self.snp.makeConstraints { make in make.height.equalTo(Consts.IngridientButton.height)}
        case .addIngridient:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.AddIngridientButton.buttonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            backgroundColor = Consts.AddIngridientButton.backgroundColor
            layer.cornerRadius = Consts.AddIngridientButton.cornerRadius
            self.snp.makeConstraints { make in make.height.equalTo(Consts.AddIngridientButton.height)}
        case .deleteCategory:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.DeleteCategoryButton.buttonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            self.snp.makeConstraints { make in make.height.equalTo(Consts.DeleteCategoryButton.height)}
        case .loadImage:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.LoadImageButton.buttonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            self.snp.makeConstraints { make in make.height.equalTo(Consts.LoadImageButton.height)}
        case .addMeal:
            let buttonAttributedTitle = NSMutableAttributedString(string: title, attributes: Consts.AddMealButton.buttonAttributes)
            self.setAttributedTitle(buttonAttributedTitle, for: .normal)
            backgroundColor = Consts.AddMealButton.backgroundColor
            layer.cornerRadius = Consts.AddMealButton.cornerRadius
            self.snp.makeConstraints { make in make.height.equalTo(Consts.AddMealButton.height)}
        }
    }
}

//TODO: с ios 15 кнопку проще стало настраивать через класс UIButton.Configuration. Поэтому в дальнейшем следует переделать настройку кнопки через UIButton.Configuration.
//https://stackoverflow.com/questions/68328038/imageedgeinsets-was-deprecated-in-ios-15-0
