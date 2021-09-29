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
        return elements.last != "+" && elements.last != "-" && elements.last != "÷" && elements.last != "x"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

   
/*
    // Addition and substarction
    func performAdditionAndSubstraction(operationsToReduce: [String]) -> [String]? {
        var additionAndSubtraction: [String] = operationsToReduce
        guard let left: Float = Float(additionAndSubtraction[0]) else {
            return nil
        }
        let operand = additionAndSubtraction[1]
        guard let right: Float = Float(additionAndSubtraction[2]) else {
            return nil
        }
        let result: Float
        switch operand {
        case "+": result = left + right
        case "-": result = left - right
        default: return nil
        }
        additionAndSubtraction = Array(additionAndSubtraction.dropFirst(3))
        additionAndSubtraction.insert("\(result)", at: 0)
        return additionAndSubtraction
    }

    // Because of the roule of priorities in matheamthics, the calculator needs to deal with multiplication and division first
    func dealWithPriorities(operationsToReduce: [String]) -> [String]? {
            var priorities: [String] = operationsToReduce
            if let index = priorities.firstIndex(where: { $0 == "x" || $0 == "/"}) {
                guard let left: Float = Float(priorities[index - 1]) else {
                    return nil
                }
                let operand = priorities[index]
                guard let right: Float = Float(priorities[index + 1]) else {
                    return nil
                }
                let result: Float
                switch operand {
                case "x":
                    result = left * right
                case "/":
                    if right == 0 {
                        return nil
                    } else {
                        result = left / right
                    }
                default:
                    return nil
                }
                priorities[index - 1] = "\(result)"
                priorities.remove(at: index)
                priorities.remove(at: index)
            }
            return priorities
        }
*/
    func executeCalculus()-> Result<String, CalculatorBrainError> {
        print("execute calculus34")
        guard expressionIsCorrect else {
            return .failure(.invalidExpression)

        }
        print("expression has enough elements")
        guard expressionHaveEnoughElement else {
            return .failure(.notEnoughElementInExpression)

        }

        // Create local copy of operations
        var operationsToReduce = elements


        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            case "x": result = left * right
            case "÷": result = left / right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
      return .success(operationsToReduce.first!)

    }
}
