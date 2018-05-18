//
//  ViewController.swift
//  EmojiMap
//
//  Created by Matias Villaverde on 09.01.18.
//  Copyright © 2018 Matias Villaverde. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let mapping = EmojiMap()
    
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userOutput: UILabel!
    @IBOutlet weak var map: UIButton!
    @IBOutlet weak var randomSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userInput.delegate = self
        
        for match in mapping.getMatchesFor("Dog") {
            print(match.emoji)
        }
        
    }
    
    @IBAction func mapTapped(_ sender: Any) {
        textFieldDidEndEditing(userInput)
        view.endEditing(true) // Hide keyboard
    }
    
    // When tap outside the controls, hide the keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = textField.text else { return }
        
        var result = "Result: "
        
        if randomSwitch.isOn {
            for match in mapping.getSingleRandomMatchesFor(text) {
                result += "\(match.emoji) "
            }
        } else {
            for match in mapping.getMatchesFor(text) {
                result += "\(match.emoji) "
            }
        }
        
        userOutput.text = result
        
    }
    
    // When tap Done on the keyboard, hide it
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
}

