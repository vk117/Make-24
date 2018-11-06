//
//  NumberViewController.swift
//  Make 24
//
//  Created by Varun Khatri on 4/28/18.
//  Copyright © 2018 Varun Khatri. All rights reserved.
//

import UIKit

class NumberViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var picker1 : UIPickerView!
    @IBOutlet weak var picker2 : UIPickerView!
    @IBOutlet weak var picker3 : UIPickerView!
    @IBOutlet weak var picker4 : UIPickerView!
    @IBOutlet weak var select_button: UIButton!
    
    var rownum1: Int = Int()
    var rownum2: Int = Int()
    var rownum3: Int = Int()
    var rownum4: Int = Int()
    
    
    var pickerData: [String] = [String]()
    
    var value1:String = String()
    var value2:String = String()
    var value3:String = String()
    var value4:String = String()
    
    override func viewDidAppear(_ animated: Bool) {
        pickerView(picker1, didSelectRow: 0, inComponent: 0)
        pickerView(picker2, didSelectRow: 0, inComponent: 0)
        pickerView(picker3, didSelectRow: 0, inComponent: 0)
        pickerView(picker4, didSelectRow: 0, inComponent: 0)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker1.tag = 1
        picker2.tag = 2
        picker3.tag = 3
        picker4.tag = 4
        
        self.picker1.delegate = self
        self.picker1.dataSource = self
        
        self.picker2.delegate = self
        self.picker2.dataSource = self
        
        self.picker3.delegate = self
        self.picker3.dataSource = self
        
        self.picker4.delegate = self
        self.picker4.dataSource = self
        
        pickerData = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
        
        
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
         case 1:
         value1 = pickerData[row]
         break
         
         case 2:
         value2 = pickerData[row]
         break
         
         case 3:
         value3 = pickerData[row]
         break
         
         case 4:
         value4 = pickerData[row]
         break
         
         default:
         break
         }

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is ViewController{
            let vc = segue.destination as? ViewController
        }
    }

}
