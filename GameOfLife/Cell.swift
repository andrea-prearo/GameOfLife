//
//  Cell.swift
//  GameOfLife
//
//  Created by Prearo, Andrea on 9/21/15.
//
//

import UIKit

class Cell: Hashable {
    let x: Int
    let y: Int
    var state: State
    var neighbours: [Cell]

    var hashValue: Int {
        return (x ^ 16) + (y >> 16);
    }
    
    init (x: Int, y: Int) {
        self.x = x
        self.y = y
        state = .Unknown
        neighbours = [Cell]()
    }

    func fillColor() -> UIColor {
        switch state {
        case .Alive:
            return UIColor.redColor()
        case .Dead, .Unknown:
            return UIColor.blackColor()
        }
    }
}

func == (lhs: Cell, rhs: Cell) -> Bool {
    return lhs.x == rhs.x && lhs.y == rhs.y
}

enum State {
    case Alive, Dead, Unknown
}
