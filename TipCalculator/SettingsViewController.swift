//
//  SettingsViewController.swift
//  tippy
//
//  Created by YanAndy on 3/4/17.
//  Copyright © 2017 YanAndy. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UITextFieldDelegate {
    @IBOutlet weak var languagePicker: UIPickerView!
    let defaults = UserDefaults.standard
    var languages = ["English","中文"]
    @IBOutlet weak var languageLabel: UILabel!
    //@IBOutlet weak var themeLabel: UILabel!
    @IBOutlet weak var maximumTipLabel: UILabel!
    @IBOutlet weak var mediumTipLabel: UILabel!
    @IBOutlet weak var minimumTipLabel: UILabel!
    @IBOutlet weak var defaultTipPercentageLabel: UILabel!
    //@IBOutlet weak var changeThemeButton: UISwitch!
    
    //@IBOutlet weak var themelabelLabel: UILabel!
    @IBOutlet weak var minimumTipTextField: UITextField!
    @IBOutlet weak var mediumTipTextField: UITextField!
    @IBOutlet weak var maximumTipTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        languagePicker.delegate = self
        minimumTipTextField.delegate = self
        mediumTipTextField.delegate = self
        maximumTipTextField.delegate = self
        self.view.backgroundColor = UIColor(red: 226/255, green: 226/255, blue: 226/255, alpha: 1.0)
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }
    override func viewWillAppear(_ animated: Bool) {
        if (String(describing: defaults.object(forKey: "Language")!) == "中文"){
            languagePicker.selectRow(1, inComponent: 0, animated: true)
            self.title = "设置"
            languageLabel.text = "    语言"
            defaultTipPercentageLabel.text = "     设置百分比"
            minimumTipLabel.text = "   不满意"
            mediumTipLabel.text =  "    一般"
            maximumTipLabel.text = "    满意"
        }
        else {
            languagePicker.selectRow(0, inComponent: 0, animated: true)
        }
        minimumTipTextField.text = String(defaults.integer(forKey: "Minimum"))
        mediumTipTextField.text = String(defaults.integer(forKey: "Medium"))
        maximumTipTextField.text = String(defaults.integer(forKey: "Maximum"))
        //changeUITheme()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
        
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let language : String = languages[row]
        defaults.set(language, forKey : "Language")
        defaults.synchronize()
        if (String(describing: defaults.object(forKey: "Language")!) == "中文" || String(describing: defaults.object(forKey: "Language")!) == "语言" ){
            self.title = "设置"
            languageLabel.text = "    语言"
            defaultTipPercentageLabel.text = "    设置百分比"
            minimumTipLabel.text = "    不满意"
            mediumTipLabel.text = "    一般"
            maximumTipLabel.text = "    满意"
            //print(defaults.objectForKey("Language")!)
        }
        else {
            self.title = "Settings"
            languageLabel.text = "    Language"
            defaultTipPercentageLabel.text = "    Set Tip Percentage"
            minimumTipLabel.text = "    Unsatisfied"
            mediumTipLabel.text = "    Just so so"
            maximumTipLabel.text = "    Satisfied"
            //print(defaults.objectForKey("Language")!)
        }
        
        //print(languages)
    }
    @IBAction func onTap(_ sender: AnyObject) {
        view.endEditing(true)
    }
    @IBAction func onEditingChanged(_ sender: AnyObject) {
        
        if minimumTipTextField.text != "" {
            self.defaults.set(Int(self.minimumTipTextField.text!)!, forKey: "Minimum")
        }
        else{
            defaults.set(0, forKey: "Minimum")
        }
        if mediumTipTextField.text != ""{
            self.defaults.set(Int(self.mediumTipTextField.text!)!, forKey: "Medium")
        }
        else {
            self.defaults.set(0, forKey: "Medium")
        }
        if maximumTipTextField.text != ""{
            self.defaults.set(Int(self.maximumTipTextField.text!)!, forKey: "Maximum")
        }
        else {
            self.defaults.set(0, forKey: "Maximum")

        }
        defaults.synchronize()

    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return (textField.text?.characters.count ?? 0) + string.characters.count - range.length < 3
        
    }
    func keyboardWillShow(_ sender: Notification) {
        self.view.frame.origin.y = -80
    }
    
    func keyboardWillHide(_ sender: Notification) {
        self.view.frame.origin.y = 0
    }

    
    
}
