//
//  MenuEditorViewController.swift
//  RestaurantAPP
//
//  Created by Денис Медведев on 18.06.2022.
//

import UIKit
import SnapKit

final class MenuEditorViewController: UIViewController {
    
    //MARK: Consts
    private enum Consts {
        enum CategoryScrollView {
            static let topInset: CGFloat = -15
            static let height: CGFloat = 24
            static let trailingInset: CGFloat = 60
        }
        
        //Labels
        enum CategoryLabel {
            static let text = "Раздел"
            static let font = UIFont(name: "roboto-bold", size: 30)
            static let leadingInset: CGFloat = 60
            static let trailingInset: CGFloat = 60
            static let topSpacing: CGFloat = 51
            static let height: CGFloat = 31
            static let widthMax: CGFloat = 179
        }
        enum PropertyLabels {
            enum MealLabel {
                static let text = "Блюдо"
                static let topSpacing: CGFloat = -15
                static let widthMax: CGFloat = 179
                static let trailingInset = 60
            }
            enum IngridientsLabel {
                static let text = "Состав"
                static let topSpacing: CGFloat = -10
                static let widthMax: CGFloat = 179
                static let trailingInset = 60
            }
            enum PriceLabel {
                static let text = "Цена"
                static let topInset = -15
                static let trailingInset = 60
            }
            enum EnergyLabel {
                static let text = "Энергетическая ценность"
                static let topInset = -15
                static let trailingInset = 60
            }
            
            static let height: CGFloat = 23
            static let font = UIFont.boldSystemFont(ofSize: 24)
        }
        
        //Buttons
        enum DeleteCategoryButton {
            static let title = "Удалить раздел"
            static let topSpacing: CGFloat = -5
            static let height: CGFloat = 24
            static let widthMax: CGFloat = 161
            static let trailingInset = 60
        }
        enum AddIngridientButton {
            static let title = "Добавить ингридиент"
            static let topInset = -10
            static let height = 24
            static let width = 286
        }
        enum LoadMealImageButton {
            static let title = "Загрузить"
            static let leadingInset = -18
        }
        enum AddMealButton {
            static let title = "Добавить блюдо"
            static let topInset = -15
            static let bottomInset = 51
            static let height = 41
            static let width = 286
        }
        
        //TextFields
        enum MealNameTextField {
            static let placeholder = "Название"
            static let topInset = -10
            static let height = 41
            static let width = 286
        }
        
        enum PriceTextField {
            static let placeholder = "Цена"
            static let topInset = -10
            static let height = 41
            static let width = 286
        }
        
        enum EnergyTextField {
            static let placeholder = "Ккал"
            static let topInset = -10
            static let height = 41
            static let width = 286
        }
        
        //ImageView
        enum MealImageView {
            static let topInset = -15
            static let height = 50
            static let cornerRaduis: CGFloat = 25
        }
        
        //StackView
        enum CategoryStackView {
            static let spacing: CGFloat = 7
        }
        
        enum IngridientsStackView {
            static let topInset = -10
            static let width = 286
            static let spacing: CGFloat = 7
        }
    }
    
    //MARK: properties
    
    private let scrollView = UIScrollView()
    private let categoryScrollView = UIScrollView()
    private let contentView = UIView()
    
    //Labels
    private let categoryLabel = UILabel()
    private let mealLabel = UILabel()
    private let energyLabel = UILabel()
    private let priceLabel = UILabel()
    private let ingridientsLabel = UILabel()
    
