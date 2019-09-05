//
//  DateExtension.swift
//  RentateamTest
//
//  Created by Виктор Григорьев on 05/09/2019.
//  Copyright © 2019 Виктор Григорьев. All rights reserved.
//

import Foundation

extension Date {
    func getString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
        let stringFromDate = formatter.string(from: self)
        return stringFromDate
    }
}
