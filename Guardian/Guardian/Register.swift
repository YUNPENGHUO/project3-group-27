//
//  Register.swift
//  Guardian
//
//  Created by ChengZHU on 2018/6/2.
//  Copyright © 2018年 Edwardchen. All rights reserved.
//

import UIKit

class Register: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let isNil = UserDefaults.standard.string(forKey: "userName");
        if isNil == nil {
        }
        else {
            let lastView1 = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            self.present(lastView1, animated: true, completion: nil)
            // Show the main page
        }
    }
    // Check if the user information has been saved, if is, the register page will be skipped
    
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emerNameText: UITextField!
    @IBOutlet weak var emerNumText: UITextField!
    
    @IBAction func savedata(_ sender: Any) {
        let userNameThis = userNameText.text;
        let emerNameThis = emerNameText.text;
        let emerNumThis = emerNumText.text;
        UserDefaults.standard.set(userNameThis, forKey: "userName");
        UserDefaults.standard.set(emerNameThis, forKey: "emerName");
        UserDefaults.standard.set(emerNumThis, forKey: "emerNum");
        // Save the user data by userdefault
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
        // Hide the keyboard
    }
    
}
