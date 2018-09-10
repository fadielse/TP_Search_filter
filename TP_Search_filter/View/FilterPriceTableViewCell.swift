//
//  FilterPriceTableViewCell.swift
//  TP_Search_filter
//
//  Created by fadielse on 09/09/18.
//  Copyright © 2018 fadielse. All rights reserved.
//

import UIKit
import RangeUISlider

protocol FilterPriceDelegate {
    func priceCellValueChanged(pmin: String, pmax: String, wholeSale: Bool)
}

class FilterPriceTableViewCell: UITableViewCell {
    @IBOutlet weak var minPriceTextField: UITextField!
    @IBOutlet weak var maxPriceTextField: UITextField!
    @IBOutlet weak var wholeSaleSwitch: UISwitch!
    @IBOutlet weak var priceSlider: RangeUISlider!
    
    var pmin: String = ""
    var pmax: String = ""
    var wholeSale: Bool = false
    var delegate: FilterPriceDelegate?
    
    func configureCell(pmin: String, pmax: String, wholeSale: Bool) {
        self.selectionStyle = .none
        
        self.pmin = pmin
        self.pmax = pmax
        self.wholeSale = wholeSale
        
        setupSubviews()
    }
}

// MARK: - Setup
extension FilterPriceTableViewCell {
    func setupSubviews() {
        setupMinPrice()
        setupMaxPrice()
        setupPriceSlider()
        setupWholeSaleSwitch()
    }
    
    func setupPriceSlider() {
        priceSlider.delegate = self
        priceSlider.scaleMinValue = 100
        priceSlider.scaleMaxValue = 10000000
        priceSlider.defaultValueLeftKnob = CGFloat(Int(pmin)!)
        priceSlider.defaultValueRightKnob = CGFloat(Int(pmax)!)
        priceSlider.layoutSubviews()
    }
    
    func setupMinPrice() {
        minPriceTextField.delegate = self
        minPriceTextField.addTarget(self, action: #selector(textFieldDidChangeValue(_:)), for: .editingChanged)
        minPriceTextField.tag = 0
        minPriceTextField.text = "Rp " + GlobalMethod.formatCurrency(money: "\(pmin)", digitBeforeZero: 0)
    }
    
    func setupMaxPrice() {
        maxPriceTextField.delegate = self
        minPriceTextField.addTarget(self, action: #selector(textFieldDidChangeValue(_:)), for: .editingChanged)
        maxPriceTextField.tag = 1
        maxPriceTextField.text = "Rp " + GlobalMethod.formatCurrency(money: "\(pmax)", digitBeforeZero: 0)
    }
    
    func setupWholeSaleSwitch() {
        wholeSaleSwitch.isOn = wholeSale
        wholeSaleSwitch.addTarget(self, action: #selector(wholeSaleChanged(_:)), for: .valueChanged)
    }
}

// MARK: - Action
extension FilterPriceTableViewCell {
    @objc func wholeSaleChanged(_ wholeSaleSwitch: UISwitch) {
        wholeSale = wholeSaleSwitch.isOn
        
        self.delegate?.priceCellValueChanged(pmin: pmin, pmax: pmax, wholeSale: wholeSale)
    }
}

// MARK: - TextField Delegate
extension FilterPriceTableViewCell: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.selectedTextRange = textField.textRange(from: textField.beginningOfDocument, to: textField.endOfDocument)
        
        switch textField.tag {
        case 0:
            textField.text = pmin
        case 1:
            textField.text = pmax
        default:
            print("unknown textfield")
        }
    }
    
    @objc func textFieldDidChangeValue(_ textField: UITextField) {
        if textField.text! != "" {
            textField.text = GlobalMethod.formatCurrency(money: textField.text!, digitBeforeZero: 0)
        } else {
            textField.text = "0"
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let value = textField.text!.replacingOccurrences(of: ".", with: "")
        textField.text = value == "" ? "0" : value
        
        switch textField.tag {
        case 0:
            if Int(value)! > Int(pmax)! {
                setupMinPrice()
                
                return
            }
            
            pmin = value
            setupMinPrice()
            setupPriceSlider()
        case 1:
            if Int(value)! > Int(pmax)! {
                setupMaxPrice()
                
                return
            }
            
            pmax = value
            setupMaxPrice()
            setupPriceSlider()
        default:
            print("unknown textfield")
        }
        
        self.delegate?.priceCellValueChanged(pmin: pmin, pmax: pmax, wholeSale: wholeSale)
    }
}

// MARK: - Slider Delegate
extension FilterPriceTableViewCell: RangeUISliderDelegate {
    func rangeIsChanging(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
        pmin = "\(Int(minValueSelected.rounded(.up)))"
        pmax = "\(Int(maxValueSelected.rounded(.up)))"
        
        setupMinPrice()
        setupMaxPrice()
    }
    
    func rangeChangeFinished(minValueSelected: CGFloat, maxValueSelected: CGFloat, slider: RangeUISlider) {
        pmin = "\(Int(minValueSelected.rounded(.up)))"
        pmax = "\(Int(maxValueSelected.rounded(.up)))"
        
        setupMinPrice()
        setupMaxPrice()
        
        self.delegate?.priceCellValueChanged(pmin: pmin, pmax: pmax, wholeSale: wholeSale)
    }
}
