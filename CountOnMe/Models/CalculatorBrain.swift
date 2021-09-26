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
        return elements.last != "+" && elements.last != "-"
    }

    var expressionHaveEnoughElement: Bool {
        return elements.count >= 3
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "/" && elements.last != "*"
    }

    func executeCalculus()-> Result<String, CalculatorBrainError> {
        guard expressionIsCorrect else {
            return .failure(.invalidExpression)

        }

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
            case "*": result = left * right
            case "/": result = left / right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        return .success(operationsToReduce.first!)

    }
}
