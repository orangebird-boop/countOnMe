//
//  CalculateurViewModel.swift
//  CountOnMe
//
//  Created by Nora Lilla Matyassi on 21/09/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

protocol CalculatorViewModelDelegate: AnyObject{
    func calculusHasCompleted(result: String)
}

struct CalculatorViewModel {
    weak var delegate: CalculatorViewModelDelegate?
    let calculatorBrain = CalculatorBrain()

    func executeCalculus() {
        let calculusResult = calculatorBrain.executeCalculus()
//i have no idea if this is good or not
        delegate?.calculusHasCompleted(result: "result")
        switch calculusResult{
        case .success(let result):
            print(" \(result)")

        case .failure(let errorMessage):
            print("\(errorMessage)")
            switch errorMessage {
            case .invalidExpression:
                print("invalid expression")

            case .notEnoughElementInExpression:
                print("not enough elements in the expression")
            }
        }

        
    }
}
