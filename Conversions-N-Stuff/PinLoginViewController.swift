//
//  PinLoginViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/14/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

import UIKit

class PinLoginViewController: UIViewController, UITextFieldDelegate {

    // new user needs a pin and to store it.
    @IBOutlet weak var NewPinLabel: UILabel!
    @IBOutlet weak var newPinField: UITextField!
    @IBOutlet weak var saveNewPinBtn: UIButton!
    
    // re-using user has pin already
    @IBOutlet weak var hasPinLabel: UILabel!
    @IBOutlet weak var hasPinField: UITextField!
    @IBOutlet weak var LoginBtn: UIButton!
    
    // store pin
    let defaults = UserDefaults.standard
    
    // first time user ever sets a pin number
    @IBAction func newLogin(_ sender: Any) {
        // dont accept a null pin
        if(newPinField.text?.isEmpty == true || hasPinField.text?.isEmpty == true) {
            
            let alert = UIAlertController(title: "Error: Missing Pin Number", message: "Please Enter A Pin Number To Login ", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
            //print("check complete")
        }
        else{
            let newPin = newPinField.text
        
            //save the post to the device
            defaults.set(newPin,forKey: "pin")
             let temp = defaults.string(forKey: "pin")
            print("continue...")
            print("Pin: ", temp! )
        }
    }
    
    // user already has a pin number
    @IBAction func login(_ sender: Any) {
        let temp = defaults.string(forKey: "pin")
        // dont accept a null pin
        if(hasPinField.text?.isEmpty == true || temp == nil) {
            
            let alert = UIAlertController(title: "Error: Missing Pin Number", message: "Please Enter A Pin Number To Login ", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
            //print("check complete")
        }
        else{
            
            let password:String = hasPinField.text!
            
            // check in console for testing
            print("Pin: ", temp!, "Entered Input",  password)
            
            // dont let them login if their pin is wrong
            if(temp! != password){
                let alert = UIAlertController(title: "Error: Login Not Granted ", message: "Try again, invalid pin", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(cancel)
                present(alert, animated: true, completion: nil)
            }
            else{
            //segue to longin screen here
            print("access granted you may enter")
            print("Pin: ", temp! )
                //let vc = passwordHolderViewController()
                //present(vc, animated: true, completion: nil)
                //self.performSegue(withIdentifier: "accessed", sender: self.navigationController)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let temp = defaults.string(forKey: "pin")
        if temp == nil{
            //hasPinField.isHidden = true
            //hasPinLabel.isHidden = true
        }
            else{
            newPinField.isHidden = true
            NewPinLabel.isHidden = true
            saveNewPinBtn.isHidden = true
            }
        
        // Do any additional setup after loading the view.
    }

    // this will ensure that the user has to use the date picker and cant input wrong dates (only #'s)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if (textField == newPinField || textField == hasPinField){
            // only allow digits in the text field
            let allowedCharacters = CharacterSet(charactersIn:"0123456789").inverted
            let components = string.components(separatedBy: allowedCharacters)
            let filtered = components.joined(separator: "")
            return string == filtered
        }
        return true
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