    //Buttons
    private let categoryButtonsArray: [CustomButtonBuilder] = [
        CustomButtonBuilder(title: "Салаты", style: .selectedCategory, isSelected: true),
        CustomButtonBuilder(title: "Супы", style: .plainCategory, isSelected: false),
        CustomButtonBuilder(title: "Фирменные блюда", style: .plainCategory, isSelected: false),
        CustomButtonBuilder(title: "Основное", style: .plainCategory, isSelected: false),
        CustomButtonBuilder(title: "Закуски", style: .plainCategory, isSelected: false),
        CustomButtonBuilder(title: "Десерты", style: .plainCategory, isSelected: false),
        CustomButtonBuilder(title: "Напитки", style: .plainCategory, isSelected: false),
        CustomButtonBuilder(title: "Новый раздел", style: .addCategory)
    ]
    private let deleteCategoryButton = CustomButtonBuilder(title: Consts.DeleteCategoryButton.title, style: .deleteCategory)
    private let ingridientButtonsArray: [CustomButtonBuilder] = [
        CustomButtonBuilder(title: "Зеленый салат", style: .ingridient),
        CustomButtonBuilder(title: "Помидоры", style: .ingridient),
        CustomButtonBuilder(title: "Куриное филе", style: .ingridient),
        CustomButtonBuilder(title: "Белый хлеб", style: .ingridient),
        CustomButtonBuilder(title: "Соус «Цезарь»", style: .ingridient),
        CustomButtonBuilder(title: "Сливочное масло", style: .ingridient),
        CustomButtonBuilder(title: "Чеснок", style: .ingridient),
        CustomButtonBuilder(title: "Сыр пармезан", style: .ingridient)
    ]
    private let addIngridientButton = CustomButtonBuilder(title: Consts.AddIngridientButton.title, style: .addIngridient)
    private let loadImageButton = CustomButtonBuilder(title: Consts.LoadMealImageButton.title, style: .loadImage)
    private var addMealButton = CustomButtonBuilder(title: Consts.AddMealButton.title, style: .addMeal)
    
    //TextFields
    private let mealNameTextField = CustomTextField(placeholder: Consts.MealNameTextField.placeholder)
    private let priceTextField = CustomTextField(placeholder: Consts.PriceTextField.placeholder)
    private let energyTextField = CustomTextField(placeholder: Consts.EnergyTextField.placeholder)
    
    //ImageView
    private let mealImageView = UIImageView()
    
    //StackViews
    private let categoryStackView = UIStackView()
    private let ingridientsStackView = UIStackView()
    
