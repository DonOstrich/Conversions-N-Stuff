//
//  MeasureViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/13/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

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


class MeasureViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    
    var units = [UnitsConv]()
    var UnitPickedConv = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.displayType.isHidden = true
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
        self.displayType.text = UnitPickedConv
        print(UnitPickedConv)
    }
    
    
    @IBOutlet weak var displayType: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var resultField: UITextField!
    @IBOutlet weak var inputField: UITextField!
    
    
    // user can pick units and conversion units from the pick. This button pulls up the picker
    @IBAction func convertType(_ sender: UIButton) {
        if sender == convertBtn{
            self.picker.isHidden = false
            self.displayType.isHidden = false
        }
    }
    
    // Once the user has clicked this button there units will be calculated and displayed on the
    // textfield. The input textfield must input else throw and alert and don't do the calculation
    @IBAction func calculate(_ sender: UIButton) {
        if sender == calculateBtn{
            self.picker.isHidden = true
            self.displayType.isHidden = false
        }
        
        // dont allow nothing to be inputed
        if(inputField.text?.isEmpty == true ) {
            let alert = UIAlertController(title: "Error: Missing field", message: "Please fill out the Input field before a Conversion is Preformed", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
            //print("check complete")
        } else {
            
            
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


