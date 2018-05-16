//
//  LoginViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/14/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var loginBtn: UIButton!
    
    @IBOutlet weak var pinBtn: UIButton!
    
    @IBAction func loginAccess(_ sender: Any) {
        let contex = LAContext()
        if contex.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: nil){
            contex.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Need Figure Print To Sign In", reply: { (wasSuccessful, error) in
                if wasSuccessful {
                    print("Granted access")
                    DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "touchID", sender: self.navigationController)
                    }
                    // segue here
                    //DispatchQueue.async(group: DispatchQueue.main, execute: {
                        // UI stuff here
                   // })
                }else{
                    
                    print("No Access, failed print")
                    
                    DispatchQueue.main.async {
                    self.pinBtn.isHidden = false
                    }
                   
                }
            })
        }else{
            print("Phone does not supoort TouchId")
            // UI code here -> Normal login screen
            DispatchQueue.main.async {
            self.performSegue(withIdentifier: "noTouch", sender: self.navigationController)
            }

        }
    }
    
    @IBAction func pinLoginBtn(_ sender: Any) {
        self.performSegue(withIdentifier: "noTouch", sender: self.navigationController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pinBtn.isHidden = true
        
        // This adds a gesture recognizer in order for the user to close the keyboard by tapping anywhere on the screen
        // other than the keyboard itself
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        // Do any additional setup after loading the view.
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
