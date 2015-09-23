//
//  World.swift
//  GameOfLife
//
//  Created by Prearo, Andrea on 9/21/15.
//
//

class World {
    let cells: [Cell]
    let width = 25
    let height = 25

    // find neighbours
    lazy var neighboursForCell:(cell: Cell) -> [Cell] = {
        (cell: Cell) -> [Cell] in
        let cellsAreNeighbours = {
            (op1: Cell, op2: Cell) -> Bool in
            let delta = (abs(op1.x - op2.x), abs(op1.y - op2.y))
            switch (delta) {
            case (1,1), (1,0), (0,1):
                return true
            default:
                return false
            }
        }
        
        return self.cells.filter { cellsAreNeighbours(cell, $0) }
    }
    
    init() {
        var newCells = [Cell]()
        for x in 0..<width {
            for y in 0..<height {
                newCells.append(Cell(x: x, y: y))
            }
        }
        cells = newCells
    }

    subscript (x: Int, y: Int) -> Cell? {
        return cells.filter { $0.x == x && $0.y == y }.first
    }

    func evolve() {
        let livingNeighboursForCell = {
            (cell: Cell) -> Int in
            self.neighboursForCell(cell: cell).filter{ $0.state == State.Alive }.count
        }
        
        // rules of life
        let liveCells = cells.filter { $0.state == .Alive }
        let deadCells = cells.filter { $0.state != .Alive }
        
        let dyingCells = liveCells.filter { livingNeighboursForCell($0) !~= 2...3 }
        let newLife =  deadCells.filter { livingNeighboursForCell($0) == 3 }
        
        // updating the world state
        newLife.map { (cell: Cell) in cell.state = .Alive }
        dyingCells.map { (cell: Cell) in cell.state = .Dead }
    }
}