    //MARK: lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setupSubviews()
        configureSubviews()
        setupConstraints()
    }
    
    //MARK: lifecycle helpers
    private func configureView() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    private func setupSubviews() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(categoryScrollView)
        contentView.addSubview(categoryLabel)
        categoryScrollView.addSubview(categoryStackView)
        for category in categoryButtonsArray {
            categoryStackView.addArrangedSubview(category)
        }
        contentView.addSubview(deleteCategoryButton)
        
        contentView.addSubview(mealLabel)
        contentView.addSubview(mealNameTextField)
        
        contentView.addSubview(ingridientsLabel)
        contentView.addSubview(ingridientsStackView)
        for ingridient in ingridientButtonsArray {
            ingridientsStackView.addArrangedSubview(ingridient)
        }
        contentView.addSubview(addIngridientButton)
        
        contentView.addSubview(mealImageView)
        contentView.addSubview(loadImageButton)
        
        contentView.addSubview(priceLabel)
        contentView.addSubview(priceTextField)
        
        contentView.addSubview(energyLabel)
        contentView.addSubview(energyTextField)
        
        contentView.addSubview(addMealButton)
    }
    
    private func configureSubviews() {
        categoryLabel.text = Consts.CategoryLabel.text
        categoryLabel.font = Consts.CategoryLabel.font
        categoryScrollView.showsHorizontalScrollIndicator = false
        categoryStackView.spacing = Consts.CategoryStackView.spacing
        categoryStackView.alignment = .leading
        categoryStackView.distribution = .equalSpacing
        categoryStackView.axis = .horizontal
        
        //TODO: поставить изображение вместо бекграунда
        mealImageView.layer.cornerRadius = Consts.MealImageView.cornerRaduis
        mealImageView.image = UIImage(named: "Mountain")
        
        mealLabel.text = Consts.PropertyLabels.MealLabel.text
        mealLabel.font = Consts.PropertyLabels.font
        
        ingridientsLabel.text = Consts.PropertyLabels.IngridientsLabel.text
        ingridientsLabel.font = Consts.PropertyLabels.font
        
        ingridientsStackView.spacing = Consts.IngridientsStackView.spacing
        ingridientsStackView.alignment = .fill
        ingridientsStackView.distribution = .equalSpacing
        ingridientsStackView.axis = .vertical
        
        
        priceLabel.text = Consts.PropertyLabels.PriceLabel.text
        priceLabel.font = Consts.PropertyLabels.font
        
        energyLabel.text = Consts.PropertyLabels.EnergyLabel.text
        energyLabel.font = Consts.PropertyLabels.font
        
        for i in 0...(categoryButtonsArray.count - 2) {
            categoryButtonsArray[i].addTarget(self, action: #selector(categoryButtonTapped), for: .touchUpInside)
        }
        
        categoryButtonsArray.last?.addTarget(self, action: #selector(addCategoryButtonTapped), for: .touchUpInside)
        deleteCategoryButton.addTarget(self, action: #selector(deleteCategoryButtonTapped), for: .touchUpInside)
        
        for i in 0...(ingridientButtonsArray.count - 2) {
            ingridientButtonsArray[i].addTarget(self, action: #selector(ingridientButtonTapped), for: .touchUpInside)
        }
        ingridientButtonsArray.last?.addTarget(self, action: #selector(addIngridientButtonTapped), for: .touchUpInside)
        
        addIngridientButton.addTarget(self, action: #selector(addIngridientButtonTapped), for: .touchUpInside)
        loadImageButton.addTarget(self, action: #selector(loadImageButtonTapped), for: .touchUpInside)
        addMealButton.addTarget(self, action: #selector(addMealButtonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(self.view.safeAreaLayoutGuide)
            make.width.equalTo(self.view.frame.width / 2)
        }
        categoryScrollView.snp.makeConstraints { make in
            make.leading.equalTo(categoryLabel)
            make.top.equalTo(categoryLabel.snp.bottom).inset(Consts.CategoryScrollView.topInset)
            make.height.equalTo(Consts.CategoryScrollView.height)
            make.trailing.equalToSuperview().inset(Consts.CategoryScrollView.trailingInset)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self.view.frame.width / 2)
        }
        
        //Labels
        categoryLabel.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leading).inset(Consts.CategoryLabel.leadingInset)
            make.top.equalTo(contentView.snp.top).inset(Consts.CategoryLabel.topSpacing)
            make.height.equalTo(Consts.CategoryLabel.height)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(Consts.CategoryLabel.trailingInset)
        }
        mealLabel.snp.makeConstraints { make in
            make.leading.equalTo(deleteCategoryButton)
            make.top.equalTo(deleteCategoryButton.snp.bottom).inset(Consts.PropertyLabels.MealLabel.topSpacing)
            make.height.equalTo(Consts.PropertyLabels.height)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(Consts.PropertyLabels.MealLabel.trailingInset)
        }
        ingridientsLabel.snp.makeConstraints { make in
            make.leading.equalTo(mealNameTextField)
            make.top.equalTo(mealNameTextField.snp.bottom).inset(Consts.PropertyLabels.IngridientsLabel.topSpacing)
            make.height.equalTo(Consts.PropertyLabels.height)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(Consts.PropertyLabels.IngridientsLabel.trailingInset)
        }
        priceLabel.snp.makeConstraints { make in
            make.leading.equalTo(mealImageView)
            make.top.equalTo(mealImageView.snp.bottom).inset(Consts.PropertyLabels.PriceLabel.topInset)
            make.height.equalTo(Consts.PropertyLabels.height)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(Consts.PropertyLabels.PriceLabel.trailingInset)
        }
        energyLabel.snp.makeConstraints { make in
            make.leading.equalTo(priceTextField)
            make.top.equalTo(priceTextField.snp.bottom).inset(Consts.PropertyLabels.EnergyLabel.topInset)//-15
            make.height.equalTo(Consts.PropertyLabels.height)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(Consts.PropertyLabels.EnergyLabel.trailingInset)//60
        }
        
        //Buttons
        deleteCategoryButton.snp.makeConstraints { make in
            make.leading.equalTo(categoryScrollView)
            make.top.equalTo(categoryScrollView.snp.bottom).inset(Consts.DeleteCategoryButton.topSpacing)
            make.height.equalTo(Consts.DeleteCategoryButton.height)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).inset(Consts.DeleteCategoryButton.trailingInset)
        }
        addIngridientButton.snp.makeConstraints { make in
            make.leading.equalTo(ingridientsStackView)
            make.top.equalTo(ingridientsStackView.snp.bottom).inset(Consts.AddIngridientButton.topInset)
            make.height.equalTo(Consts.AddIngridientButton.height)
            make.width.equalTo(Consts.AddIngridientButton.width)
        }
        loadImageButton.snp.makeConstraints { make in
            make.centerY.equalTo(mealImageView)
            make.leading.equalTo(mealImageView.snp.trailing).inset(Consts.LoadMealImageButton.leadingInset)
        }
        addMealButton.snp.makeConstraints { make in
            make.leading.equalTo(energyTextField)
            make.top.equalTo(energyTextField.snp.bottom).inset(Consts.AddMealButton.topInset)
            make.bottom.equalTo(contentView.snp.bottom).inset(Consts.AddMealButton.bottomInset)
            make.height.equalTo(Consts.AddMealButton.height)
            make.width.equalTo(Consts.AddMealButton.width)
        }
        
        //TextFields
        mealNameTextField.snp.makeConstraints { make in
            make.leading.equalTo(mealLabel)
            make.top.equalTo(mealLabel.snp.bottom).inset(Consts.MealNameTextField.topInset)
            make.height.equalTo(Consts.MealNameTextField.height)
            make.width.equalTo(Consts.MealNameTextField.width)
        }
        priceTextField.snp.makeConstraints { make in
            make.leading.equalTo(priceLabel)
            make.top.equalTo(priceLabel.snp.bottom).inset(Consts.PriceTextField.topInset)
            make.height.equalTo(Consts.PriceTextField.height)
            make.width.equalTo(Consts.PriceTextField.width)
        }
        energyTextField.snp.makeConstraints { make in
            make.leading.equalTo(energyLabel)
            make.top.equalTo(energyLabel.snp.bottom).inset(Consts.EnergyTextField.topInset)
            make.height.equalTo(Consts.EnergyTextField.height)
            make.width.equalTo(Consts.EnergyTextField.width)
        }
        
        //ImageViews
        mealImageView.snp.makeConstraints { make in
            make.leading.equalTo(addIngridientButton)
            make.top.equalTo(addIngridientButton.snp.bottom).inset(Consts.MealImageView.topInset)
            make.height.width.equalTo(Consts.MealImageView.height)
        }
        
        //StackViews
        categoryStackView.snp.makeConstraints { make in
            make.edges.equalTo(categoryScrollView)
        }
        ingridientsStackView.snp.makeConstraints { make in
            make.leading.equalTo(ingridientsLabel)
            make.top.equalTo(ingridientsLabel.snp.bottom).inset(Consts.IngridientsStackView.topInset)
            make.width.equalTo(Consts.IngridientsStackView.width)
        }
    }
    
    //MARK: Methods
    @objc private func categoryButtonTapped() {
        print("category button was tapped")
    }
    @objc private func addCategoryButtonTapped() {
        print("add category button was tapped")
    }
    @objc private func deleteCategoryButtonTapped() {
        print("delete category button was tapped")
    }
    @objc private func ingridientButtonTapped() {
        print("ingridient button was tapped")
    }
    @objc private func addIngridientButtonTapped() {
        print("add ingridient button was tapped")
    }
    @objc private func loadImageButtonTapped() {
        print("load image button was tapped")
    }
    @objc private func addMealButtonTapped() {
        print("add meal button was tapped")
    }
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
}
