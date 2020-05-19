//
//  UITextField.swift
//  ECarLottery
//
//  Created by Aruna Udayanga on 5/19/20.
//  Copyright © 2020 Aruna Udayanga. All rights reserved.

// String convert to Int
extension String
{
    func toInt() -> Int
    {
        let myInt = Int(self)
        return myInt ?? 0
    }
}
