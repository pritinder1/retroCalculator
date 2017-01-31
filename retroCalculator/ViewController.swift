//
//  ViewController.swift
//  retroCalculator
//
//  Created by Pritinder Singh  on 1/18/17.
//  Copyright © 2017 Pritinder Singh . All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var btnSound: AVAudioPlayer!
    
    
    var runningNumber = ""
    
    var currentOperation = Operation.Empty
    var leftValStr = ""
    var rightVarStr = ""
    var result = ""
   
    @IBOutlet weak var counterInput: UILabel!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Audio Set Up

        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        
        let soundUrl = URL(fileURLWithPath: path!)
        
        do{
        
            try btnSound = AVAudioPlayer(contentsOf: soundUrl)
            btnSound.prepareToPlay()
        
        }catch let err as NSError{
        
            print(err.debugDescription)
        
        }
        
         counterInput.text = "0"
    }
    
    @IBAction func numBtnPressed(sender: UIButton) {
        playSound()
        
        runningNumber += "\(sender.tag)"
        counterInput.text = runningNumber
        
    }
    
    
    
    
    func playSound() {
        
        if btnSound.isPlaying {
            
            btnSound.stop()
        }
            btnSound.play()

        
    }
    
    
    //Logic Set Uo
    
    
    enum Operation: String {
    
    case Add = "+"
    case Subtract = "-"
    case Divide = "/"
    case Multiply = "*"
    case Empty = "Empty"
        
        
    }
    
    
    @IBAction func dividePressed(_ sender: Any) {
        
        operationProcess(operation: .Divide)
    }
    
    @IBAction func multiplyPressed(_ sender: Any) {
        
        operationProcess(operation: .Multiply)
    }
    
   @IBAction func subtractPressed(_ sender: Any) {
    
        operationProcess(operation: .Subtract)
    }
    
    @IBAction func addPressed(_ sender: Any) {
        
        operationProcess(operation: .Add)
    }
    
    @IBAction func equalPressed(_ sender: Any) {
        
        operationProcess(operation: currentOperation)
    }
    
    
    @IBAction func clearBtnPressed(_ sender: Any) {
        
        rightVarStr = ""
        leftValStr = ""
        currentOperation = Operation.Empty
        counterInput.text = "0"
    }
    
    func operationProcess(operation: Operation){
    
        if currentOperation != Operation.Empty {
        
            if runningNumber != "" {
            
                rightVarStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightVarStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightVarStr)!)"
                } else if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightVarStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightVarStr)!)"
                }
                
                leftValStr = result
                counterInput.text = result
                
            }
            
              currentOperation = operation
      
        }else {
        
            leftValStr = runningNumber
            runningNumber = ""
            currentOperation = operation
        }
        
      
        
    }

  
    
    
}
