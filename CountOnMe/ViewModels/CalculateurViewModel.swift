//
//  CalculateurViewModel.swift
//  CountOnMe
//
//  Created by Nora Lilla Matyassi on 21/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorViewModelDelegate: AnyObject {
    func calculusHasCompleted(result: String)
    func calculusFailed(errorMessage: String)
}

struct CalculatorViewModel {
    weak var delegate: CalculatorViewModelDelegate?
    private let calculatorBrain = CalculatorBrain()

    var canAddOperator: Bool {
        return calculatorBrain.elements.last != "+" && calculatorBrain.elements.last != "-" && calculatorBrain.elements.last != "÷" && calculatorBrain.elements.last != "x"
    }

    func setCalculusElements(elements: [String]) {
        calculatorBrain.elements = elements
    }

    func executeCalculus() {
        let calculusResult = calculatorBrain.executeCalculus()

        switch calculusResult {
        case .success(let result):
            delegate?.calculusHasCompleted(result: result)

        case .failure(let errorMessage):
            print("\(errorMessage)")
            switch errorMessage {
            case .invalidExpression:
                delegate?.calculusFailed(errorMessage: "invalide expression")

            case .notEnoughElementInExpression:
                delegate?.calculusFailed(errorMessage: "not enough elements")

            case.divideByZero:
                delegate?.calculusFailed(errorMessage: "you can't divide by zero")
            }
        }

    }
    
    func clearAll() {
        calculatorBrain.elements.removeAll()
    }
}
