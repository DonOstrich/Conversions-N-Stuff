//
//  MeasureViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/13/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
// git 

import Foundation
import UIKit

// this class will allow us to populate the picker with 2 columns with the right conversion types
class UnitsConv {
    var startUnit: String
    var convertUnit: [String]
    
    init(startUnit:String, convertUnit:[String]) {
        self.startUnit = startUnit
        self.convertUnit = convertUnit
    }
}

extension Double {
    // round converions numbers by the places given
    func round(number: Double, to places: Int)->String{
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        formatter.roundingMode = NumberFormatter.RoundingMode.halfUp
        formatter.maximumFractionDigits = places
        let myNumber = NSNumber(value: number)
        let roundedValue1 = formatter.string(from: myNumber)
        return (roundedValue1!)
        
    }
    
}



class MeasureViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    var units = [UnitsConv]()
    var UnitPickedConv = ""
    
    //@IBOutlet weak var displayType: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var resultField: UITextField!
    @IBOutlet weak var inputField: UITextField!
    @IBOutlet weak var header: UILabel!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // This adds a gesture recognizer in order for the user to close the keyboard by tapping anywhere on the screen
        // other than the keyboard itself
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // setting up all the arrays for all possible conversions between units. Will show in Picker
        units.append(UnitsConv(startUnit: "Inches", convertUnit: ["Feet", "Yard", "Mile", "Centimeter", "Meter", "Kilometer"]))
        
        units.append(UnitsConv(startUnit: "Centimeter", convertUnit: ["Meter", "Kilometer", "Inches", "Feet", "Yard", "Mile"]))
        
        units.append(UnitsConv(startUnit: "Feet", convertUnit: ["Inches", "Yard", "Mile", "Centimeter", "Meter", "Kilometer"]))
        
        units.append(UnitsConv(startUnit: "Meter", convertUnit: ["Centimeter", "Kilometer", "Inches", "Feet", "Yard", "Mile"]))
        
        units.append(UnitsConv(startUnit: "Yard", convertUnit: ["Inches", "Feet", "Mile", "Centimeter", "Meter", "Kilometer"]))
        
        units.append(UnitsConv(startUnit: "Mile", convertUnit: ["Inches", "Feet", "Yard", "Centimeter", "Meter", "Kilometer"]))
        
        units.append(UnitsConv(startUnit: "Kilometer", convertUnit: ["Centimeter", "Meter", "Inches", "Feet", "Yard", "Mile"]))
        
        self.inputField.delegate = self
        self.picker.isHidden = true
        //self.displayType.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    // user can pick staring units and then convert units (picker has 2 columns)
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 2
        
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        
        if component == 0 {
            return units.count
        }
        else {
            let selectedUnit = pickerView.selectedRow(inComponent: 0)
            return units[selectedUnit].convertUnit.count
        }
        
    }
    
    // get the units and coversion type from the picker once user has selected them
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        // let the user pick units by each row independently
        self.view.endEditing(true)
        
        // left column (unit given by user)
        if component == 0 {
            return units[row].startUnit
        }
            // right column (unit to conver input to)
        else {
            let selectedUnit = pickerView.selectedRow(inComponent: 0)
            return units[selectedUnit].convertUnit[row]
        }
        
    }
    
    //  save jobs in the appropriate fields
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        // here we will save off both rows from the picker. The 1st is the unit to be converted,
        // the 2nd is what the user wants to convert it to. Then it will be saved into a string and
        // it will be displayed to the user using the displayType label.
        pickerView.reloadComponent(1)
        let selectedUnit = pickerView.selectedRow(inComponent: 0)
        let selectedConversionUnit = pickerView.selectedRow(inComponent: 1)
        let givenUnit = units[selectedUnit].startUnit
        let ConvUnit = units[selectedUnit].convertUnit[selectedConversionUnit]
        
        UnitPickedConv = "\(givenUnit) to \(ConvUnit)"
        //self.displayType.text = UnitPickedConv
        self.header.text = UnitPickedConv
        print(UnitPickedConv)
    }
    
    // user can pick units and conversion units from the pick. This button pulls up the picker
    @IBAction func convertType(_ sender: UIButton) {
        self.view.endEditing(true)
        if sender == convertBtn{
            self.picker.isHidden = false
            //self.displayType.isHidden = false
        }
    }
    
    // Once the user has clicked this button there units will be calculated and displayed on the
    // textfield. The input textfield must input else throw and alert and don't do the calculation
    @IBAction func calculate(_ sender: UIButton) {
        self.view.endEditing(true)
        var x = 0.0
        if sender == calculateBtn{
            self.picker.isHidden = true
            //self.displayType.isHidden = false
        }
        
        // dont allow nothing to be inputed
        if(inputField.text?.isEmpty == true ) {
            let alert = UIAlertController(title: "Error: Missing Input", message: "Please fill out the Input field to preform a Conversion", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        // do the conversion calculations for the user and display it on the screen
        } else {
            let hold = UnitPickedConv
            switch hold {
            //===================== inches to converted units V================================//
            case "Inches to Feet":  x = Double(inputField.text!)!
                                    x =  x / 12
            resultField.text = String(x.round(number: x, to: 3)) + " Feet"
                
            case "Inches to Yard":  x = Double(inputField.text!)!
                                    x =  x / 36
                                    resultField.text = String(x.round(number: x, to: 4)) + " Yard(s)"
               
            case "Inches to Mile":  x = Double(inputField.text!)!
                                    x =  x / 63360
                                    resultField.text = String(x.round(number: x, to: 7)) + " Mile(s)"
              
            case "Inches to Centimeter":    x = Double(inputField.text!)!
                                            x =  x *  2.54
                                            resultField.text = String(x.round(number: x, to: 4)) + " cm(s)"
                
            case "Inches to Meter": x = Double(inputField.text!)!
                                    x =  x *  0.0254
                                    resultField.text = String(x.round(number: x, to: 6)) + " Meter(s)"
                
            case "Inches to Kilometer": x = Double(inputField.text!)!
                                        x =  x *  2.54E-5
                                        resultField.text = String(x.round(number: x, to: 8)) + " Km(s)"
             
            //===================== C.M. to converted units V================================//
            case "Centimeter to Meter": x = Double(inputField.text!)!
                                        x =  x / 100
                                        resultField.text = String(x.round(number: x, to: 6)) + " Meter(s)"
                
            case "Centimeter to Kilometer": x = Double(inputField.text!)!
                                            x =  x / 100000
                                            resultField.text = String(x.round(number: x, to: 8)) + " Km(s)"
                
            case "Centimeter to Inches": x = Double(inputField.text!)!
                                         x =  x / 2.54
                                         resultField.text = String(x.round(number: x, to: 4)) + " Inches"
                
            case "Centimeter to Feet":  x = Double(inputField.text!)!
                                        x =  x / 30.48
                                        resultField.text = String(x.round(number: x, to: 4)) + " Feet"
                
            case "Centimeter to Yard":  x = Double(inputField.text!)!
                                        x =  x / 91.44
                                        resultField.text = String(x.round(number: x, to: 4)) + " Yard(s)"
                
            case "Centimeter to Mile":  x = Double(inputField.text!)!
                                        x =  x / 160934.4
                                        resultField.text = String(x.round(number: x, to: 7)) + " Mile(s)"
                
            //===================== Feet to converted units V================================//
            case "Feet to Inches":  x = Double(inputField.text!)!
                                    x =  x * 12
                                    resultField.text = String(x.round(number: x, to: 3)) + " Inches"
                
            case "Feet to Yard":    x = Double(inputField.text!)!
                                    x =  x / 3
                                    resultField.text = String(x.round(number: x, to: 4)) + " Yard(s)"
                                    //resultField.text = String(format: "%.4f", (x))
                                    //resultField.text = resultField.text! + String(" Yard(s)")
                
            case "Feet to Mile":    x = Double(inputField.text!)!
                                    x =  x / 5280
                                    resultField.text = String(x.round(number: x, to: 7)) + " Mile(s)"
                
            case "Feet to Centimeter":  x = Double(inputField.text!)!
                                        x =  x * 30.48
                                        resultField.text = String(x.round(number: x, to: 4)) + " cm(s)"
                
            case "Feet to Meter":   x = Double(inputField.text!)!
                                    x =  x *  0.3048
                                    resultField.text = String(x.round(number: x, to: 6)) + " Meter(s)"
                
            case "Feet to Kilometer":   x = Double(inputField.text!)!
                                        x =  x *  0.0003048
                                        resultField.text = String(x.round(number: x, to: 8)) + " Km(s)"
             
            //===================== Meters to converted units V================================//
            case "Meter to Centimeter": x = Double(inputField.text!)!
                                        x =  x * 100
                                        resultField.text = String(x.round(number: x, to: 6)) + " cm(s)"
                
            case "Meter to Kilometer":  x = Double(inputField.text!)!
                                        x =  x / 1000
                                        resultField.text = String(x.round(number: x, to: 8)) + " Km(s)"
                
            case "Meter to Inches": x = Double(inputField.text!)!
                                    x =  x / 0.0254
                                    resultField.text = String(x.round(number: x, to: 4)) + " Inches"
                
            case "Meter to Feet":   x = Double(inputField.text!)!
                                    x =  x / 0.3048
                                    resultField.text = String(x.round(number: x, to: 4)) + " Feet"
                
            case "Meter to Yard":   x = Double(inputField.text!)!
                                    x =  x / 0.9144
                                    resultField.text = String(x.round(number: x, to: 4)) + " Yard(s)"
                
            case "Meter to Mile":   x = Double(inputField.text!)!
                                    x =  x / 1609.344
                                    resultField.text = String(x.round(number: x, to: 7)) + " Mile(s)"
                
            //===================== Yards to converted units V================================//
            case "Yard to Inches":  x = Double(inputField.text!)!
                                    x =  x * 36
                                    resultField.text = String(x.round(number: x, to: 3)) + " Inches"
                
            case "Yard to Feet":    x = Double(inputField.text!)!
                                    x =  x * 3
                                    resultField.text = String(x.round(number: x, to: 4)) + " Feet"
                
            case "Yard to Mile":    x = Double(inputField.text!)!
                                    x =  x / 1760
                                    resultField.text = String(x.round(number: x, to: 7)) + " Mile(s)"
                
            case "Yard to Centimeter":  x = Double(inputField.text!)!
                                        x =  x * 91.44
                                        resultField.text = String(x.round(number: x, to: 4)) + " cm(s)"
                
            case "Yard to Meter":   x = Double(inputField.text!)!
                                    x =  x * 0.9144
                                    resultField.text = String(x.round(number: x, to: 6)) + " Meter(s)"
                
            case "Yard to Kilometer":   x = Double(inputField.text!)!
                                        x =  x * 0.0009144
                                        resultField.text = String(x.round(number: x, to: 8)) + " Km(s)"
            
            //===================== Miles to converted units V================================//
            case "Mile to Inches":  x = Double(inputField.text!)!
                                    x =  x * 63360
                                    resultField.text = String(x.round(number: x, to: 3)) + " Inches"
                
            case "Mile to Feet":    x = Double(inputField.text!)!
                                    x =  x * 5280
                                    resultField.text = String(x.round(number: x, to: 4)) + " Feet"
                
            case "Mile to Yard":    x = Double(inputField.text!)!
                                    x =  x * 1760
                                    resultField.text = String(x.round(number: x, to: 7)) + " Yard(s)"
                
            case "Mile to Centimeter":  x = Double(inputField.text!)!
                                        x =  x * 160934.4
                                        resultField.text = String(x.round(number: x, to: 4)) + " cm(s)"
                
            case "Mile to Meter":   x = Double(inputField.text!)!
                                    x =  x * 1609.344
                                    resultField.text = String(x.round(number: x, to: 6)) + " Meter(s)"
                
            case "Mile to Kilometer":   x = Double(inputField.text!)!
                                        x =  x * 1.609344
                                        resultField.text = String(x.round(number: x, to: 8)) + " Km(s)"
            
            //===================== Kilometers to converted units V================================//
            case "Kilometer to Centimeter": x = Double(inputField.text!)!
                                             x =  x * 100000
                                             resultField.text = String(x.round(number: x, to: 6)) + " Centimeter(s)"
                
            case "Kilometer to Meter":     x = Double(inputField.text!)!
                                            x =  x * 1000
                                            resultField.text = String(x.round(number: x, to: 8)) + " Meter(s)"
                
            case "Kilometer to Inches": x = Double(inputField.text!)!
                                         x =  x / 0.0000254
                                         resultField.text = String(x.round(number: x, to: 4)) + " Inches"
                
            case "Kilometer to Feet":   x = Double(inputField.text!)!
                                         x =  x / 0.0003048
                                         resultField.text = String(x.round(number: x, to: 4)) + " Feet"
                
            case "Kilometer to Yard":   x = Double(inputField.text!)!
                                         x =  x / 0.0009144
                                         resultField.text = String(x.round(number: x, to: 4)) + " Yard(s)"
                
            case "Kilometer to Mile":   x = Double(inputField.text!)!
                                         x =  x / 1.609344
                                         resultField.text = String(x.round(number: x, to: 7)) + " Mile(s)"
                
            default: print("Another state (not conversion type)...")
            }
            
        }
    }
    
    
    // this will ensure that the user has to use numbers and 1 decimal point
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == inputField){
            // only allow digits in the text field
            let allowedCharacters = CharacterSet(charactersIn:".0123456789").inverted
            let components = string.components(separatedBy: allowedCharacters)
            let filtered = components.joined(separator: "")
            if (textField.text?.contains("."))!, string.contains(".") {
                return false
            }
            return string == filtered
        }
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
}


