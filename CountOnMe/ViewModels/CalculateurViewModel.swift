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
}

struct CalculatorViewModel {
    weak var delegate: CalculatorViewModelDelegate?
    let calculatorBrain = CalculatorBrain()

    func executeCalculus() {
        let calculusResult = calculatorBrain.executeCalculus()
// i have no idea if this is good or not
        print("view model line 22")
        delegate?.calculusHasCompleted(result: "calculusResult")
print("calculus has completed")
        print(calculusResult)
        switch calculusResult {
        case .success(let result):
            print(" \(result)")
            print("result CVM 28")

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
