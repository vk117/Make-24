//
//  ViewController.swift
//  Make 24
//
//  Created by Varun Khatri on 4/21/18.
//  Copyright © 2018 Varun Khatri. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var labels = [UILabel]()
    var buttons = [UIButton]()
    var numericexpression = "10 - 3";
    var num1=0;
    var num2=0;
    var num3=0;
    var num4=0;
    var expression = "";
    var attempt_count:Int = 1
    var success_count:Int = 0
    var items: Array<UIBarButtonItem> = []
    var skipped_count:Int = 0
    
    var count = 0
    var tenthpos = 0
    var timer = Timer()
    var minutes = 0
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var attempt: UILabel!
    @IBOutlet weak var succeeded: UILabel!
    @IBOutlet weak var skipped: UILabel!
    @IBOutlet weak var show: UILabel!
    
    @IBOutlet weak var number1: UIButton!
    @IBOutlet weak var number2: UIButton!
    @IBOutlet weak var number3: UIButton!
    @IBOutlet weak var number4: UIButton!
    
    @IBOutlet weak var plus: UIButton!
    @IBOutlet weak var minus: UIButton!
    @IBOutlet weak var multiply: UIButton!
    @IBOutlet weak var divide: UIButton!
    
    @IBOutlet weak var open: UIButton!
    @IBOutlet weak var close: UIButton!
    @IBOutlet weak var delete: UIButton!
    @IBOutlet weak var done: UIButton!
    
    
    
    @IBAction func enterCharacter(_sender: UIButton){
        var character = (_sender.title(for: .normal) ?? "")
        let pnumber:Int? = Int(character)
        expression.append(character)
        done.isEnabled = true
        done.alpha = 1.0
        delete.isEnabled = true
        delete.alpha = 1.0
        display.text = expression
        if pnumber is Int {
            _sender.isEnabled = false
            _sender.alpha = 0.5
        }
    }
    
    @IBAction func evaluateExpr(_sender: UIButton){
        
        attempt_count = attempt_count + 1
        
        attempt.text = String(attempt_count)
        
        let nsexpression = NSExpression(format: expression)
        if let result = nsexpression.expressionValue(with: nil, context: nil) as? Int{

            expression = String(result)
            if result == 24{
                let alert = UIAlertController(title: "Success", message: "You made 24!", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Next Puzzle", style: UIAlertActionStyle.default, handler: {action in self.cleanSlate()}))
                
                self.present(alert, animated: true, completion: nil)
                
                success_count = success_count + 1
                succeeded.text = String(success_count)
            }
            else{
                let alert = UIAlertController(title: "Sorry", message: "Try again", preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "Continue", style: UIAlertActionStyle.default, handler: {action in self.tryAgain()}))
                
                self.present(alert, animated: true, completion: nil)
                
            }
        }
        else{
            display.text = "error"
        }
    }
    
    @IBAction func backspace(_sender: UIButton){
       
        var removed = String(expression.removeLast());
        if removed == String(num1) {
            number1.isEnabled = true
            number1.alpha = 1.0
        }
        if removed == String(num2) {
            number2.isEnabled = true
            number2.alpha = 1.0
        }
        if removed == String(num3) {
            number3.isEnabled = true
            number3.alpha = 1.0
        }
        if removed == String(num4) {
            number4.isEnabled = true
            number4.alpha = 1.0
        }
        display.text = expression
        if expression.isEmpty{
            done.isEnabled = false
            done.alpha = 0.5
            _sender.isEnabled = false
            _sender.alpha = 0.5
            
        }
    }
    
    func cleanSlate(){
        expression = ""
        display.text = expression
        
        num1 = Int(arc4random_uniform(9) + 1)
        num2 = Int(arc4random_uniform(9) + 1)
        num3 = Int(arc4random_uniform(9) + 1)
        num4 = Int(arc4random_uniform(9) + 1)
        
        number1.setTitle(String(num1), for: .normal)
        number2.setTitle(String(num2), for: .normal)
        number3.setTitle(String(num3), for: .normal)
        number4.setTitle(String(num4), for: .normal)
        
        number1.isEnabled = true
        number2.isEnabled = true
        number3.isEnabled = true
        number4.isEnabled = true
        
        number1.alpha = 1.0
        number2.alpha = 1.0
        number3.alpha = 1.0
        number4.alpha = 1.0
        
        attempt_count = 1
        attempt.text = String(attempt_count)
        
        count = 0
        minutes = 0
        tenthpos = 0
        
    }
    
    @objc func skip(){
        cleanSlate()
        skipped_count = skipped_count + 1
        skipped.text = String(skipped_count)
        count = 0
        minutes = 0
        tenthpos = 0
    }
    
    @objc func tryAgain(){
        expression = ""
        display.text = expression
        
        number1.isEnabled = true
        number2.isEnabled = true
        number3.isEnabled = true
        number4.isEnabled = true
        
        number1.alpha = 1.0
        number2.alpha = 1.0
        number3.alpha = 1.0
        number4.alpha = 1.0
        
        
    }
    
    @objc func push(){
        performSegue(withIdentifier: "choosenum", sender: self)
    }
    
    @IBAction func getnums(segue: UIStoryboardSegue){
        if segue.source is NumberViewController{
            
                count = 0
                minutes = 0
                tenthpos = 0
            
                if let senderVC = segue.source as? NumberViewController{
                
                number1.setTitle(senderVC.value1, for: .normal)
                number2.setTitle(senderVC.value2, for: .normal)
                number3.setTitle(senderVC.value3, for: .normal)
                number4.setTitle(senderVC.value4, for: .normal)
                
                expression = ""
                display.text = expression
                
                skipped_count = skipped_count + 1
                skipped.text = String(skipped_count)
            }
            
        }
    }
    
    @objc func counter(){
        count += 1
        if count == 10{
            tenthpos += 1
            count = 0
            if tenthpos == 6 {
                minutes += 1
                tenthpos = 0
                count = 0
                time.text = String(minutes) + ":" + String(tenthpos) + String(count)
            }
            else{
                time.text = String(minutes) + ":" + String(tenthpos) + String(count)
            }
        }
        else{
            time.text = String(minutes) + ":" + String(tenthpos) + String(count)
        }
    }
    
    
    
    
    
    override func viewDidLoad() {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.counter), userInfo: nil, repeats: true)
        
        time.text = "0:00"
        
        super.viewDidLoad()
        labels.append(time)
        labels.append(display)
        labels.append(attempt)
        labels.append(succeeded)
        labels.append(skipped)
        
        buttons.append(number1)
        buttons.append(number2)
        buttons.append(number3)
        buttons.append(number4)
        
        buttons.append(plus)
        buttons.append(minus)
        buttons.append(multiply)
        buttons.append(divide)
        
        buttons.append(open)
        buttons.append(close)
        buttons.append(delete)
        buttons.append(done)
        
        
        for label in labels{
            label.layer.borderWidth = 1.0
            label.layer.borderColor = UIColor.black.cgColor
        }
        
        for button in buttons{
            button.layer.borderWidth = 1.0
            button.layer.borderColor = UIColor.black.cgColor
        }
            
         num1 = Int(arc4random_uniform(9) + 1)
         num2 = Int(arc4random_uniform(9) + 1)
         num3 = Int(arc4random_uniform(9) + 1)
         num4 = Int(arc4random_uniform(9) + 1)
            
        number1.setTitle(String(num1), for: .normal)
        number2.setTitle(String(num2), for: .normal)
        number3.setTitle(String(num3), for: .normal)
        number4.setTitle(String(num4), for: .normal)
        
        if expression.isEmpty{
            done.isEnabled = false
            done.alpha = 0.5
            delete.isEnabled = false
            delete.alpha = 0.5
        }
        
        attempt.text = String(attempt_count)
        succeeded.text = String(success_count)
        skipped.text = String(skipped_count)
        
        let cross = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(self.tryAgain))
        let skip = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fastForward, target: self, action: #selector(self.skip))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.fixedSpace, target: nil, action: nil)
        let select = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.compose, target: self, action: #selector(self.push))
        let cnfirm = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.search, target: self, action: nil)
        //show = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: nil)
        
        space.width = 90.0
        
        items.append(cross)
        items.append(space)
        items.append(skip)
        items.append(space)
        items.append(select)
        items.append(space)
        items.append(cnfirm)
        
        self.setToolbarItems(items, animated: true)
        self.navigationController?.setToolbarHidden(false, animated: true)
        
        }
    

    }



