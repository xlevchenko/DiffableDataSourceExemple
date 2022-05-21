//
//  AddItemController.swift
//  Shopping List
//
//  Created by Olexsii Levchenko on 5/21/22.
//

import UIKit

protocol AddItemControllerDelegate: AnyObject {
    func didAddNewItem(_ addItemViewConroller: AddItemController, item: Item)
}

class AddItemController: UIViewController {
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    weak var delegate: AddItemControllerDelegate?
    
    private var selectedCatecory: Category?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        selectedCatecory = Category.allCases.first
    }
    
    
    @IBAction func AddItem() {
        guard let name = name.text, !name.isEmpty,
              let priceText = price.text, !priceText.isEmpty,
              let price = Double(priceText),
              let selectedCategory = selectedCatecory
        else {
            return print("Missing fields")
        }
        let item = Item(name: name, price: price, category: selectedCategory)
        delegate?.didAddNewItem(self, item: item)
        dismiss(animated: true)
    }
}

extension AddItemController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Category.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        return selectedCatecory = Category.allCases[row]
    }
}
