//
//  ViewController.swift
//  MyFirstSwift
//
//  Created by YYang on 13/01/2017.
//  Copyright © 2017 YYang. All rights reserved.
//

import UIKit



class ViewController: UIViewController {

    @IBOutlet private weak var displayLab: UILabel!
    
    
    private var isCalculated = false
    ///模型
    private var brain : CalculatorBrain?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            }
    

    @IBAction private func numPadBtnClicked(_ sender: UIButton) {
        let clickedNum = sender.currentTitle!
        
        //输入时去掉默认显示的0
        if displayLab.text! == "0.0" || isCalculated  {
            displayLab.text! = ""
        }
        
        if displayLab.text! == "0.0" && clickedNum=="." {
            return;
        }
        
        displayLab.text =  displayLab.text! + clickedNum
        isCalculated = false;

        
        
    }
    
    
    @IBAction private func performOperation(_ sender: UIButton) {
        let currentMathematicalSymbol = sender.currentTitle!
        
        if brain == nil {
            brain = CalculatorBrain()
        }
        brain!.setOperand(operand : displayLab.text!)//传值
        brain!.mathematicalOperate(mathematicalSymbol : currentMathematicalSymbol)//传符号
        displayLab.text = brain!.result//获取值
        isCalculated = true
    }
    
    
    
}

