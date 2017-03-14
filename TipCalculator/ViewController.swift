//
//  ViewController.swift
//  tippy
//
//  Created by YanAndy on 3/4/17.
//  Copyright © 2017 YanAndy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate{
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    var num = 1.0
    let defaults = UserDefaults.standard
    @IBOutlet weak var settingsButton: UIBarButtonItem!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var percentageTitleLabel: UILabel!
    var minimumPercentage : Double = 0
    var mediumPercentage : Double = 0
    var maximumPercentage : Double = 0
    @IBOutlet weak var onePersonTotal: UILabel!
    
    
    @IBOutlet weak var AddPerson: UIStepper!
    
    //@IBOutlet weak var numOfPeople: UITextField!
    
    @IBOutlet weak var number: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        billField.delegate = self
        billField.text = ""
        //numOfPeople.delegate = self
        let formatter = NumberFormatter()
        num = 1.0
        tipLabel.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "Tip")))
        totalLabel.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "Total")))
        onePersonTotal.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "First")))
        
        
        billField.becomeFirstResponder()
        AddPerson.becomeFirstResponder()
        defaults.set("English", forKey: "Language")
        if (defaults.integer(forKey: "Minimum") != 10 || defaults.integer(forKey: "Medium") != 15 || defaults.integer(forKey: "Maximum") != 20){

        }
        else{
            self.defaults.set(10, forKey: "Minimum")
            self.defaults.set(15, forKey: "Medium")
            self.defaults.set(20, forKey: "Maximum")
            self.defaults.synchronize()
        }
        self.settingsButton.title = "Settings"
    }
    override func viewWillAppear(_ animated: Bool) {
        billField.becomeFirstResponder()
        AddPerson.becomeFirstResponder()
        let formatter = NumberFormatter()
        
        if (defaults.integer(forKey: "Bill") == 0){
            tipLabel.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "Tip")))
            totalLabel.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "Total")))
            
            
            onePersonTotal.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "First")))
            //number.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "number")))

        }
        else{
            billField.text = String(defaults.integer(forKey: "Bill"))
            
            tipLabel.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "Tip")))
            totalLabel.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "Total")))
            onePersonTotal.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "First")))
            //number.text = formatter.string(from: NSNumber(value: defaults.integer(forKey: "number")))
        }
        if (String(describing: defaults.object(forKey: "Language")!) == "中文"){
            percentageTitleLabel.text = "百分比"
            totalTitleLabel.text = "总计"
            tipTitleLabel.text = "小费"
            self.title = "小费计算"
            self.settingsButton.title = "设置"
        }
        else {
            percentageTitleLabel.text = "Percentage"
            totalTitleLabel.text = "Total"
            tipTitleLabel.text = "Tip"
            self.title = "Tip Calculator"
            self.settingsButton.title = "Settings"
            
        }
        minimumPercentage = Double(defaults.integer(forKey: "Minimum"))
        mediumPercentage = Double(defaults.integer(forKey: "Medium"))
        maximumPercentage = Double(defaults.integer(forKey: "Maximum"))
        
        tipControl.setTitle(String(defaults.integer(forKey: "Minimum")) + "%", forSegmentAt: 0)
        tipControl.setTitle(String(defaults.integer(forKey: "Medium")) + "%", forSegmentAt: 1)
        tipControl.setTitle(String(defaults.integer(forKey: "Maximum")) + "%", forSegmentAt: 2)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onEditingChange(_ sender: AnyObject) {
        let formatter = NumberFormatter()
        var tipPercentages = [minimumPercentage/100,mediumPercentage/100,maximumPercentage/100]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        let num = AddPerson.value + 1
        number.text = String(Int(num))
        print(formatter.string(from: NSNumber(value: total)))
        tipLabel.text = formatter.string(from: NSNumber(value: tip))!
        totalLabel.text = formatter.string(from: NSNumber(value: total))!
        number.text = formatter.string(from: NSNumber(value: num))!
        onePersonTotal.text = formatter.string(from: NSNumber(value: total/num))
        defaults.set(Int(billAmount), forKey: "Bill")
        //defaults.set(Int(num), forKey: "num")
        defaults.set(Int(tip), forKey: "Tip")
        defaults.set(Int(total), forKey: "Total")
        defaults.set(Int(total/2), forKey: "First")
        defaults.set(2, forKey : "MainDidChanged")
        defaults.synchronize()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.characters.count ?? 0) + string.characters.count - range.length < 7
        
    }
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBAction func addCompanions(_ sender: UIStepper) {
        num = AddPerson.value + 1
        number.text = String(Int(num))

    }
}

