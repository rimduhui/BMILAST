//
//  ViewController.swift
//  BMI1
//
//  Created by Release on 2016. 3. 30..
//  Copyright © 2016년 Release. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    class func doDiv100(u: Int) -> Double {
        return Double(u) * 0.01
    }
    class func doDiv2(u: Int) -> Double {
        return Double(u) * 0.5
    }
    
    let ListOfHeightsInM : Array<Double> = Array(140...220).map(ViewController.doDiv100)
    let ListOfWeightsInKg : Array<Double> = Array(80...240).map(ViewController.doDiv2)
    
    
    
    var weight : Double?
    var height : Double?
    var bmi : Double? {
        get{
            if (weight != nil) && (height != nil){
                    return weight! / (height! * height!)
            }else{
                return nil
            }
        }
    }
    @IBOutlet weak var bmi_label: UILabel!
    
    
    @IBOutlet weak var height_text_field: UITextField!

    
    @IBOutlet weak var weight_text_field: UITextField!
    
    @IBOutlet weak var heightPickerView: UIPickerView!
    
    @IBOutlet weak var weightPickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
    }
    
    func updateUI() {
        if let b = self.bmi {
            self.bmi_label.text = String (format: "%4.1f", b)
        }
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        
        guard let txt: String = textField.text else {
            return
        }

        func conv (numString: String) -> Double? {
            let result : Double? = NSNumberFormatter().numberFromString(numString)?.doubleValue
            return result
        }
        
        if let txt = textField.text {
            switch (textField) {
            case height_text_field:
                self.height = conv(txt)
                print("height",self.height)
            case weight_text_field:
                self.weight = conv(txt)
            default:
                print(" Something Wrong")
                
            }
            print("height",self.height,self.weight)
            updateUI()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch(pickerView) {
        case heightPickerView :
            return self.ListOfHeightsInM.count
        case weightPickerView :
            return self.ListOfWeightsInKg.count
        default :
            return 1
        }
    }
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch(pickerView) {
        case heightPickerView :
            return String(format: "%4.2f", self.ListOfHeightsInM[row])
        case weightPickerView :
            return String(format: "%4.1f", self.ListOfWeightsInKg[row])
        default :
            return ""
        }
    }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch(pickerView) {
        case heightPickerView :
            self.height = self.ListOfHeightsInM[row]
        case weightPickerView :
            self.weight = self.ListOfWeightsInKg[row]
        default :
            break
        }
        
        updateUI()
    }
}
