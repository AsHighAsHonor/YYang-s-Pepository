//
//  CalculatorBrain.swift
//  MyFirstSwift
//
//  Created by YYang on 16/01/2017.
//  Copyright © 2017 YYang. All rights reserved.
//

import Foundation

///定义一个名为MathematicalOperations的枚举 这个定义不提供任何关联的实际值，它只是定义了当MathematicalOperations constant/unaryOperation.....时候关联值的类型
private enum MathematicalOperations {
    case constant(Double) ///constant关联一个 double 类型的值
    case unaryOperation((Double)->(Double))   ///unaryOperation关联一个函数类型的值
    case binaryOperation((Double,Double)->(Double))
    case equales
}

///定义一个名为PendingOperationInfo 的结构体  保存用于二元运算 第一次输入的数字  .  实际运算的函数
private struct PendingOperationInfo {
    var firstOperand : Double //第一次输入的数字
    var binaryFunction : (Double,Double)->Double //计算函数
}


///累加器
private var accumulator : Double = 0.0

///二元运算信息   可能为nil
private var pending : PendingOperationInfo?



class CalculatorBrain{
    
    
    ///定义一个字典来保存文本字符和枚举的映射关系
    private let operationsDic : Dictionary<String,MathematicalOperations> = [
        "AC":MathematicalOperations.constant(0.0),
        "√": .unaryOperation(sqrt), //省略枚举类型写法
        "cos":MathematicalOperations.unaryOperation(cos), //使用枚举时需要传入枚举关联类型的值
        "+-":MathematicalOperations.unaryOperation({ (operand) -> (Double) in
            return -operand
        }),
        "%":MathematicalOperations.unaryOperation({ (operand) -> (Double) in
            return operand * 0.01
        }),
        "=":MathematicalOperations.equales, //使用枚举时需要传入枚举关联类型的值
        "+":MathematicalOperations.binaryOperation({ (operand1, operand2) -> (Double) in
            return operand1+operand2
        }),
        "-":MathematicalOperations.binaryOperation({ (operand1, operand2) -> (Double) in
            return operand1-operand2
        }),
        "x":MathematicalOperations.binaryOperation({ (operand1, operand2) -> (Double) in
            return operand1*operand2
        }),
        "÷":MathematicalOperations.binaryOperation({ (operand1, operand2) -> (Double) in
            return operand1/operand2
        }),
        
        ]
    

    
    ///计算属性用于获取输入的值 / 计算返回的值
    func setOperand(operand :String) -> (){
            accumulator = Double(operand)!
    }
    
    var result : String{
        return "\(accumulator)"
    }
    

    /// 点击数学符号的操作
    /// - Parameter operand: 点击的符号
    func mathematicalOperate(mathematicalSymbol:String) -> () {
        if let operation = operationsDic[mathematicalSymbol] {
            switch operation {
            case .constant(let associatedValue):   //使用 let 获取到传入时关联的值
                accumulator = associatedValue
                
                
            case .unaryOperation(let unaryFunc):
                accumulator = unaryFunc(accumulator)
                
            case .binaryOperation(let binaryFunc)://二元运算
                pending = PendingOperationInfo.init(firstOperand: accumulator, binaryFunction: binaryFunc) //初始化结构体
                
            case .equales://相等
                if let p  = pending {//可选类型解包
                    accumulator = p.binaryFunction(p.firstOperand ,accumulator)
                    pending = nil;
                }
            default:
                break;
            }
        }

    }
    

    
}
