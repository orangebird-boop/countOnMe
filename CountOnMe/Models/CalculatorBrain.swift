//
//  CalculatorBrain.swift
//  CountOnMe
//
//  Created by Nora Lilla Matyassi on 21/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class CalculatorBrain {

    enum CalculatorBrainError: Error, Equatable {
        case invalidExpression
        case divideByZero
        case notEnoughElementInExpression


    }

    var elements: [String?] = []

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "*"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var expressionNotDividedByZero: Bool {
        for element in elements {
            if element == "÷" {
                if elements[elements.index(after: 1)] == "0" {
                    return false
                }
            }
        }
        return true

    }

    func processPriorities()-> [String] {
        var processing: [String] = []

        var index = 0

        while index < elements.count {
            let element = elements[index]
            if element == "*" || element == "÷" {
                // find a way to saftly unwrapp it!!!!
                let leftOperand = Float(processing.popLast()!)
                // let rightOperand = Float(elements[index+1])!

                var rightOperand: Float = 1
                if (elements[index+1]) != nil {
                    if (elements[index+1]) == nil {
                        CalculatorBrainError.invalidExpression
                    }
                    if let unwrappedFLoat = Float(elements[index+1]!) {
                        rightOperand = unwrappedFLoat
                        if element == "÷" && rightOperand == 0 {
                            CalculatorBrainError.invalidExpression
                        }
                    }
                }
                    switch element {
                    case "*": processing.append(String(leftOperand! * rightOperand))
                    case "÷": processing.append(String(leftOperand! / rightOperand))
                    default: fatalError("Unknown operator !")
                }
                index += 1
            } else {
                processing.append(element!)
            }
            index += 1
        }

        return processing
    }



    func executeCalculus()-> Result<String, CalculatorBrainError> {

        guard expressionIsCorrect else {
            return .failure(.invalidExpression)

        }

        guard expressionNotDividedByZero else {
            return .failure(.divideByZero)
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

