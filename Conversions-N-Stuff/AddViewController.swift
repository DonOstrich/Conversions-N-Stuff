//
//  AddViewController.swift
//  Conversions-N-Stuff
//
//  Created by Don Ostergaard on 5/14/18.
//  Copyright © 2018 Don Ostergaard. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    
    @IBOutlet weak var accountField: UITextField!
    @IBOutlet weak var field: UITextField!
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationController?.isNavigationBarHidden = false
        //tableView.reloadData()
        
    }
    
    
    @IBAction func add(_ sender: Any) {
        
        if (field.text != nil) && field.text != "" && (accountField.text != nil) && accountField.text != ""{
            account?.append(accountField.text!)
            accountField.text = ""
            accountField.placeholder = "Add Account ?"
            
            todoList?.append(field.text!)
            field.text = ""
            field.placeholder = "Add More ?"
            showToast(message: "Password Added")
        }
        else{
            let alert = UIAlertController(title: "Error: Fields Not Filled out", message: "Please enter an account and a password", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            print("No Access, failed print")
        }
    }
    
    func showToast(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 75, y: self.view.frame.size.height-100, width: 150, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  
}
