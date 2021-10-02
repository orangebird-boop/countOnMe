//
//  CalculatorBrain.swift
//  CountOnMe
//
//  Created by Nora Lilla Matyassi on 21/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculatorBrain {

    enum CalculatorBrainError: Error {
        case invalidExpression
        case notEnoughElementInExpression

    }

    var elements: [String] = []

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "*"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    func processPriorities() -> [String]{
        var processing: [String] = []
      //  var leftOperand: Float = 0
      //  var rightOperand: Float = 0



        var index = 0

        while index < elements.count {
            let element = elements[index]
            if element == "*" || element == "÷" {
                let leftOperand = Float(processing.popLast()!)
                let rightOperand = Float(elements[index+1])!

                switch element {
                case "*": processing.append(String(leftOperand! * rightOperand))
                case "÷": processing.append(String(leftOperand! / rightOperand))
                default: fatalError("Unknown operator !")
                }
                index += 1
            } else {
                processing.append(element)
            }
            index += 1
        }

        return processing
    }

    func executeCalculus()-> Result<String, CalculatorBrainError> {

        guard expressionIsCorrect else {
            return .failure(.invalidExpression)

        }

        guard expressionHaveEnoughElement else {
            return .failure(.notEnoughElementInExpression)

        }

        // Create local copy of operations
     //   var operationsToReduce = elements
        // the process priorities functions returns an array to reduce
        var operationsToReduce = processPriorities()
        while operationsToReduce.count > 1 {
            let left = Float(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Float(operationsToReduce[2])!

            let result: Float
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
     //       case "x": result = left * right
     //       case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
      return .success(operationsToReduce.first!)

    }
}
