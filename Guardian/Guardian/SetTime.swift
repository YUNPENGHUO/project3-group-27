//
//  SetTime.swift
//  Guardian
//
//  Created by ChengZHU on 2018/6/2.
//  Copyright © 2018年 Edwardchen. All rights reserved.
//

import UIKit

class SetTime: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var setTime: UIDatePicker!
    @IBOutlet weak var des: UITextField!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "startTimer" {
            if let timeGuardian = segue.destination as? TimeGuardian {
                timeGuardian.setTime = Int(setTime.countDownDuration)
                timeGuardian.des = String(des.text!);
                // Get the value of the datepicker and the text of the description and transfer to next view
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
        // Hide the keyboard
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
