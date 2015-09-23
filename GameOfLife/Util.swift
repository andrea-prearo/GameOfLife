//
//  Util.swift
//  GameOfLife
//
//  Created by Prearo, Andrea on 9/21/15.
//
//

infix operator !~= {}

func !~= <I : IntervalType>(value: I.Bound, pattern: I) -> Bool {
    return !(pattern ~= value)
}
