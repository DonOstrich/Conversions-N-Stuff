//
//  MeasureViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/13/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

import UIKit

class MeasureViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    // All of the conversions allowed in the picker
    var list = ["Inches To Feet", "Inches to Miles", "Inches To Centimeters", "Inches To Meters","Inches To Kilometers", "Feet To Inches", "Feet To Miles", "Feet To Centimeters", "Feet To Meters", "Feet To Kilometers", "Miles To Inches", "Miles To Feet", "Miles To Centimeters", "Miles To Meters", "Miles To Kilometers", "Centimeters To Inches", "Centimeters To Feet", "Centimeters To Miles", "Centimeters To Meters", "Centimeters To Kilometers", "Meters To Inches", "Meters To Feet", "Meters To Miles", "Meters To Centimeters", "Meters To Kilometers", "Kilometers To Inches", "Kilometers To Feet", "Kilometers To Miles", "Kilometers To Centimeters", "Kilometers To Meters"]
    
  
    // user can only add one job at a time
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    // return the job the user has picked from the job list picker obj
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        //here
        return list[row]
        
    }
    
    //  save jobs in the appropriate fields
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        //self.taskTextbox.text = self.list[row]
        //BeginingText = taskTextbox.text!
        // once the user has picked their task close the menu..
        self.displayType.text = list[row]
        self.picker.isHidden = true
    }
    

    @IBOutlet weak var displayType: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var convertBtn: UIButton!
    @IBOutlet weak var calculateBtn: UIButton!
    @IBOutlet weak var resultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.isHidden = true
        self.displayType.isHidden = true
        // Do any additional setup after loading the view.
    }

    @IBAction func convertType(_ sender: UIButton) {
        if sender == convertBtn{
            self.picker.isHidden = false
            self.displayType.isHidden = false
        }
    }
    
    
    @IBAction func calculate(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
/*
//
//  TimeConvertorViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/13/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

import UIKit

class MeasureConvertorViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker: UIPickerView!
    
    
    @IBOutlet weak var pickType: UIButton!
    
    // All of the conversions allowed in the picker
    var list = ["Inches To Feet", "Inches to Miles", "Inches To Centimeters", "Inches To Meters","Inches To Kilometers", "Feet to Inches", "Feet to Miles", "Feet to Centimeters", "Feet to Meters", "Feet to Kilometers", "Miles to Inches", "Miles to Feet", "Miles to Centimeters", "Miles to Meters", "Miles to Kilometers", "Centimeters to Inches", "Centimeters to Feet", "Centimeters to Miles", "Centimeters to Meters", "Centimeters to Kilometers", "Meters to Inches", "Meters to Feet", "Meters to Miles", "Meters to Centimeters", "Meters to Kilometers", "Kilometers to Inches", "Kilometers to Feet", "Kilometers to Miles", "Kilometers to Centimeters", "Kilometers to Meters"]
    
    
    
    func createDatePicker(){
        //tool bar for when the date picker shows on screen
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // done button for toolbar to stop editing or picking a date
        let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([done], animated: false)
    }
    
    // when the user presses done after they have choosen a date it locks it in and goes
    // back to the main screen. IE the date picker is out of view on the screen
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //createDatePicker()
        self.picker.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    
    
    // user can only add one job at a time
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
        
    }
    
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        return list.count
        
    }
    
    // return the job the user has picked from the job list picker obj
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return list[row]
        
    }
    
    //  save jobs in the appropriate fields
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        //self.taskTextbox.text = self.list[row]
        //BeginingText = taskTextbox.text!
        // once the user has picked their task close the menu..
        self.picker.isHidden = true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
}
 */
