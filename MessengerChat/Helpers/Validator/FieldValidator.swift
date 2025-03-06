//
//  FieldValidator.swift
//  MessengerChat
//
//  Created by sunflow on 3/3/25.
//

import UIKit

class FieldValidator {
    
    func isValid(_ type: FieldType, _ data: String) -> Bool {
        var dataRegex = ""
        switch type {
        case .email:
            dataRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        default:
            dataRegex = "(?=.*[A-Z0-9a-z]).{6,}"
        }
            
        let dataPred = NSPredicate(format: "SELF MATCHES %@", dataRegex)
        return dataPred.evaluate(with: data)
    }
}

enum FieldType {
    case email, password, name
}
