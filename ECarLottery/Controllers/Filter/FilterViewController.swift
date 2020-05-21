//
//  FilterViewController.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/20/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.
//

import UIKit
import MultiSlider

struct TypeData {
    var key: String = ""
    var value: String = ""
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var priceRangeView: UIView!
    @IBOutlet weak var lblMinPrice: UILabel!
    @IBOutlet weak var lblMaxPrice: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var txtType: UITextField!
    
    let priceRangeSlider = MultiSlider()
    let distanceLabel = UILabel()
    
    let typePicker: UIPickerView = UIPickerView()
    var typeArray: [TypeData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        setUpData()
        setupSliders()
        setUpGestureRecognizer()
        
        typePicker.delegate = self
        typePicker.dataSource = self
        txtType?.inputView = typePicker
    }
    
    func setUpData(){
        
        typeArray = [TypeData.init(key: "1", value: "Vehicles"), TypeData.init(key: "2", value: "Items")]
    }
    
    private func setupPriceRangeSlider(horizontalMultiSlider : MultiSlider){
        
        horizontalMultiSlider.snapStepSize = 1
        horizontalMultiSlider.orientation = .horizontal
        horizontalMultiSlider.minimumValue = 0
        horizontalMultiSlider.maximumValue = 50
        horizontalMultiSlider.tintColor = UIColor.red
        horizontalMultiSlider.outerTrackColor = .gray
        horizontalMultiSlider.valueLabelPosition = .top
        horizontalMultiSlider.tintColor = #colorLiteral(red: 0.967605412, green: 0.08968348056, blue: 0.003509904956, alpha: 1)
        horizontalMultiSlider.trackWidth = 1
        horizontalMultiSlider.showsThumbImageShadow = false
        horizontalMultiSlider.valueLabelPosition = .notAnAttribute
        horizontalMultiSlider.value = [0, 50]
        priceRangeView.addConstrainedSubview(horizontalMultiSlider, constrain: .leftMargin, .rightMargin, .topMargin)
        
        distanceLabel.font = distanceLabel.font.withSize(11)
        distanceLabel.textAlignment = .center
        distanceLabel.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        priceRangeView.addConstrainedSubview(distanceLabel, constrain: .leftMargin, .bottomMargin)
        priceRangeView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 8, right: 20)
        
        //            if(filterViewModel.age.count > 0){
        //                guard let floatVal1 = NumberFormatter().number(from: filterViewModel.age[0]) else { return }
        //                guard let floatVal2 = NumberFormatter().number(from: filterViewModel.age[1]) else { return }
        //                ageLabel.text = "\(Int(truncating: floatVal1)) to \(Int(truncating: floatVal2)) age"
        //                horizontalMultiSlider.value = [floatVal1, floatVal2] as! [CGFloat]
        //            } else {
        //                horizontalMultiSlider.value = [16, 100]
        //                ageLabel.text = "16 to 100 age"
        //            }
        
        lblMinPrice.text = "0"
        lblMaxPrice.text = "50"
        
    }
    
    @objc func ageSliderChanged(slider: MultiSlider) {
        print("\(slider.value)")
        lblMinPrice.text =  "\(Int(slider.value[0]))"
        lblMaxPrice.text =  "\(Int(slider.value[1]))"
        
    }
    
    @objc func ageSliderDragEnded(slider: MultiSlider) {
        print("\(slider.value)")
        
    }
    
    private func setupSliders(){
        
        setupPriceRangeSlider(horizontalMultiSlider: priceRangeSlider)
        //Actions
        priceRangeSlider.addTarget(self, action: #selector(FilterViewController.ageSliderChanged(slider:)), for: .valueChanged)
        priceRangeSlider.addTarget(self, action: #selector(FilterViewController.ageSliderDragEnded(slider:)), for: . touchUpInside)
    }
    
    private func setUpGestureRecognizer(){
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeViewAction(_:)))
        backgroundView.addGestureRecognizer(tap)
        backgroundView.isUserInteractionEnabled = true
    }
    
    // function which is triggered when handleTap is called
    @objc func closeViewAction(_ sender: UITapGestureRecognizer) {
          self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnFilterAction(_ sender: Any) {
        
    }
    
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //MARK: - UIPickerView delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerView == typePicker) {
            return typeArray.count
            
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (pickerView == typePicker) {
            return typeArray[row].value
        }  else {
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (pickerView == typePicker) {
            let filterType: String = typeArray[row].value
            txtType?.text = filterType
        }
    }
}
